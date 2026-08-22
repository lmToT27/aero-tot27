local M = {}

local function get_kitty_accent()
  local kitty_conf = vim.fn.expand("~/.local/state/haku_theme/kitty-style.conf")
  local file = io.open(kitty_conf, "r")
  local accent = "#f38ba8" -- Màu dự phòng
  if file then
    for line in file:lines() do
      local hex = line:match("^foreground%s+(#[a-fA-F0-9]+)") or line:match("^color[45]%s+(#[a-fA-F0-9]+)")
      if hex then
        accent = hex
      end
    end
    file:close()
  end
  return accent
end

local my_accent = get_kitty_accent()

vim.api.nvim_create_autocmd({"UIEnter", "ColorScheme"}, {
  callback = function()
    vim.api.nvim_set_hl(0, "NvdashAscii", { fg = my_accent, bold = true })
    vim.api.nvim_set_hl(0, "NvdashButtons", { fg = my_accent })
  end,
})

M.base46 = {
  transparency = true,
  theme = "chadracula",
  hl_override = {
    NvdashAscii = { fg = my_accent },
    NvdashButtons = { fg = my_accent },
  },
}

M.ui = {
  statusline = {
    theme = "vscode",
    separator_style = "round",
  },
  tabufline = {
    enabled = true,
    lazyload = false,
    order = { "treeOffset", "buffers", "tabs" },
  },
}

M.nvdash = {
  load_on_startup = true,
  header = {
    "          ███╗   ██╗ ███████╗  ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗  ",
    "          ████╗  ██║ ██╔════╝ ██╔═══██╗ ██║   ██║ ██║ ████╗ ████║  ",
    "          ██╔██╗ ██║ █████╗   ██║   ██║ ██║   ██║ ██║ ██╔████╔██║  ",
    "          ██║╚██╗██║ ██╔══╝   ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║  ",
    "          ██║ ╚████║ ███████╗ ╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║  ",
    "          ╚═╝  ╚═══╝ ╚══════╝  ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝  ",
    "                                                                   ",
  },
  buttons = {
      { txt = "         Find File", keys = "ff", cmd = "Telescope find_files" },
      { txt = "         Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
      { txt = "       󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
      { txt = "       󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
      { txt = "         Mappings", keys = "ch", cmd = "NvCheatsheet" },
  },
}

return M
