#!/usr/bin/env bash
# Lightweight local security check — no external services required.
# Optionally, if Trivy is installed, run: trivy image cloudnotes-api:0.1.0
set -euo pipefail

fail=0

echo "== Checking for hardcoded secrets in Dockerfile/compose.yaml =="
if grep -nE '(API_KEY|SECRET|PASSWORD|TOKEN)\s*=\s*[^$]' Dockerfile compose.yaml 2>/dev/null \
    | grep -vE '\$\{|env_file|environment:'; then
  echo "FAIL: possible hardcoded secret found above."
  fail=1
else
  echo "OK: no obvious hardcoded secrets found."
fi

echo
echo "== Checking .env is gitignored =="
if [ -f .gitignore ] && grep -qxF ".env" .gitignore; then
  echo "OK: .env is listed in .gitignore."
else
  echo "FAIL: .env is not gitignored."
  fail=1
fi

echo
if [ "$fail" -ne 0 ]; then
  echo "Security check FAILED."
  exit 1
fi

echo "Security check PASSED."
echo "(Optional) run 'trivy image cloudnotes-api:0.1.0' if Trivy is installed for a deeper scan."
