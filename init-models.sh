#!/bin/bash
set -euo pipefail

echo "Waiting Ollama startup..."
sleep 10

docker exec ollama ollama list >/dev/null
docker exec ollama ollama pull qwen2.5:7b
docker exec ollama ollama pull qwen2.5-coder:7b
if [ -n "${OPENCLAW_MODEL:-}" ] && [ "${OPENCLAW_MODEL}" != "qwen2.5:7b" ] && [ "${OPENCLAW_MODEL}" != "qwen2.5-coder:7b" ]; then
  docker exec ollama ollama pull "${OPENCLAW_MODEL}"
fi
docker exec ollama ollama list

echo "Done."
