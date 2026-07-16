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

<FindyCallout>
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

<FindyKeyValueList size="1.02rem">
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

<FindyCallout>
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

<FindyKeyValueList size="0.9rem" gap="0.25rem">
  <FindyKeyValue label="Ctrl+Shift+T">新しいタブ</FindyKeyValue>
  <FindyKeyValue label="Ctrl+Tab">次のタブ</FindyKeyValue>
  <FindyKeyValue label="Ctrl+Shift+P">コマンドパレット</FindyKeyValue>
  <FindyKeyValue label="Ctrl+Shift+F">検索</FindyKeyValue>
  <FindyKeyValue label="Ctrl +/-">フォントサイズ変更</FindyKeyValue>
</FindyKeyValueList>

::right::

Leader キー (カスタム設定)

<FindyKeyValueList size="0.9rem" gap="0.25rem">
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

# コマンドパレット

::left::

WezTerm のコマンドパレットは <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd>

<p class="mt-4">
コマンド名であいまい検索でき、よく使うものほど上に出てくる。
コマンドの横にはショートカットキーも表示される
</p>

<FindyCallout>
  VS Code と同じキーバインド。覚えていなくても検索して実行できる
</FindyCallout>

::right::

```lua [~/.config/wezterm/wezterm.lua]
local act = wezterm.action

config.keys = {
  {
    key = "p",
    mods = "CTRL|SHIFT",
    action = act.ActivateCommandPalette,
  },
}
```

<FindyRef>

[ActivateCommandPalette](https://wezterm.org/config/lua/keyassignment/ActivateCommandPalette.html)

</FindyRef>

---
layout: two-cols
ratio: 1/1
eyebrow: wezterm
---

# WezTerm キーバインドの設定例

::left::

Leader キーに続けて 1 キーでペインを操作できるようにする

<FindyCallout>
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
layout: two-cols
ratio: 1/1
eyebrow: wezterm
---

# QuickSelect で画面の文字列を拾う

::left::

画面の URL・パス・ハッシュにラベルが振られ、マウスなしでコピーできる

<FindyKeyValueList size="0.95rem">
  <FindyKeyValue label="発動"><kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>Space</kbd></FindyKeyValue>
  <FindyKeyValue label="コピー">候補のラベルのキーを打つ</FindyKeyValue>
  <FindyKeyValue label="貼り付け">ラベルを大文字で打つ</FindyKeyValue>
</FindyKeyValueList>

<FindyCallout>
  <code>QuickSelectArgs</code> で「選んで開く」も組める。
  AWS の ARN を選んでそのままコンソールを開ける
  (<a href="https://github.com/mozumasu/dotfiles/blob/ebfef03a888/.config/wezterm/keymaps.lua#L137-L153">設定例</a>)
</FindyCallout>

<FindyRef>

[Quick Select Mode](https://wezterm.org/quickselect.html)

</FindyRef>

::right::

拾いたいパターンは正規表現で足せる

```lua [~/.config/wezterm/wezterm.lua]
-- IME 切替と被るので Cmd+Space に変更
config.keys = {
  { key = " ", mods = "SUPER",
    action = act.QuickSelect },
}
-- デフォルトのパターンを無効化する
config.disable_default_quick_select_patterns = true
config.quick_select_patterns = {
  -- Git commit hash
  "\\b[0-9a-f]{7,40}\\b",
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
