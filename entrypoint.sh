#!/bin/sh
set -e
npm install -g openclaw@latest
# Menjalankan langsung melalui npx untuk menghindari masalah path
npx openclaw gateway run --allow-unconfigured
