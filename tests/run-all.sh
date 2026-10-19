#!/usr/bin/env bash
# Lanza toda la batería. Un test por requisito, trazabilidad 1:1.
set -uo pipefail
cd "$(dirname "$0")/.."
fallos=0
for t in tests/test_RQ*.sh; do
  if bash "$t"; then
    printf '  ✓ %s\n' "$(basename "$t")"
  else
    printf '  ✗ %s\n' "$(basename "$t")"
    fallos=$((fallos + 1))
  fi
done
echo
if [ "$fallos" -gt 0 ]; then
  echo "FALLAN $fallos test(s)"
  exit 1
fi
echo "Todos los tests pasan"
