#!/usr/bin/env bash

set -euo pipefail

if ! command -v ollama >/dev/null 2>&1; then
    echo "Fout: Ollama is niet geïnstalleerd."
    echo "Voer eerst ./install-ollama.sh uit."
    exit 1
fi

# Als een model als argument is meegegeven, gebruik dat model direct.
if [[ $# -ge 1 ]]; then
    MODEL="$1"

    echo "==> Model starten: ${MODEL}"
    echo

    ollama run "$MODEL"
    exit 0
fi

# Controleer of er modellen geïnstalleerd zijn.
mapfile -t MODELS < <(ollama list | tail -n +2 | awk '{print $1}')

if [[ ${#MODELS[@]} -eq 0 ]]; then
    echo "Er zijn geen Ollama-modellen geïnstalleerd."
    echo
    echo "Installeer bijvoorbeeld:"
    echo "  ./setup-model.sh qwen2.5-coder:7b"
    exit 1
fi

echo "================================"
echo " Ollama model kiezen"
echo "================================"
echo

for i in "${!MODELS[@]}"; do
    printf "  %d) %s\n" "$((i + 1))" "${MODELS[$i]}"
done

echo
read -rp "Kies een model [1-${#MODELS[@]}]: " CHOICE

# Controleer of de invoer een geldig getal is.
if ! [[ "$CHOICE" =~ ^[0-9]+$ ]]; then
    echo "Ongeldige keuze."
    exit 1
fi

if (( CHOICE < 1 || CHOICE > ${#MODELS[@]} )); then
    echo "Ongeldige keuze."
    exit 1
fi

MODEL="${MODELS[$((CHOICE - 1))]}"

echo
echo "==> Model starten: ${MODEL}"
echo

ollama run "$MODEL"