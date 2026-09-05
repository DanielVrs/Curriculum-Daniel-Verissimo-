#!/usr/bin/env bash
# Gera assets/Daniel-Verissimo-CV.pdf (PT) e assets/Daniel-Verissimo-CV-EN.pdf (EN)
# a partir do proprio site, usando o Chrome headless e o CSS de impressao.
# Uso: ./gerar-pdf.sh            (detecta o Chrome sozinho)
#      CHROME=/caminho/chrome ./gerar-pdf.sh
set -euo pipefail
cd "$(dirname "$0")"

CHROME="${CHROME:-}"
if [ -z "$CHROME" ]; then
  for c in google-chrome google-chrome-stable chromium chromium-browser; do
    command -v "$c" >/dev/null 2>&1 && CHROME="$(command -v "$c")" && break
  done
fi
[ -z "$CHROME" ] && CHROME="$(ls ~/.cache/puppeteer/chrome/linux-*/chrome-linux64/chrome 2>/dev/null | head -1 || true)"
[ -z "$CHROME" ] && { echo "Chrome nao encontrado. Defina CHROME=/caminho/do/chrome"; exit 1; }

PORTA=8799
TMP="$(mktemp -d)"
trap 'kill "${PID_PT:-}" "${PID_EN:-}" 2>/dev/null || true; rm -rf "$TMP"' EXIT

# copia EN: mesma pagina, com clique automatico no botao EN
cp -r . "$TMP/en" && rm -rf "$TMP/en/.git"
sed -i 's|<script src="script.js"></script>|<script src="script.js"></script><script>document.querySelector(".lang-btn[data-lang=en]").click();</script>|' "$TMP/en/index.html"

python3 -m http.server "$PORTA" --bind 127.0.0.1 >/dev/null 2>&1 & PID_PT=$!
(cd "$TMP/en" && python3 -m http.server $((PORTA+1)) --bind 127.0.0.1 >/dev/null 2>&1) & PID_EN=$!
sleep 1

FLAGS="--headless=new --no-sandbox --disable-gpu --virtual-time-budget=10000 --no-pdf-header-footer"
"$CHROME" $FLAGS --print-to-pdf="assets/Daniel-Verissimo-CV.pdf"    "http://127.0.0.1:$PORTA/"          2>/dev/null
"$CHROME" $FLAGS --print-to-pdf="assets/Daniel-Verissimo-CV-EN.pdf" "http://127.0.0.1:$((PORTA+1))/"   2>/dev/null

ls -la assets/*.pdf
