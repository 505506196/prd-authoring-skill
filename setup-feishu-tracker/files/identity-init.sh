#!/bin/bash
# ============================================================
# AI 资产追踪 - 身份注册（一次性）
# 首次运行：交互式问姓名+部门 → 生成 UUID → 写入 identity.json
# 已存在：显示当前身份，直接退出
# ============================================================

set -e

IDENTITY_FILE="$HOME/.claude/feishu-tracker/identity.json"
mkdir -p "$(dirname "$IDENTITY_FILE")"

if [ -f "$IDENTITY_FILE" ]; then
  echo "✅ 身份已注册：$IDENTITY_FILE"
  cat "$IDENTITY_FILE"
  echo
  echo "如需重置，删除该文件后重新运行此脚本。"
  exit 0
fi

# ── v2: 非交互参数模式（Claude 会话内登记调用）──
TRACKER_VERSION="2.0.0"
NAME=""; DEPT=""
while [ $# -gt 0 ]; do
  case "$1" in
    --name)
      [ $# -lt 2 ] && { echo "❌ --name 缺少值"; exit 1; }
      NAME="$2"; shift; shift ;;
    --dept)
      [ $# -lt 2 ] && { echo "❌ --dept 缺少值"; exit 1; }
      DEPT="$2"; shift; shift ;;
    *) echo "❌ 未知参数: $1（支持 --name --dept）"; exit 1 ;;
  esac
done

if [ -n "$NAME$DEPT" ]; then
  # 走了参数模式就必须两个都给，缺一报错（不回落交互，避免非交互环境卡死）
  if [ -z "$NAME" ] || [ -z "$DEPT" ]; then
    echo "❌ 参数模式需同时提供 --name 和 --dept"
    exit 1
  fi
else
  # ── v1: 交互模式（终端兜底）──
  echo "==================================="
  echo "  AI 资产追踪 - 身份注册（一次性）"
  echo "==================================="
  echo "用于团队埋点统计，姓名和部门必填。"
  echo
  read -p "姓名（必填）: " NAME
  [ -z "$NAME" ] && { echo "❌ 姓名不能为空"; exit 1; }
  read -p "部门（必填，例：体验中心3部）: " DEPT
  [ -z "$DEPT" ] && { echo "❌ 部门不能为空"; exit 1; }
fi

# 生成 UUID（多种兜底）
if command -v uuidgen >/dev/null 2>&1; then
  UUID=$(uuidgen | tr '[:upper:]' '[:lower:]')
elif [ -f /proc/sys/kernel/random/uuid ]; then
  UUID=$(cat /proc/sys/kernel/random/uuid)
else
  UUID=$(python3 -c "import uuid; print(uuid.uuid4())")
fi

NOW=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# 用 Python 写 JSON，env 传值避免 shell 转义问题
NAME="$NAME" DEPT="$DEPT" UUID="$UUID" NOW="$NOW" PYTHONUTF8=1 \
  python3 - <<'PYEOF' > "$IDENTITY_FILE"
import json, os
print(json.dumps({
  "user_id": os.environ["UUID"],
  "name": os.environ["NAME"],
  "dept": os.environ["DEPT"],
  "created_at": os.environ["NOW"]
}, ensure_ascii=False, indent=2))
PYEOF

chmod 600 "$IDENTITY_FILE"

echo
echo "✅ 身份已保存到 $IDENTITY_FILE"
echo "   user_id: $UUID"
echo "   name:    $NAME"
echo "   dept:    $DEPT"
