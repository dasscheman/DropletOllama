#!/usr/bin/env bash

set -euo pipefail

OLLAMA_URL="${OLLAMA_URL:-http://localhost:11434}"
MODEL="${1:-qwen2.5-coder:7b}"

echo "==> Ollama API testen"
echo "URL:   ${OLLAMA_URL}"
echo "Model: ${MODEL}"
echo

if ! curl -fsS "${OLLAMA_URL}/api/tags" >/dev/null; then
    echo "Fout: Ollama API is niet bereikbaar."
    echo
    echo "Controleer bijvoorbeeld:"
    echo "  sudo systemctl status ollama"
    echo
    echo "Of start Ollama handmatig:"
    echo "  ollama serve"
    exit 1
fi

echo "Ollama API is bereikbaar."
echo

curl -fsS "${OLLAMA_URL}/api/chat" \
    -H "Content-Type: application/json" \
    -d "$(cat <<EOF
{
  "model": "${MODEL}",
  "messages": [
    {
      "role": "user",
      "content": "Geef één korte zin waarin je bevestigt dat Ollama werkt."
    }
  ],
  "stream": false
}
EOF
)"

echo
echo
echo "API-test voltooid."