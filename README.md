# Triton learning environment (OpenAI Triton)

This folder is a small **course shell** around the official [Triton](https://triton-lang.org/) project: a Linux Python environment (Docker or Dev Container), pinned dependencies, and a script that pulls the upstream tutorial `.py` files into `work/upstream-tutorials/`.

## Why Docker or a Linux machine?

Triton publishes **pip wheels for Linux only** (not macOS). On Apple Silicon or Intel Macs, run this course inside **Docker Desktop**, **Podman**, **GitHub Codespaces**, **VS Code / Cursor Dev Containers**, or any **Linux x86_64/aarch64** host with Python 3.10+.

Your system Python was 3.9; current Triton expects **CPython 3.10–3.14**. The container uses **Python 3.12**.

## Quick start (Docker Compose)

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop/) (or another OCI runtime).
2. From this directory:

   ```bash
   cd triton-course
   ./scripts/sync-tutorials.sh
   docker-compose build
   TRITON_INTERPRET=1 docker-compose up
   ```

3. Open Jupyter Lab: **http://127.0.0.1:8888** — no login prompt (token and password are disabled in the `Dockerfile` for local use only). If you publish port 8888 beyond localhost, set a token or password in the `Dockerfile` / `jupyter_server_config.py` instead.

The compose file mounts the **entire `triton-course` directory** to `/workspace` so `scripts/` and `work/` are both visible in the container.

Use **`TRITON_INTERPRET=1`** when the container has **no GPU**. Kernels execute on the interpreter (good for correctness and learning; not representative of GPU performance). With an NVIDIA GPU on Linux, install the [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html), uncomment the `deploy` section in `docker-compose.yml`, omit `TRITON_INTERPRET`, and use GPU-backed runs.

## Cursor / VS Code Dev Container

Open the `triton-course` folder, then **“Dev Containers: Reopen in Container”**. The image matches `Dockerfile`; `postCreateCommand` runs `scripts/sync-tutorials.sh` when the container is created.

## Suggested study order

| Week | Focus | Upstream file (under `work/upstream-tutorials/`) |
|------|--------|---------------------------------------------------|
| 1 | Launch grid, pointers, `tl.load` / `tl.store` | `01-vector-add.py` |
| 1–2 | Online softmax, numerical stability | `02-fused-softmax.py` |
| 2–3 | Tiling, `tl.dot`, autotuning | `03-matrix-multiplication.py` |
| 3 | RNG patterns, memory | `04-low-memory-dropout.py` |
| 4 | Reductions, warp-friendly layernorm | `05-layer-norm.py` |
| 5+ | Flash-style attention (GPU) | `06-fused-attention.py` |

Run a tutorial inside the container (from `/workspace`):

```bash
python upstream-tutorials/01-vector-add.py
```

Official docs: [https://triton-lang.org/](https://triton-lang.org/). Tutorial sources: [triton-lang/triton `python/tutorials`](https://github.com/triton-lang/triton/tree/main/python/tutorials).

## Extra practice (no GPU required)

The Triton README links to **[Triton puzzles](https://github.com/srush/Triton-Puzzles)** — exercises designed to run with the interpreter.

## Conference talks (broader context)

- [Triton Developer Conference 2025 — YouTube playlist](https://www.youtube.com/playlist?list=PLc_vA1r0qoiQqCdWFDUDqI90oY5EjfGuO)

## Native Linux (no Docker)

On a Linux host with Python 3.12:

```bash
python3.12 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
./scripts/sync-tutorials.sh
```

## Files here

- `Dockerfile` — Python 3.12 + PyTorch + Triton + JupyterLab  
- `docker-compose.yml` — port 8888, `./work` mounted at `/workspace`  
- `requirements.txt` — dependencies for the container (or native Linux)  
- `scripts/sync-tutorials.sh` — refreshes `work/upstream-tutorials/` from GitHub  
