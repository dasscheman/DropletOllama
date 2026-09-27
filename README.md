# Ollama lokaal op Linux

Deze repository bevat scripts om [Ollama](https://ollama.com/) lokaal op Linux te installeren, een lokaal AI-model te downloaden en de Ollama API te testen.

De setup is bedoeld voor gebruik vanuit bijvoorbeeld PhpStorm.
## Bestanden

```text
ollama-local/
├── README.md
├── install-ollama.sh
├── setup-model.sh
├── test-api.sh
└── status.sh
```

### `install-ollama.sh`

Installeert Ollama en controleert de installatie.

### `setup-model.sh`

Downloadt een Ollama-model.

Standaard wordt gebruikt:

```text
qwen2.5-coder:7b
```

### `test-api.sh`

Controleert of de lokale Ollama API bereikbaar is en stuurt een testprompt naar het model.

### `status.sh`

Geeft de status van Ollama, de API en de geïnstalleerde modellen weer.

## Installatie

Maak de scripts uitvoerbaar:

```bash
chmod +x *.sh
```

Installeer Ollama:

```bash
./install-ollama.sh
```

Controleer de status:

```bash
./status.sh
```

## Model installeren

Installeer het standaardmodel:

```bash
./setup-model.sh
```

Of kies zelf een model:

```bash
./setup-model.sh qwen2.5-coder:7b
```

Daarna kun je het model rechtstreeks testen:

```bash
ollama run qwen2.5-coder:7b
```

## API testen

Test de lokale API:

```bash
./test-api.sh
```

De standaard API is:

```text
http://localhost:11434
```

Controleer bijvoorbeeld beschikbare modellen met:

```bash
curl http://localhost:11434/api/tags
```

## OpenAI-compatible API

Ollama biedt ook een OpenAI-compatible API.

De base URL is:

```text
http://localhost:11434/v1
```

Bijvoorbeeld:

```text
Provider:  OpenAI-compatible
Base URL:  http://localhost:11434/v1
Model:     qwen2.5-coder:7b
API key:   ollama
```

### API-key

Voor een lokale Ollama-server is normaal gesproken **geen echte API-key nodig**.

Wanneer een client verplicht een API-key vraagt, kun je bijvoorbeeld:

```text
ollama
```

gebruiken.

De lokale Ollama-server gebruikt deze waarde niet als authenticatie.

## PhpStorm

Als PhpStorm op dezelfde Linux-machine draait, gebruik:

```text
http://localhost:11434/v1
```

als OpenAI-compatible base URL.

Gebruik vervolgens bijvoorbeeld:

```text
Model: qwen2.5-coder:7b
API key: ollama
```

De exacte instellingen zijn afhankelijk van de PhpStorm-versie en de gebruikte AI-functionaliteit/plugin.

## PhpStorm op een andere computer

Als PhpStorm op een andere machine draait, werkt:

```text
http://localhost:11434/v1
```

niet.

`localhost` verwijst dan namelijk naar de computer waarop PhpStorm draait.

Je moet in dat geval Ollama via het netwerk beschikbaar maken en bijvoorbeeld:

```text
http://192.168.1.50:11434/v1
```

gebruiken.

Vervang `192.168.1.50` door het IP-adres van de Linux-machine.

Let hierbij op firewall- en netwerkbeveiliging. Stel een Ollama-server niet zonder aanvullende beveiliging rechtstreeks bloot aan het internet.

## Handmatige API-test

Chat request:

```bash
curl http://localhost:11434/api/chat \
  -H "Content-Type: application/json" \
  -d '{
    "model": "qwen2.5-coder:7b",
    "messages": [
      {
        "role": "user",
        "content": "Schrijf een PHP functie die een array sorteert."
      }
    ],
    "stream": false
  }'
```

## PHP voorbeeld

Een PHP-applicatie kan rechtstreeks met Ollama communiceren:

```php
<?php

$ch = curl_init('http://localhost:11434/api/chat');

$data = [
    'model' => 'qwen2.5-coder:7b',
    'messages' => [
        [
            'role' => 'user',
            'content' => 'Leg dependency injection uit in PHP.'
        ]
    ],
    'stream' => false
];

curl_setopt_array($ch, [
    CURLOPT_POST => true,
    CURLOPT_HTTPHEADER => [
        'Content-Type: application/json',
    ],
    CURLOPT_POSTFIELDS => json_encode($data),
    CURLOPT_RETURNTRANSFER => true,
]);

$response = curl_exec($ch);

if ($response === false) {
    throw new RuntimeException(curl_error($ch));
}

curl_close($ch);

echo $response;
```

## Problemen oplossen

### Ollama draait niet

Controleer:

```bash
sudo systemctl status ollama
```

Start de service:

```bash
sudo systemctl start ollama
```

Of draai Ollama handmatig:

```bash
ollama serve
```

### API is niet bereikbaar

Test:

```bash
curl http://localhost:11434/api/tags
```

Als dit niet werkt, controleer dan of Ollama draait:

```bash
./status.sh
```

### Model ontbreekt

Bekijk geïnstalleerde modellen:

```bash
ollama list
```

Download het model:

```bash
ollama pull qwen2.5-coder:7b
```

## Snelle setup

Voor een nieuwe Linux-machine:

```bash
chmod +x *.sh
./install-ollama.sh
./setup-model.sh
./test-api.sh
```

Daarna is de lokale API beschikbaar via:

```text
http://localhost:11434
```

en de OpenAI-compatible API via:

```text
http://localhost:11434/v1
```
