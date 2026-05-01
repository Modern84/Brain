#!/usr/bin/env bash
# run_v4_v2.sh — Wrapper für v4_patcher_v2.py (erweiterter Info-Block)
# Nutzt dasselbe venv wie run_v4.sh (~/.local/share/mthreed/v4-patcher/venv)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_ROOT="${HOME}/.local/share/mthreed/v4-patcher"
VENV="${VENV_ROOT}/venv"
PY="${VENV}/bin/python"

: "${INPUT_DIR:?setze INPUT_DIR}"
: "${OUTPUT_DIR:?setze OUTPUT_DIR}"

if [[ ! -x "${PY}" ]]; then
  echo "[setup] venv erstellen: ${VENV}"
  mkdir -p "${VENV_ROOT}"
  python3 -m venv "${VENV}"
  "${VENV}/bin/pip" install --upgrade pip >/dev/null
  "${VENV}/bin/pip" install "pikepdf>=9.0" "reportlab>=4.0"
  echo "[setup] fertig."
fi

mkdir -p "$OUTPUT_DIR"
exec "${PY}" "${SCRIPT_DIR}/v4_patcher_v2.py" "$INPUT_DIR" "$OUTPUT_DIR"
