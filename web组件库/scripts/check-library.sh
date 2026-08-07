#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

failures=0
pass() { printf 'PASS  %s\n' "$1"; }
fail() { printf 'FAIL  %s\n' "$1"; failures=$((failures + 1)); }

python3 -m json.tool design-tokens.json >/dev/null \
  && pass "design-tokens.json JSON 语法" \
  || fail "design-tokens.json JSON 语法"

if python3 - <<'PY'
import json, re
from pathlib import Path
t = json.loads(Path('design-tokens.json').read_text())
css = Path('dist/shekao-ui.css').read_text()
checks = {
  '--primary-600': t['color']['primitive']['primary']['600']['$value'],
  '--primary-500': t['color']['primitive']['primary']['500']['$value'],
  '--primary-700': t['color']['primitive']['primary']['700']['$value'],
  '--danger-500': t['color']['primitive']['danger']['500']['$value'],
  '--bg-page': t['color']['primitive']['neutral']['50']['$value'],
}
for name, value in checks.items():
    if not re.search(rf'{re.escape(name)}\s*:\s*{re.escape(value)}\s*;', css, re.I):
        raise SystemExit(f'{name} mismatch')
PY
then
  pass "Token JSON 与 dist 核心值一致"
else
  fail "Token JSON 与 dist 核心值一致"
fi

[[ -f preview.html && -f dist/shekao-ui.css && -f dist/shekao-ui.js ]] \
  && pass "核心交付文件存在" \
  || fail "核心交付文件存在"

if rg -q -- 'background: var\(--bg-page\);' dist/shekao-ui.css \
   && rg -q -- '\.sk-grid-bg' dist/shekao-ui.css; then
  pass "后台纯色背景 + 可选网格"
else
  fail "后台纯色背景 + 可选网格"
fi

if rg -q -U -- '\.btn--primary \{\n  background: var\(--primary-600\);' dist/shekao-ui.css; then
  pass "主按钮为实色"
else
  fail "主按钮为实色"
fi

if rg -q -- '--r-tag:[[:space:]]+var\(--r-sm\)' dist/shekao-ui.css; then
  pass "静态 Tag 使用 4px 圆角"
else
  fail "静态 Tag 使用 4px 圆角"
fi

if rg -n '#2378FA|#0056D4|#2463EB|#10B981|#EF4444' dist preview.html >/tmp/shekao-color-errors.txt; then
  fail "运行时仍有旧色：$(head -n 1 /tmp/shekao-color-errors.txt)"
else
  pass "运行时无旧色污染"
fi

if rg -q 'href="shekao-ui.css"' dist/验证页.html \
   && rg -q 'src="shekao-ui.js"' dist/验证页.html; then
  pass "验证页引用 dist 产物"
else
  fail "验证页引用 dist 产物"
fi

if rg -n --glob '!archive/**' --glob '!scripts/**' --glob '!组件库-v1备份-*.zip' 'data-theme="pilot"|:root\[data-theme="pilot"\]' . >/tmp/shekao-theme-errors.txt; then
  fail "仍存在旧主题 pilot：$(head -n 1 /tmp/shekao-theme-errors.txt)"
else
  pass "主题名统一为 new-style"
fi

if rg -n --glob '!archive/**' --glob '!scripts/**' --glob '!组件库-v1备份-*.zip' 'foundations-新风格|components-新风格' . >/tmp/shekao-path-errors.txt; then
  fail "仍存在旧目录名：$(head -n 1 /tmp/shekao-path-errors.txt)"
else
  pass "规范目录引用有效"
fi

for selector in '.btn' '.input' '.tag' '.sk-card' '.tbl' '.dialog' '.drawer' '.nav-sb'; do
  if rg -q -F "$selector" dist/shekao-ui.css; then
    pass "组件存在 $selector"
  else
    fail "组件缺失 $selector"
  fi
done

if [[ "$failures" -gt 0 ]]; then
  printf '\n%d 项检查失败。\n' "$failures"
  exit 1
fi

printf '\n组件库一致性检查通过。\n'
