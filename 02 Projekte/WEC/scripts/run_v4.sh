#!/usr/bin/env bash
# run_v4.sh — Wrapper für v4_patcher.py
# venv-Konvention: ~/.local/share/mthreed/v4-patcher/venv
# PEP-668-konform, außerhalb iCloud, idempotenter Build.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_ROOT="${HOME}/.local/share/mthreed/v4-patcher"
VENV="${VENV_ROOT}/venv"
PY="${VENV}/bin/python"

: "${INPUT_DIR:?setze INPUT_DIR}"
: "${OUTPUT_DIR:?setze OUTPUT_DIR}"

# ── venv idempotent bauen ────────────────────────────────────────────
if [[ ! -x "${PY}" ]]; then
  echo "[setup] venv erstellen: ${VENV}"
  mkdir -p "${VENV_ROOT}"
  python3 -m venv "${VENV}"
  "${VENV}/bin/pip" install --upgrade pip >/dev/null
  "${VENV}/bin/pip" install "pikepdf>=9.0" "reportlab>=4.0"
  echo "[setup] fertig."
fi

mkdir -p "$OUTPUT_DIR"
exec "${PY}" "${SCRIPT_DIR}/v4_patcher.py" "$INPUT_DIR" "$OUTPUT_DIR"
