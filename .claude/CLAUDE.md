# Homebrew Tap 管理ガイド

## ローカルテスト

```bash
make sync      # フォーミュラを tap にコピー
make audit     # 構文チェック
make build     # 全フォーミュラをビルド
make test      # テスト実行
make all       # 上記すべてを順に実行

# 単一フォーミュラのテスト
make build-app-greple
make test-app-greple
```

## フォーミュラ作成時の注意点

### 依存の順序
- `depends_on` はアルファベット順に記述すること
- `brew audit` でチェックされる

### メタパッケージ
- `prefix` 直下にファイルを置くと "Empty installation" エラー
- `share/"package-name"` を使用する

### テスト
- `greple --version` は exit code 2 を返す（仕様）
- `pipe_output` を使用してマッチするテストを書く
- greple モジュールのテストは `ENV["PERL5LIB"]` の設定が必要

### ラッパースクリプト
- `write_env_script` は PERL5LIB を上書きするため使用しない
- カスタムラッパーで `${PERL5LIB:+:$PERL5LIB}` を使い既存値を保持

```ruby
(bin/"cmd").write <<~SH
  #!/bin/bash
  export PERL5LIB="#{libexec}/lib/perl5${PERL5LIB:+:$PERL5LIB}"
  exec "#{libexec}/bin/cmd" "$@"
SH
(bin/"cmd").chmod 0755
```

### cpanm オプション
- `--quiet` で警告を抑制
- `-l libexec` を `--installdeps` にも指定（一時ディレクトリへのインストールを防ぐ）

```ruby
system "perl", "cpanm", "--quiet", "--notest", "-l", libexec, "--installdeps", "."
system "perl", "cpanm", "--quiet", "--notest", "-l", libexec, "."
```

## フォーミュラ更新手順

1. CPAN でモジュールをリリース
2. `bin/update-formula` でフォーミュラを更新（または手動で URL と SHA256 を更新）
3. `make all` でテスト
4. コミット・プッシュ

## 自動更新（将来の実装）

GitHub Releases をトリガーに `mislav/bump-homebrew-formula-action` を使用可能。
詳細は `docs/AUTO-UPDATE.md` を参照。

## トラブルシューティング

### rebase コンフリクト
tap ディレクトリで履歴が競合した場合：
```bash
cd /opt/homebrew/Library/Taps/tecolicom/homebrew-tap
git rebase --skip  # または --abort
```

### コマンドが見つからない
```bash
brew unlink <formula>
brew link <formula>
```

### PERL5LIB が正しく設定されない
ラッパースクリプトを確認：
```bash
cat $(which <command>)
```
