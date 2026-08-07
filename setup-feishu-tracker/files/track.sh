#!/bin/bash
# ============================================================
# AI 资产使用追踪 - 埋点上报（飞书版）v2
# v1 用法（兼容）: track.sh <asset> [type] [extra]
# v2 用法: track.sh <asset> --event <name> --version <ver> --run <id>
#                   [--type skill] [--trigger inline] [--extra "备注"]
# 数据原则：宁可个别脏数据，不可丢数据——解析异常退化上报（parse-error: 进 extra）
# 测试：FEISHU_TRACK_DRYRUN=1 打印 URL+payload 不发送
# ============================================================
TRACKER_VERSION="2.0.0"  # 供 install/注入环节 grep 做版本检查（R1），勿删

# 默认上报到「需求诊断」使用统计表（高斯航/社考产品部维护）；如需改表，在 config.json 配 webhook_url 覆盖
DEFAULT_WEBHOOK_URL="https://yf2ljykclb.xfchat.iflytek.com/base/automation/webhook/event/NS5IaFRAewmgNKhSWECrHGn6zPD"
CONFIG_FILE="$HOME/.claude/feishu-tracker/config.json"
IDENTITY_FILE="$HOME/.claude/feishu-tracker/identity.json"

# 没注册身份就不发（v2 流程中身份由强制登记保证；提前于 config 读取省一次 python3）
[ ! -f "$IDENTITY_FILE" ] && exit 0

WEBHOOK_URL="$DEFAULT_WEBHOOK_URL"
if [ -f "$CONFIG_FILE" ]; then
  CFG_URL=$(CONFIG_FILE="$CONFIG_FILE" PYTHONUTF8=1 python3 -c "import json,os;print(json.load(open(os.environ['CONFIG_FILE'],encoding='utf-8')).get('webhook_url',''))" 2>/dev/null)
  [ -n "$CFG_URL" ] && WEBHOOK_URL="$CFG_URL"
fi

ASSET_NAME="${1:-unknown}"
[ $# -gt 0 ] && shift

EVENT=""; VERSION=""; RUN_ID=""; ASSET_TYPE="skill"; TRIGGER=""; EXTRA=""; PARSE_ERR=""

if [ $# -gt 0 ] && [ "${1#--}" != "$1" ]; then
  # ── v2 flag 模式 ──
  TRIGGER="inline"
  while [ $# -gt 0 ]; do
    case "$1" in
      --event|--version|--run|--type|--trigger|--extra)
        if [ $# -lt 2 ]; then PARSE_ERR="$PARSE_ERR $1(缺值)"; break; fi
        case "$1" in
          --event)   EVENT="$2" ;;
          --version) VERSION="$2" ;;
          --run)     RUN_ID="$2" ;;
          --type)    ASSET_TYPE="$2" ;;
          --trigger) TRIGGER="$2" ;;
          --extra)   EXTRA="$2" ;;
        esac
        shift 2 ;;
      *) PARSE_ERR="$PARSE_ERR $1"; shift ;;
    esac
  done
  # 退化上报：解析不了的参数进 extra，绝不丢弃整条数据
  [ -n "$PARSE_ERR" ] && EXTRA="parse-error:$PARSE_ERR${EXTRA:+ | $EXTRA}"
else
  # ── v1 位置参数模式 ──（ASSET_NAME 取走后已 shift：此时 $1=原$2(type)，$2=原$3(extra)）
  TRIGGER="manual"
  ASSET_TYPE="${1:-skill}"
  EXTRA="${2:-}"
fi

USER_NAME="$(whoami)"
HOST_NAME="$(hostname -s 2>/dev/null || hostname)"
SESSION_ID="${RUN_ID:-${CLAUDE_SESSION_ID:-$(date +%s)}}"

PAYLOAD=$(IDENTITY_FILE="$IDENTITY_FILE" \
          ASSET_NAME="$ASSET_NAME" ASSET_TYPE="$ASSET_TYPE" \
          EVENT="$EVENT" VERSION="$VERSION" TRIGGER="$TRIGGER" \
          EXTRA="$EXTRA" USER_NAME="$USER_NAME" HOST_NAME="$HOST_NAME" \
          SESSION_ID="$SESSION_ID" PYTHONUTF8=1 \
  python3 - <<'PYEOF'
import json, os
with open(os.environ["IDENTITY_FILE"], encoding="utf-8") as f:
  d = json.load(f)
print(json.dumps({
  "user_id": d.get("user_id", ""),
  "name": d.get("name", ""),
  "dept": d.get("dept", ""),
  "source": "cli",
  "asset": os.environ["ASSET_NAME"],
  "type": os.environ["ASSET_TYPE"],
  "trigger": os.environ["TRIGGER"],
  "session": os.environ["SESSION_ID"],
  "user": os.environ["USER_NAME"],
  "host": os.environ["HOST_NAME"],
  "extra": os.environ["EXTRA"],
  "event": os.environ["EVENT"],
  "version": os.environ["VERSION"],
}, ensure_ascii=False))
PYEOF
)

[ -z "$PAYLOAD" ] && exit 0

if [ -n "${FEISHU_TRACK_DRYRUN:-}" ]; then
  echo "URL: $WEBHOOK_URL"
  echo "$PAYLOAD"
  exit 0
fi

# 写临时文件用 --data-binary @file 发送：
# Git Bash(MSYS2) 调用原生 curl.exe 时，-d "字符串" 命令行参数会被 MSYS2
# 从 UTF-8 转成 Windows 代码页(GBK)，导致中文乱码。写文件按原字节读则绕开此转换。
PAYLOAD_FILE=$(mktemp 2>/dev/null || echo "${TMPDIR:-/tmp}/track_payload_$$.json")
printf '%s' "$PAYLOAD" > "$PAYLOAD_FILE"

curl -s --max-time 5 --noproxy '*' -L -X POST "$WEBHOOK_URL" \
  -H "Content-Type: application/json; charset=utf-8" \
  --data-binary "@$PAYLOAD_FILE" > /dev/null 2>&1
rm -f "$PAYLOAD_FILE"

exit 0
