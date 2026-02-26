# Colab GPU Run (from VS Code workflow)

## 1) Open notebook in Colab
- Push your current branch to GitHub.
- Open this URL pattern in browser:
  - `https://colab.research.google.com/github/chigriil/econml/blob/main/notebooks/10_train_taylor.ipynb`
- In Colab: `Runtime -> Change runtime type -> GPU`.

## 2) Bootstrap environment (first Colab cell)
```bash
!git clone --depth 1 https://github.com/chigriil/econml.git /content/econml
%cd /content/econml
!bash scripts/colab_bootstrap.sh
```

## 3) Run notebook against project root
Add this cell at the top of the notebook before imports:

```python
import os, sys
os.chdir("/content/econml")
if "/content/econml" not in sys.path:
    sys.path.insert(0, "/content/econml")
```

Then run notebook cells normally.

## 4) Where outputs are saved
- Run artifacts: `/content/econml/artifacts/runs/...`
- For persistence between sessions, copy artifacts to Google Drive:

```python
from google.colab import drive
drive.mount('/content/drive')
!mkdir -p /content/drive/MyDrive/econml_artifacts
!cp -r /content/econml/artifacts/* /content/drive/MyDrive/econml_artifacts/
```
