#!/usr/bin/env bash
# run_v5.sh — Wrapper für v5_patcher.py
# venv-Konvention: ~/.local/share/mthreed/v5-patcher/venv
# PEP-668-konform, außerhalb iCloud, idempotenter Build.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_ROOT="${HOME}/.local/share/mthreed/v5-patcher"
VENV="${VENV_ROOT}/venv"
PY="${VENV}/bin/python"

# ── venv idempotent bauen ────────────────────────────────────────────
if [[ ! -x "${PY}" ]]; then
  echo "[setup] venv erstellen: ${VENV}"
  mkdir -p "${VENV_ROOT}"
  python3 -m venv "${VENV}"
  "${VENV}/bin/pip" install --upgrade pip >/dev/null
  "${VENV}/bin/pip" install "pymupdf>=1.24" "pyyaml>=6.0"
  echo "[setup] fertig."
fi

# ── Script aufrufen ──────────────────────────────────────────────────
exec "${PY}" "${SCRIPT_DIR}/v5_patcher.py" "$@"
