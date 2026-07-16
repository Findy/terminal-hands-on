---
layout: content
center: true
transition: view-transition
toc: ターミナル生活を支えるやつらの紹介
---

# ターミナル生活を支えるやつらを紹介するぜ！

- ターミナル
- ターミナルマルチプレクサ
- シェル

---
layout: section
transition: view-transition
---

<div class="inline-block view-transition-f">

設定前に知っておくとお得  
...かもしれないもの

</div>

---
layout: content
transition: view-transition
center: true
---

# 設定前に知っておくとお得 ...かもしれないもの {.inline-block.view-transition-f}


1. dotfiles {.inline-block.view-transition-dotfiles}
2. DeepWiki
3. キーバインド

---
layout: two-cols
ratio: 1/1
eyebrow: dotfiles
eyebrowNum: 1
---

# 1. dotfiles {.inline-block.view-transition-dotfiles}

::left::

<FindyTermCardList class="mt-10">
  <FindyTermCard term="dotfile">
    設定ファイルのこと
    <template #note>名前が <code>.</code> で始まることが由来 (ex. <code>.bashrc</code>, <code>.zshrc</code>)</template>
  </FindyTermCard>
  <FindyTermCard term="dotfiles">
    設定ファイル<strong>群</strong>のこと
    <template #note><FindyAccentMark>PCの環境を再現できる</FindyAccentMark>ように GitHub などで管理することが多い</template>
  </FindyTermCard>
</FindyTermCardList>

エンジニアの名刺的存在

::right::

<FindyRepoPage repo="mozumasu/dotfiles" image="/screenshots/dotfiles-repo.png" />

---
layout: content
eyebrow: dotfiles
eyebrowNum: 1
---

# dotfilesのリポジトリを用意しよう

`~/dotfiles` に置くのが一般的

```sh
# ホームディレクトリへ移動
cd

# リモートリポジトリを作成してcloneする
gh repo create dotfiles --public --clone

# clone できたか確認
ls -la | grep dotfiles
```

---
layout: two-cols
ratio: 1/1
eyebrow: dotfiles
eyebrowNum: 1
---

# 設定ファイルはどこに置く?

::left::

**XDG Base Directory**:
設定ファイルなどの置き場所を標準化する仕様

<div class="mt-5">
  <FindyKeyValue size="1.05rem" label="設定"><code>~/.config</code></FindyKeyValue>
  <FindyKeyValue size="1.05rem" label="キャッシュ"><code>~/.cache</code></FindyKeyValue>
  <FindyKeyValue size="1.05rem" label="データ"><code>~/.local/share</code></FindyKeyValue>
  <FindyKeyValue size="1.05rem" label="状態"><code>~/.local/state</code> (ログ・履歴など)</FindyKeyValue>
</div>

::right::

環境変数で明示しておくと `~/.config` に集約できる

::code-group

```sh [zsh / bash]
# zsh: ~/.zshenv / bash: ~/.bashrc
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
```

```fish [fish]
# ~/.config/fish/config.fish
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"
```

::

<FindyCallout variant="warn" class="mt-4">
  macOS では未設定だと <code>~/Library/Application Support</code> に設定を置くツールがある (ex. lazygit)
</FindyCallout>

---
layout: two-cols
ratio: 1/1
eyebrow: DeeWiki
eyebrowNum: 2
---

# 2. DeepWiki

<FindyTermCardList class="mt-6">
  <FindyTermCard term="DeepWiki">
    GitHub リポジトリを AI が解説してくれるサイト
    <template #note>Cognition (Devin の開発元) が提供・パブリックリポジトリは<FindyAccentMark>無料</FindyAccentMark></template>
  </FindyTermCard>
</FindyTermCardList>

::left::

**できること**

- ドキュメントと構成図の自動生成
- リポジトリに対して AI に質問できる

::right::


**こんなときに便利** {.mt-6}

- ツールを設定する前に仕組みをざっくり掴む
- README に載っていない挙動を調べる

---
layout: two-cols
ratio: 2/5
valign: center
eyebrow: DeeWiki
eyebrowNum: 2
---

# DeepWiki への質問例

::left::

<div class="mt-2 space-y-4 text-[1.05rem]">
  <div><FindyColorDot color="#3b82f6" /><strong>質問</strong> — 自然言語でリポジトリに問いかける</div>
  <div><FindyColorDot color="#10b981" /><strong>回答</strong> — 該当ファイル・行番号を引用しながら説明</div>
  <div><FindyColorDot color="#f59e0b" /><strong>ソース</strong> — 引用元のコードがそのまま並んで表示される</div>
</div>

::right::

<FindyAnnotatedImage
  image="/screenshots/deepwiki-yazi-help.png"
  alt="DeepWiki で yazi のヘルプ表示方法を質問した画面。左に質問と引用付きの回答、右に引用元の keymap-default.toml が表示されている"
  class="shadow rounded"
>
  <FindyImageRegion label="質問" color="#3b82f6" :x="6" :y="9" :w="34" :h="9" />
  <FindyImageRegion label="回答（引用付き）" color="#10b981" :x="6" :y="19" :w="34" :h="30" />
  <FindyImageRegion label="引用元のコード" color="#f59e0b" :x="40" :y="9" :w="58" :h="89" />
</FindyAnnotatedImage>

<div class="mt-2 text-xs text-center">
  <a href="https://deepwiki.com/search/_1b649b74-1735-4598-b35f-5bb60d735926?mode=fast" target="_blank">この質問のページを実際に見る ↗</a>
</div>

---
layout: two-cols
eyebrow: キーバインド
eyebrowNum: 3
---

# 3. キーバインド

::left::

- 入力がユーザーに馴染むかどうかはAIでは決められない
- 一度慣れると後から変更するのが辛い


<FindyCallout variant="warn" class="mt-4">
  設定は内側から外側へ設定するのがオススメ
</FindyCallout>

::right::


<FindyFlow
  from="内側"
  to="外側"
  steps="シェル\nTUI アプリ (Neovim / lazygit など),ターミナルマルチプレクサ,ターミナルエミュレータ,キーボード"
/>

