local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

-- 設定ファイルの変更を自動で読み込む
config.automatically_reload_config = true

------------------------------------------------------------------------
-- フォント
------------------------------------------------------------------------
config.font_size = 14.0
config.font = wezterm.font("HackGen Console NF")

------------------------------------------------------------------------
-- 見た目
------------------------------------------------------------------------
-- 背景を透過 + ぼかし (macOS)
config.window_background_opacity = 0.85
config.macos_window_background_blur = 20

-- タイトルバーを非表示 / タブが 1 つならタブバーも非表示
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

-- アクティブなタブだけ黄色にする
wezterm.on("format-tab-title", function(tab)
  local bg = tab.is_active and "#ae8b2d" or "#5c6d74"
  return {
    { Background = { Color = bg } },
    { Text = " " .. tab.active_pane.title .. " " },
  }
end)

------------------------------------------------------------------------
-- Leader キー
------------------------------------------------------------------------
config.leader = {
  key = ";",
  mods = "CTRL",
  timeout_milliseconds = 2000,
}

------------------------------------------------------------------------
-- キーバインド
------------------------------------------------------------------------
config.keys = {
  -- コマンドパレット
  { key = "p", mods = "CTRL|SHIFT",
    action = act.ActivateCommandPalette },

  -- ペイン分割
  { key = "|", mods = "LEADER|SHIFT",
    action = act.SplitHorizontal{} },
  { key = "-", mods = "LEADER",
    action = act.SplitVertical{} },

  -- ペイン移動 (Vim 方向キー)
  { key = "h", mods = "LEADER",
    action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER",
    action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER",
    action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER",
    action = act.ActivatePaneDirection("Right") },

  -- ペインズーム
  { key = "z", mods = "LEADER",
    action = act.TogglePaneZoomState },

  -- Claude Code 用: Shift+Enter で改行を送る
  { key = "Enter", mods = "SHIFT",
    action = act.SendString("\n") },
}

------------------------------------------------------------------------
-- keybinds.lua から読み込む場合 (wezterm show-keys --lua > keybinds.lua)
------------------------------------------------------------------------
-- config.keys = require("keybinds").keys
-- config.key_tables = require("keybinds").key_tables

return config
