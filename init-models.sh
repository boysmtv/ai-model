#!/bin/bash
set -euo pipefail

echo "Waiting Ollama startup..."
sleep 10

docker exec ollama ollama list >/dev/null
docker exec ollama ollama pull qwen2.5:7b
docker exec ollama ollama pull qwen2.5-coder:7b
docker exec ollama ollama list

echo "Done."
