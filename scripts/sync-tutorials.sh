#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEST="${ROOT}/work/upstream-tutorials"
BASE="https://raw.githubusercontent.com/triton-lang/triton/main/python/tutorials"
mkdir -p "${DEST}"
for f in \
  01-vector-add.py \
  02-fused-softmax.py \
  03-matrix-multiplication.py \
  04-low-memory-dropout.py \
  05-layer-norm.py \
  06-fused-attention.py \
  07-extern-functions.py \
  requirements.txt \
  README.rst \
  ; do
  echo "Fetching ${f}"
  curl -fsSL "${BASE}/${f}" -o "${DEST}/${f}"
done
echo "Upstream tutorials saved to ${DEST}"
