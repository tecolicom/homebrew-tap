# Formula 自動更新の設定

## 概要

`minil release` → GitHub Release 作成 → homebrew-tap 自動更新

## 設定手順

### 1. Personal Access Token の作成

GitHub Settings → Developer settings → Personal access tokens → Tokens (classic)

- 名前: `HOMEBREW_TAP_TOKEN`
- スコープ: `repo` (homebrew-tap への書き込み権限)

各 CPAN リポジトリの Settings → Secrets → Actions に `HOMEBREW_TAP_TOKEN` として登録。

### 2. 各リポジトリに GitHub Actions を追加

`.github/workflows/release.yml`:

```yaml
name: Release
on:
  push:
    tags:
      - '*'

jobs:
  release:
    runs-on: ubuntu-latest
    permissions:
      contents: write
    steps:
      - uses: actions/checkout@v4
      - name: Create GitHub Release
        run: gh release create ${{ github.ref_name }} --generate-notes
        env:
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}

  homebrew:
    needs: release
    runs-on: ubuntu-latest
    steps:
      - uses: mislav/bump-homebrew-formula-action@v3
        with:
          formula-name: <formula-name>  # app-greple など
          homebrew-tap: tecolicom/homebrew-tap
        env:
          COMMITTER_TOKEN: ${{ secrets.HOMEBREW_TAP_TOKEN }}
```

### 3. Formula 名の対応

| リポジトリ | Formula 名 |
|-----------|-----------|
| App-Greple | app-greple |
| App-ansicolumn | app-ansicolumn |
| App-ansifold | app-ansifold |
| App-ansiecho | app-ansiecho |
| App-nup | app-nup |
| App-optex | app-optex |
| App-mdee | app-mdee |
| Getopt-Long-Bash | getopt-long-bash |
| Text-ANSI-Printf | text-ansi-printf |

## 手動更新

自動化が設定されていない場合:

```bash
cd ~/Git/tecolicom/homebrew-tap
bin/update-formula <formula-name>
git add Formula/
git commit -m "Update <formula-name>"
git push
```

## 流れ

```
minil release
    ↓
git tag & push (自動)
    ↓
GitHub Actions: Release 作成 (on: push tags)
    ↓
GitHub Actions: homebrew-tap 更新 (on: release published)
    ↓
Formula 更新完了
```
