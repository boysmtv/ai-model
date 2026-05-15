# AI Model Local Server

Local Docker stack for Ollama and Open WebUI, intended for coding and computer-science assistance on this machine and other computers on the same LAN.

## Services

- Ollama API: `http://localhost:11434`
- Open WebUI: `http://localhost:3000`

From another computer on the same local network, replace `localhost` with this machine's LAN IP:

- Open WebUI: `http://<host-ip>:3000`
- Ollama API: `http://<host-ip>:11434`

## Models

Initial lightweight models:

- `qwen2.5-coder:7b`
- `qwen2.5:7b`

## Start

Optional: copy `.env.example` to `.env` and set `HF_TOKEN` if you want higher Hugging Face download limits for Open WebUI startup assets.

```bash
docker compose up -d
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

## LAN Access

Find the host IP:

```powershell
ipconfig
```

Use the IPv4 address from your active network adapter. If another computer cannot connect, allow inbound TCP ports `3000` and `11434` in Windows Firewall for the private network.

## Scope

This v1 stack is LAN-only and does not include public internet exposure, TLS, reverse proxy, user hardening, RAG, fine-tuning, or monitoring.
