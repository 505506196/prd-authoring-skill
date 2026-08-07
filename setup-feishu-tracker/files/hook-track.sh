#!/bin/bash
# ============================================================
# AI 资产使用追踪 - UserPromptSubmit Hook（飞书版）
# 自动捕获 /skill 命令并上报埋点
# ============================================================

TRACKER_VERSION="2.0.0"  # 供 install/注入环节 grep 做版本检查（R1），勿删
DEFAULT_WEBHOOK_URL="https://yf2ljykclb.xfchat.iflytek.com/base/automation/webhook/event/Hj5SaSl8ZwzU8WhAuFuruP9szSg"
CONFIG_FILE="$HOME/.claude/feishu-tracker/config.json"
IDENTITY_FILE="$HOME/.claude/feishu-tracker/identity.json"

# 没注册身份就不发（提前于 config 读取：hook 每条消息触发，未登记机器不必白付 python3 启动开销）
[ ! -f "$IDENTITY_FILE" ] && exit 0

WEBHOOK_URL="$DEFAULT_WEBHOOK_URL"
if [ -f "$CONFIG_FILE" ]; then
  CFG_URL=$(CONFIG_FILE="$CONFIG_FILE" python3 -c "import json,os;print(json.load(open(os.environ['CONFIG_FILE'])).get('webhook_url',''))" 2>/dev/null)
  [ -n "$CFG_URL" ] && WEBHOOK_URL="$CFG_URL"
fi

# 从 stdin 读 hook 数据
INPUT=$(cat)

# 解析 skill 名称：过滤内置命令，并以"本机实际安装"为真值表
# （修复：拖入文件路径 /Users/... 或手滑斜杠开头的句子被误统计为 skill；
#   不用字符集白名单——团队存在中文名 skill，存在性检查对其同样有效）
RESULT=$(echo "$INPUT" | python3 -c "
import sys, json, os, re
try:
    data = json.load(sys.stdin)
    prompt = data.get('prompt', data.get('user_prompt', '')).strip()
    cwd = data.get('cwd', '')
    if prompt.startswith('/') and not prompt.startswith('//'):
        skill_name = prompt.split(None, 1)[0][1:]
        builtins = {'help','clear','quit','exit','compact','cost','login','logout',
                     'fast','status','memory','config','doctor','bug','review',
                     'init','listen','mcp','model','permissions','terminal-setup',
                     'vim','emacs','loop','schedule','diff','pr','approved','rejected',
                     'setup-tracker','setup-feishu-tracker'}
        def installed(n):
            if not n or '/' in n or '..' in n:
                return False
            home = os.path.expanduser('~')
            paths = [
                os.path.join(home, '.claude', 'skills', n),
                os.path.join(home, '.claude', 'commands', n + '.md'),
            ]
            if cwd:
                paths.append(os.path.join(cwd, '.claude', 'skills', n))
                paths.append(os.path.join(cwd, '.claude', 'commands', n + '.md'))
            return any(os.path.exists(p) for p in paths)
        ok = False
        if skill_name and skill_name.lower() not in builtins:
            if ':' in skill_name:
                # 插件形式（plugin:skill）：无统一安装目录可查，按 ASCII 命名规则校验
                ok = bool(re.fullmatch(r'[A-Za-z0-9][A-Za-z0-9_-]*:[A-Za-z0-9][A-Za-z0-9_-]*', skill_name))
            else:
                ok = installed(skill_name)
        session = data.get('session_id', '')
        print(f'TRACK:{skill_name}\t{session}' if ok else 'SKIP')
    else:
        print('SKIP')
except:
    print('SKIP')
" 2>/dev/null)

[[ "$RESULT" != TRACK:* ]] && exit 0
REST="${RESULT#TRACK:}"
SKILL_NAME="${REST%%$'\t'*}"
HOOK_SESSION="${REST#*$'\t'}"
[ "$HOOK_SESSION" = "$REST" ] && HOOK_SESSION=""
SESSION_ID="${HOOK_SESSION:-${CLAUDE_SESSION_ID:-$(date +%s)}}"

USER_NAME="$(whoami)"
HOST_NAME="$(hostname -s 2>/dev/null || hostname)"

PAYLOAD=$(IDENTITY_FILE="$IDENTITY_FILE" \
          SKILL_NAME="$SKILL_NAME" \
          USER_NAME="$USER_NAME" \
          HOST_NAME="$HOST_NAME" \
          SESSION_ID="$SESSION_ID" \
  python3 - <<'PYEOF'
import json, os
with open(os.environ["IDENTITY_FILE"]) as f:
  d = json.load(f)
print(json.dumps({
  "user_id": d.get("user_id", ""),
  "name": d.get("name", ""),
  "dept": d.get("dept", ""),
  "source": "cli",
  "asset": os.environ["SKILL_NAME"],
  "type": "skill",
  "trigger": "hook",
  "session": os.environ["SESSION_ID"],
  "user": os.environ["USER_NAME"],
  "host": os.environ["HOST_NAME"],
  "extra": "",
}, ensure_ascii=False))
PYEOF
)

[ -z "$PAYLOAD" ] && exit 0

if [ -n "${FEISHU_TRACK_DRYRUN:-}" ]; then
  echo "URL: $WEBHOOK_URL"
  echo "$PAYLOAD"
  exit 0
fi

# --noproxy '*' 强制直连
curl -s --max-time 5 --noproxy '*' -L -X POST "$WEBHOOK_URL" \
  -H "Content-Type: application/json" \
  -d "$PAYLOAD" > /dev/null 2>&1 &

exit 0
