---
layout: section
color: blue
toc: ターミナルのキーバインド
---

# ターミナルのキーバインド

---
layout: two-cols
ratio: 1/1
eyebrow: wezterm
---

# キーバインドはゼロから書かない

::left::

デフォルトのキーバインドは大量にある。
現在の設定をファイルに書き出し、それを編集する

```sh
cd ~/.config/wezterm
wezterm show-keys --lua \
  > keybinds.lua
```

::right::

書き出したファイルを wezterm.lua で読み込む

```lua [~/.config/wezterm/wezterm.lua]
config.keys =
  require("keybinds").keys
config.key_tables =
  require("keybinds").key_tables
```

<FindyCallout class="mt-4">
  デフォルトを無効にして全部自分で握るなら
  <code>disable_default_key_bindings = true</code>
</FindyCallout>

---
layout: two-cols
ratio: 1/1
eyebrow: wezterm
---

# Leader キーはどこに置く?

::left::

**Leader キー** = ショートカットの起点になるキー
(Vim の `<Leader>`、tmux の prefix と同じ発想)

<FindyKeyValueList size="1.02rem" class="mt-4">
  <FindyKeyValue label="Ctrl+a">デフォルト。Emacs の行頭移動と被る</FindyKeyValue>
  <FindyKeyValue label="Ctrl+q">フロー制御 (XON) と被る</FindyKeyValue>
  <FindyKeyValue label="Ctrl+;">シェルに届かないので衝突しにくい</FindyKeyValue>
</FindyKeyValueList>

::right::

```lua [~/.config/wezterm/wezterm.lua]
config.leader = {
  key = ";",
  mods = "CTRL",
  timeout_milliseconds = 2000,
}
```

<FindyCallout class="mt-4">
  <code>Ctrl+;</code> は従来の端末エンコーディングに無いキー。
  シェルや fzf に届かないので WezTerm が先取りしても衝突しない
</FindyCallout>

---
layout: two-cols
ratio: 1/1
eyebrow: wezterm
---

# よく使う WezTerm キーバインド

::left::

デフォルト

<FindyKeyValueList size="0.9rem" gap="0.25rem" class="mt-2">
  <FindyKeyValue label="Ctrl+Shift+T">新しいタブ</FindyKeyValue>
  <FindyKeyValue label="Ctrl+Tab">次のタブ</FindyKeyValue>
  <FindyKeyValue label="Ctrl+Shift+P">コマンドパレット</FindyKeyValue>
  <FindyKeyValue label="Ctrl+Shift+F">検索</FindyKeyValue>
  <FindyKeyValue label="Ctrl +/-">フォントサイズ変更</FindyKeyValue>
</FindyKeyValueList>

::right::

Leader キー (カスタム設定)

<FindyKeyValueList size="0.9rem" gap="0.25rem" class="mt-2">
  <FindyKeyValue label="Leader, |">縦に分割</FindyKeyValue>
  <FindyKeyValue label="Leader, -">横に分割</FindyKeyValue>
  <FindyKeyValue label="Leader, hjkl">ペイン移動</FindyKeyValue>
  <FindyKeyValue label="Leader, z">ズーム</FindyKeyValue>
</FindyKeyValueList>

---
layout: two-cols
ratio: 1/1
eyebrow: wezterm
---

# WezTerm キーバインドの設定例

::left::

Leader キーに続けて 1 キーでペインを操作できるようにする

<FindyCallout class="mt-4">
  <code>act</code> は <code>wezterm.action</code> の短縮。
  ファイル冒頭で <code>local act = wezterm.action</code> としておく
</FindyCallout>

::right::

```lua [~/.config/wezterm/wezterm.lua]
config.keys = {
  { key = "|", mods = "LEADER|SHIFT",
    action = act.SplitHorizontal{} },
  { key = "-", mods = "LEADER",
    action = act.SplitVertical{} },
  -- h/j/k/l でペイン移動
  { key = "h", mods = "LEADER",
    action = act.ActivatePaneDirection("Left") },
  -- j, k, l も同様に Down, Up, Right
  { key = "z", mods = "LEADER",
    action = act.TogglePaneZoomState },
}
```

---
layout: content
eyebrow: wezterm
---

# Claude Code ユーザー向け: Shift+Enter で改行

Claude Code は <kbd>Enter</kbd> で送信される。<kbd>Shift</kbd> + <kbd>Enter</kbd> で改行だけを入力できるようにしておくと、複数行のプロンプトが書きやすい

```lua [~/.config/wezterm/wezterm.lua]
config.keys = {
  {
    key = "Enter",
    mods = "SHIFT",
    action = wezterm.action.SendString("\n"),
  },
}
```
