$ErrorActionPreference = "Stop"

Write-Host "Waiting Ollama startup..."
Start-Sleep -Seconds 10

docker exec ollama ollama list | Out-Host
docker exec ollama ollama pull qwen2.5:7b
docker exec ollama ollama pull qwen2.5-coder:7b
if ($env:OPENCLAW_MODEL -and $env:OPENCLAW_MODEL -ne "qwen2.5:7b" -and $env:OPENCLAW_MODEL -ne "qwen2.5-coder:7b") {
    docker exec ollama ollama pull $env:OPENCLAW_MODEL
}
docker exec ollama ollama list | Out-Host

Write-Host "Done."
