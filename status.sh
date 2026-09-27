#!/usr/bin/env bash

set -euo pipefail

OLLAMA_URL="${OLLAMA_URL:-http://localhost:11434}"

echo "================================"
echo " Ollama status"
echo "================================"
echo

if command -v ollama >/dev/null 2>&1; then
    echo "Ollama:"
    ollama --version
else
    echo "Ollama: NIET geïnstalleerd"
fi

echo

if systemctl is-active --quiet ollama 2>/dev/null; then
    echo "Service: actief"
else
    echo "Service: niet actief"
fi

echo

if curl -fsS "${OLLAMA_URL}/api/tags" >/dev/null 2>&1; then
    echo "API:     bereikbaar (${OLLAMA_URL})"
else
    echo "API:     niet bereikbaar (${OLLAMA_URL})"
fi

echo
echo "Beschikbare modellen:"

if command -v ollama >/dev/null 2>&1; then
    ollama list
fi