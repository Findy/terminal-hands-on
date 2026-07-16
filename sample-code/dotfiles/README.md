# サンプル dotfiles

ハンズオンで紹介する設定ファイルのサンプルです。
`~` にコピーしてそのまま使えます。

## ファイル構成

```text
dotfiles/
├── .config/
│   ├── wezterm/
│   │   ├── wezterm.lua            # macOS / Linux 向け
│   │   └── wezterm-windows.lua    # Windows (WSL + Acrylic) 向け
│   ├── herdr/
│   │   └── config.toml            # herdr の prefix キー・キーバインド
│   ├── zsh/
│   │   └── .zshrc                 # zsh のキーバインド・環境変数
│   └── fish/
│       └── config.fish            # fish の環境変数
└── .inputrc                       # bash の履歴検索
```

## 各ファイルの内容

| ファイル | 主な設定 |
|---|---|
| `wezterm.lua` | フォント、背景透過+ぼかし、タブバー、Leader キー (`Ctrl+;`)、ペイン分割・移動、コマンドパレット、Claude Code 改行 |
| `wezterm-windows.lua` | 上記 + WSL ドメイン設定、Acrylic 効果 |
| `herdr/config.toml` | prefix キー (`ctrl+q`)、ペイン操作、タブ・ワークスペース操作、lazygit カスタムコマンド |
| `zsh/.zshrc` | XDG Base Directory、MANPAGER、`stty -ixon`、`edit-command-line`、前方一致の履歴検索 |
| `fish/config.fish` | XDG Base Directory |
| `.inputrc` | bash 用の前方一致の履歴検索 |
