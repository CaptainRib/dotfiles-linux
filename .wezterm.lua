local wezterm = require 'wezterm'
local mux = wezterm.mux
local config = wezterm.config_builder()

config.keys = {
  -- Turn off the default CMD-m Hide action, allowing CMD-m to
  -- be potentially recognized and handled by the tab
  {
    key = 'c',
    mods = 'CTRL',
    action=wezterm.action{CopyTo="Clipboard"}
  },
  {
    key = 'v',
    mods = 'CTRL',
    action=wezterm.action{PasteFrom="Clipboard"}
  },
  {
    key = 'c',
    mods = 'SUPER',
    action = wezterm.action{SendKey={key="c", mods="CTRL"}}
  },
  {
    key = 't',
    mods = 'CTRL',
    action = wezterm.action{SpawnTab="DefaultDomain"}
  },
  {
    key = 'w',
    mods = 'CTRL',
    action = wezterm.action{CloseCurrentTab={confirm=true}}
  },
  {
    key = "r",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SplitHorizontal({domain="CurrentPaneDomain"})
  },
  {
    key = "v",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SplitVertical({domain="CurrentPaneDomain"})
  },
  {key="1", mods="CTRL", action=wezterm.action.ActivateTab(0)},
  {key="2", mods="CTRL", action=wezterm.action.ActivateTab(1)},
  {key="3", mods="CTRL", action=wezterm.action.ActivateTab(2)},
  {key="4", mods="CTRL", action=wezterm.action.ActivateTab(3)},
  {key="5", mods="CTRL", action=wezterm.action.ActivateTab(4)},
  {key="6", mods="CTRL", action=wezterm.action.ActivateTab(5)},
  {key="7", mods="CTRL", action=wezterm.action.ActivateTab(6)},
  {key="8", mods="CTRL", action=wezterm.action.ActivateTab(7)},
  {key="9", mods="CTRL", action=wezterm.action.ActivateTab(8)},
}

config.use_fancy_tab_bar = true
config.font_size = 14
config.font = wezterm.font('MesloLGS NF')

wezterm.on('gui-startup', function(cmd)
  local default_dir = wezterm.home_dir .. "/workspace"

  -- First Tab
  local tab, pane, window = mux.spawn_window({
    args = cmd and cmd.args or {},
  })

  local pane_bottom = pane:split({
    direction = 'Bottom',
  })
  
  pane:send_text('bashtop\n')
  pane_bottom:send_text('nvtop\n')

  -- Second Tab
  local tab2, pane2, window2 = window:spawn_tab { cwd = default_dir }

  local right_pane = pane2:split({
    size = 0.5,
    cwd = default_dir,
  })

  right_pane:split({
    direction = 'Bottom',
    cwd = default_dir,
  })

  window:gui_window():maximize()
  pane2:activate()
  pane:activate()

end)

return config
