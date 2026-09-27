#!/usr/bin/env bash

set -euo pipefail

echo "==> Ollama installeren..."

if ! command -v curl >/dev/null 2>&1; then
    echo "Fout: curl is niet geïnstalleerd."
    echo "Installeer curl met bijvoorbeeld:"
    echo "  sudo apt install curl"
    exit 1
fi

curl -fsSL https://ollama.com/install.sh | sh

echo
echo "==> Installatie controleren..."
ollama --version

echo
echo "==> Ollama service controleren..."

if systemctl is-active --quiet ollama 2>/dev/null; then
    echo "Ollama draait."
else
    echo "Ollama draait nog niet als systemd-service."
    echo "Probeer:"
    echo "  sudo systemctl start ollama"
fi

echo
echo "Installatie voltooid."