#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INFRA_DIR="${REPO_DIR}/infra"
EVIDENCE_DIR="${REPO_DIR}/docs/evidencias"
TIMESTAMP="$(date -u +%Y%m%d-%H%M%S)"
OUTPUT="${EVIDENCE_DIR}/azure-terraform-${TIMESTAMP}.txt"

mkdir -p "${EVIDENCE_DIR}"
cd "${INFRA_DIR}"

{
  echo "Evidências Azure e Terraform"
  echo "Data UTC: $(date -u --iso-8601=seconds)"
  echo

  echo "=== Conta Azure ==="
  az account show \
    --query '{Assinatura:name,ID:id,Usuario:user.name}' \
    -o table
  echo

  echo "=== Versões ==="
  terraform version
  az version --query '"azure-cli"' -o tsv
  echo

  echo "=== Terraform init ==="
  terraform init -input=false -no-color
  echo

  echo "=== Terraform validate ==="
  terraform validate -no-color
  echo

  echo "=== Recursos no state ==="
  terraform state list
  echo

  echo "=== Recursos dos laboratórios ==="
  az resource list \
    --query "[?resourceGroup=='RG-LAB-SRE' || resourceGroup=='RG-LAB-WIN2025'].{Grupo:resourceGroup,Nome:name,Tipo:type,Regiao:location}" \
    -o table
} 2>&1 | tee "${OUTPUT}"

echo
echo "Evidência criada em: ${OUTPUT}"
