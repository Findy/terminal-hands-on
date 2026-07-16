---
layout: section
color: blue
toc: 組み合わせてワークフローに
---

# 組み合わせて<br>ワークフローに

---
layout: two-cols
ratio: 1/1
---

# ghost

::left::

バックグラウンドプロセスのジョブ管理ツール

<div class="mt-4 space-y-3">
  <FindyKeyValue size="0.95rem" label="起動">ghost run -- pnpm dev</FindyKeyValue>
  <FindyKeyValue size="0.95rem" label="一覧">ghost list</FindyKeyValue>
  <FindyKeyValue size="0.95rem" label="ログ">ghost log -f &lt;task_id&gt;</FindyKeyValue>
  <FindyKeyValue size="0.95rem" label="停止">ghost stop &lt;task_id&gt;</FindyKeyValue>
</div>

<FindyCallout class="mt-4">
  <code>&</code> や <code>nohup</code> と違い、起動・ログ確認・停止がコマンドひとつ。AI エージェントからも扱いやすい
</FindyCallout>

::right::

```sh
$ ghost run -- pnpm dev
Task started: 315681aa

$ ghost list
Task ID    Status   Command
315681aa   running  pnpm dev

$ ghost log -f 315681aa
VITE v6.3.5  ready in 347 ms
➜  Local: http://localhost:3030/

$ ghost stop 315681aa
Task stopped: 315681aa
```

<FindyRef>

[skanehira/ghost](https://github.com/skanehira/ghost)

</FindyRef>

---
layout: two-cols
ratio: 1/1
---

# portless

::left::

dev サーバーに <FindyAccentMark>**安定した URL**</FindyAccentMark> を自動割り当てするプロキシ

<div class="mt-4 space-y-3">
  <FindyKeyValue size="0.95rem" label="起動">portless myapp pnpm dev</FindyKeyValue>
  <FindyKeyValue size="0.95rem" label="URL">https://myapp.localhost</FindyKeyValue>
  <FindyKeyValue size="0.95rem" label="一覧">portless list</FindyKeyValue>
</div>

ポート番号を覚えなくていい。worktree ごとに URL が分かれるので並行開発でも衝突しない

::right::

```sh
$ portless myapp pnpm dev
✓ https://myapp.localhost → :3030

# 別の worktree でも同時に起動できる
$ portless myapp-feat pnpm dev
✓ https://myapp-feat.localhost → :3031

$ portless list
Name          URL                        Port
myapp         https://myapp.localhost     3030
myapp-feat    https://myapp-feat.localhost 3031
```

<FindyRef>

[vercel-labs/portless](https://github.com/vercel-labs/portless)

</FindyRef>

---
layout: content
---

# ツール単体ではなく「組み合わせ」で効く

スライド修正を Claude に頼んだとき、裏では紹介したツールがつながって動いている

<FindyFlow
  direction="horizontal"
  steps="Claude に依頼,worktree で\n作業を分離,dev サーバーで\n表示確認,PR 作成,スクショを\nPR に添付"
/>

- 編集タスクは worktree に分離 → ブランチが勝手に切り替わらない
- portless で worktree ごとに固有 URL → ポート競合なし
- dotfiles のルールとスキルに書いてあり、Claude が毎回再現する

<FindyCallout class="mt-4">
  置き場所は <a href="https://github.com/mozumasu/dotfiles" target="_blank">mozumasu/dotfiles</a> の
  <code>.config/claude/</code> — <code>rules/</code> (常に守る規約) と <code>skills/</code> (手順書)
</FindyCallout>

---
layout: content
---

# 各ツールの役割分担

<div class="mt-2">
  <FindyKeyValue size="0.82rem" label="herdr worktree">編集タスクをブランチごとの作業ディレクトリに分離。未コミット変更の混入や index.lock の競合を防ぐ — <a href="https://github.com/mozumasu/dotfiles/blob/main/.config/claude/rules/parallel-work.md" target="_blank" class="whitespace-nowrap">parallel-work.md</a></FindyKeyValue>
  <FindyKeyValue size="0.82rem" label="サブエージェント">読み取り専用の並列調査 (コードリーディングや grep)。worktree を分けるコストを払わない — <a href="https://github.com/mozumasu/dotfiles/blob/main/.config/claude/rules/parallel-work.md" target="_blank" class="whitespace-nowrap">parallel-work.md</a></FindyKeyValue>
  <FindyKeyValue size="0.82rem" label="ghost">dev サーバーなどのバックグラウンドプロセスを起動・ログ確認・停止できるジョブ管理ツール — <a href="https://github.com/mozumasu/dotfiles/blob/main/.config/claude/rules/background-process.md" target="_blank" class="whitespace-nowrap">background-process.md</a></FindyKeyValue>
  <FindyKeyValue size="0.82rem" label="portless">worktree ごとに <code>https://&lt;worktree&gt;.&lt;project&gt;.localhost</code> を自動割り当て。ポート番号の管理が不要になる — <a href="https://github.com/mozumasu/dotfiles/blob/main/.config/claude/rules/background-process.md" target="_blank" class="whitespace-nowrap">background-process.md</a></FindyKeyValue>
  <FindyKeyValue size="0.82rem" label="スキル">PR 作成後は pr-slide-screenshots が変更スライドを dev サーバーから撮影し、PR コメントに添付 — <a href="https://github.com/mozumasu/dotfiles/blob/main/.config/claude/skills/pr-slide-screenshots/SKILL.md" target="_blank" class="whitespace-nowrap">SKILL.md</a></FindyKeyValue>
  <FindyKeyValue size="0.82rem" label="Raycast">Script Command で Claude の git push 許可をトグル。hooks が状態ファイルを見て push をブロック / 許可する — <a href="https://github.com/mozumasu/dotfiles/blob/main/.config/claude/scripts/claude-git-push-ctl.sh" target="_blank" class="whitespace-nowrap">claude-git-push-ctl.sh</a></FindyKeyValue>
</div>

<FindyCallout class="mt-4">
  並列作業は 3 層で使い分ける — 進捗を見たい作業は <strong>herdr ペイン + worktree</strong>、
  使い捨ての調査は<strong>サブエージェント</strong>、非対話のプロセスは <strong>ghost + portless</strong>
</FindyCallout>
