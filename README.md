# AI Model Local Server

Local Docker stack for Ollama and Open WebUI, intended for coding and computer-science assistance on this machine and other computers on the same LAN.

## Services

- Ollama API: `http://localhost:11434`
- Open WebUI: `http://localhost:3000`
- OpenClaw gateway: local process managed by `ollama launch openclaw`

From another computer on the same local network, replace `localhost` with this machine's LAN IP:

- Open WebUI: `http://<host-ip>:3000`
- Ollama API: `http://<host-ip>:11434`

## Models

Initial lightweight models:

- `qwen2.5-coder:7b`
- `qwen2.5:7b`

OpenClaw uses `qwen2.5-coder:7b` by default through Ollama, with `qwen2.5:7b` as the local fallback in `openclaw.local.example.json5`.

## Start

Optional: copy `.env.example` to `.env` and set `HF_TOKEN` if you want higher Hugging Face download limits for Open WebUI startup assets.

```bash
docker compose up -d
```

Default Compose uses CPU-compatible images. On a machine with a working NVIDIA Container Toolkit, use the GPU override:

```bash
docker compose -f docker-compose.yml -f docker-compose.gpu.yml up -d
```

## Pull Models

Git Bash / WSL:

```bash
./init-models.sh
```

PowerShell:

```powershell
.\init-models.ps1
```

## Validate

```bash
docker compose ps
curl http://localhost:11434/api/tags
docker exec ollama ollama list
```

Open `http://localhost:3000` in a browser and select one of the Qwen models.

## OpenClaw Telegram Bot

OpenClaw is configured as a local assistant gateway that can use this machine's Ollama models and answer through Telegram.

One-time setup:

1. Install the host `ollama` CLI if you want to run OpenClaw directly on the host. If it is not available, the starter scripts fall back to the running Docker container named `ollama`.

2. Start Ollama:

```bash
docker compose up -d
```

3. Pull the local models:

```bash
./init-models.sh
```

4. Create a Telegram bot with `@BotFather`, then put the token only in your local shell or local `.env`. The starter scripts load `.env` automatically:

```bash
export TELEGRAM_BOT_TOKEN="123:abc"
export OPENCLAW_MODEL="qwen2.5-coder:7b"
```

5. Start OpenClaw:

```bash
./start-openclaw.sh
```

PowerShell:

```powershell
$env:TELEGRAM_BOT_TOKEN = "123:abc"
$env:OPENCLAW_MODEL = "qwen2.5-coder:7b"
.\start-openclaw.ps1
```

The example config is in `openclaw.local.example.json5`. It uses Ollama's native API at `http://127.0.0.1:11434` and intentionally does not use `/v1`, because OpenClaw's Ollama integration expects the native API for reliable local tool use.

Telegram access defaults to pairing mode. After the gateway starts, use:

```bash
openclaw pairing list telegram
openclaw pairing approve telegram <CODE>
```

For groups, add the bot to the group and mention `@openclaw` or `openclaw` so group messages are intentionally gated.

## LAN Access

Find the host IP:

```powershell
ipconfig
```

Use the IPv4 address from your active network adapter. If another computer cannot connect, allow inbound TCP ports `3000` and `11434` in Windows Firewall for the private network.

## Scope

This v1 stack is LAN-only and does not include public internet exposure, TLS, reverse proxy, user hardening, RAG, fine-tuning, or monitoring.
