#!/usr/bin/env bash
set -euo pipefail

# Usage (inside Colab cell):
# !bash scripts/colab_bootstrap.sh
# Optional args:
#   1) repo url   (default: https://github.com/chigriil/econml.git)
#   2) branch     (default: main)
#   3) target dir (default: /content/econml)

REPO_URL="${1:-https://github.com/chigriil/econml.git}"
BRANCH="${2:-main}"
TARGET_DIR="${3:-/content/econml}"

if [[ ! -d "${TARGET_DIR}/.git" ]]; then
  rm -rf "${TARGET_DIR}"
  git clone --depth 1 --branch "${BRANCH}" "${REPO_URL}" "${TARGET_DIR}"
fi

cd "${TARGET_DIR}"
python -m pip install --upgrade pip
python -m pip install -r requirements-colab.txt

# Keep artifacts in the repo by default so notebooks/scripts find them consistently.
export DEQN_ARTIFACTS_ROOT="${TARGET_DIR}/artifacts"
mkdir -p "${DEQN_ARTIFACTS_ROOT}"

python - <<'PY'
import os
import torch

print("Project root:", os.getcwd())
print("Torch:", torch.__version__)
print("CUDA available:", torch.cuda.is_available())
if torch.cuda.is_available():
    print("GPU:", torch.cuda.get_device_name(0))
print("DEQN_ARTIFACTS_ROOT:", os.environ.get("DEQN_ARTIFACTS_ROOT", ""))
PY

echo "Bootstrap complete. Open notebooks/* and run."
