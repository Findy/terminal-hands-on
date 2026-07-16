---
theme: findy
title: 学生向けハンズオン～イケてるターミナルをつくろう！～
info: |
  Findy Student 2026.7.17
  学生向けハンズオン～イケてるターミナルをつくろう！～
class: text-left
comark: true
favicon: https://github.com/mozumasu.png
addons:
  - slidev-addon-findy
layout: talk-cover
event: Findy Student 2026.7.17
image: https://github.com/mozumasu.png
name: mozumasu
role: Findy Inc. / SRE
---

## 学生向けハンズオン
# イケてるターミナルをつくろう！

---
layout: profile
image: https://github.com/mozumasu.png
name: mozumasu
role: Findy Inc. / SRE
---

## 自己紹介

- 開発環境: MacOS / WezTerm / Neovim / macSKK
- 一言: Flappy syumaiの最高得点は7点でした

<div class="mt-4 flex flex-wrap gap-2">
  <FindyBadge variant="soft">X: @mozumasu</FindyBadge>
  <FindyBadge variant="soft">GitHub: mozumasu</FindyBadge>
</div>

---
layout: toc
columns: 1
---

---
src: ./pages/terminal-beginner.md
---

---
src: ./pages/wezterm.md
---

---
src: ./pages/shell.md
---

---
src: ./pages/wezterm-keybinds.md
---

---
src: ./pages/herdr.md
---

---
src: ./pages/workflow.md
---

---
layout: content
toc: まとめ
---

# まとめ

<div class="mt-4 space-y-4">
  <FindyKeyValue size="1.05rem" labelWidth="9em" label="ターミナル">WezTerm は Lua で見た目もキーバインドも自分好みにできる</FindyKeyValue>
  <FindyKeyValue size="1.05rem" labelWidth="9em" label="シェル">Emacs バインドを覚えると速い。CapsLock を Ctrl にすると更に快適</FindyKeyValue>
  <FindyKeyValue size="1.05rem" labelWidth="9em" label="キーバインド">内側（シェル）から外側（ターミナル）の順に設定すると衝突しない</FindyKeyValue>
  <FindyKeyValue size="1.05rem" labelWidth="9em" label="マルチプレクサ">herdr でターミナルを分割管理。AI エージェントとも協業できる</FindyKeyValue>
  <FindyKeyValue size="1.05rem" labelWidth="9em" label="ワークフロー">ghost・portless・worktree を組み合わせると AI との並行開発が現実になる</FindyKeyValue>
</div>

<FindyCallout class="mt-6">
  設定はすべて <code>~/.config/</code> 以下のファイル。dotfiles として Git 管理すればどの環境でも再現できる
</FindyCallout>

---
layout: end
---

# ありがとうございました
