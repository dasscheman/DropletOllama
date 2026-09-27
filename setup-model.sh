#!/usr/bin/env bash

set -euo pipefail

MODEL="${1:-qwen2.5-coder:7b}"

if ! command -v ollama >/dev/null 2>&1; then
    echo "Fout: Ollama is niet geïnstalleerd."
    echo "Voer eerst ./install-ollama.sh uit."
    exit 1
fi

echo "==> Model downloaden: ${MODEL}"

ollama pull "$MODEL"

echo
echo "Model geïnstalleerd:"
echo "  $MODEL"

echo
echo "Test het model met:"
echo "  ollama run $MODEL"