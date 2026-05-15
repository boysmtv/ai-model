# AI Model Local Server - Brief v1

## Goal

Build a local AI model server that runs Ollama and lightweight Qwen-based coding/computer-science models in Docker. The server will run on this machine first and later be accessed from other computers on the same local network.

## Primary Use Cases

- Use Open WebUI from a browser for chat-based coding and computer-science assistance.
- Use the Ollama HTTP API from other local tools or computers.
- Keep model files and Open WebUI data persistent across container restarts.
- Keep the stack simple enough to run locally without enterprise security or public internet exposure.

## Target Runtime

- Docker Compose based runtime.
- Ollama container exposed on port `11434`.
- Open WebUI container exposed on port `3000`.
- NVIDIA GPU acceleration enabled for Ollama.
- Persistent Docker volumes for:
  - Ollama model data.
  - Open WebUI backend data.

## Initial Models

The initial model set should focus on lightweight coding and computer-science usage:

- `qwen2.5-coder:7b`
- `qwen2.5:7b`

If a model is too heavy or slow on the host machine, prefer smaller Qwen coding variants before adding larger general-purpose models.

## Network Scope

- Local network only for v1.
- Other computers should be able to access:
  - Open WebUI via `http://<host-ip>:3000`
  - Ollama API via `http://<host-ip>:11434`
- No public internet exposure is required.
- No VPN, reverse proxy, TLS, or domain setup is required for v1.

## Security Scope

- Open WebUI login/security hardening is not required for v1.
- The stack should not be exposed outside the trusted local network.
- Secrets should not be committed to the project.
- If later exposed beyond LAN, a future brief must add authentication, firewall rules, TLS/reverse proxy, and access policy.

## Deliverables

- A working `docker-compose.yml` for Ollama and Open WebUI.
- A model initialization script that pulls the selected Qwen models.
- Clear run instructions in a README.
- Basic validation commands for:
  - checking container status,
  - checking Ollama API health,
  - listing installed models,
  - confirming Open WebUI is reachable.

## Acceptance Criteria

- `docker compose up -d` starts Ollama and Open WebUI successfully.
- Ollama is reachable from the host at `http://localhost:11434`.
- Open WebUI is reachable from the host at `http://localhost:3000`.
- Another computer on the same LAN can access Open WebUI using the host machine IP.
- Another computer on the same LAN can call the Ollama API using the host machine IP.
- `qwen2.5-coder:7b` and `qwen2.5:7b` are available in Ollama after running the initialization script.
- Model and UI data survive container restart.

## Out Of Scope For v1

- Public internet access.
- User account/security hardening.
- TLS certificate setup.
- Reverse proxy.
- Model fine-tuning.
- RAG/vector database.
- Multi-node deployment.
- Monitoring stack.
- Automatic model benchmarking.

## Notes

- This project is a local model-serving stack, not a general ML training platform.
- Prefer stable, simple Docker operations over complex orchestration.
- Keep the project easy to move or reproduce on another local machine.
