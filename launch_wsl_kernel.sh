#!/usr/bin/env bash
set -euo pipefail

connection_file="${1:-}"
if [[ -z "$connection_file" ]]; then
  echo "Missing Jupyter connection file path" >&2
  exit 2
fi

# VS Code on Windows can pass either a full Windows path or a home-shortened
# one like "~\AppData\Roaming\jupyter\runtime\kernel-....json".
case "$connection_file" in
  '~\'* | '~/'*)
    connection_file="C:\\Users\\ASUS\\${connection_file:2}"
    ;;
esac

if command -v wslpath >/dev/null 2>&1; then
  connection_file="$(wslpath -u "$connection_file" 2>/dev/null || printf '%s' "$connection_file")"
fi

source /mnt/c/Users/ASUS/OneDrive/Documentos/.venv/bin/activate
cd /mnt/c/Users/ASUS/OneDrive/Documentos/ProyectoApophis
exec python -Xfrozen_modules=off -m ipykernel_launcher -f "$connection_file"
