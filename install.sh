#!/bin/bash
# Установка Чистюли одной командой:
#   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/MrPacmann/Chistyulya-releases/main/install.sh)"
set -e

echo "❄️  Скачиваю Чистюлю…"
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

# /releases/latest/download/ — всегда отдаёт свежую версию
curl -fSL --progress-bar -o "$TMP/Chistyulya.zip" \
  "https://github.com/MrPacmann/Chistyulya-releases/releases/latest/download/Chistyulya-macOS.zip"

echo "📦  Распаковываю…"
ditto -x -k "$TMP/Chistyulya.zip" "$TMP"

DEST="/Applications"
[ -w "$DEST" ] || DEST="$HOME/Applications"
mkdir -p "$DEST"
rm -rf "$DEST/Чистюля.app"
mv "$TMP/Чистюля.app" "$DEST/Чистюля.app"

# Снимаем карантин (если вдруг есть) — приложение собрано без сертификата Apple
xattr -dr com.apple.quarantine "$DEST/Чистюля.app" 2>/dev/null || true

open "$DEST/Чистюля.app"
echo ""
echo "✅  Готово! Чистюля установлена в $DEST и уже запущена —"
echo "    ищите снежинку в строке меню справа."
echo ""
echo "    Обновления прилетают сами: меню снежинки → «Проверить обновления»."
echo "    Автозапуск: Системные настройки → Основные → Объекты входа → + → Чистюля."
