local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- Bật tính năng Error Lens (Hiển thị chữ đỏ cuối dòng)
vim.diagnostic.config({
  virtual_text = {
    prefix = "■ ",
  },
})

-- SỬ DỤNG API MỚI CHO NEOVIM 0.11+ (Triệt tiêu cảnh báo Deprecated)
-- Thay vì require("lspconfig").server.setup, dùng vim.lsp.config

-- 1. Cấu hình Lua
vim.lsp.config.lua_ls = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
vim.lsp.enable("lua_ls")

-- 2. Cấu hình C++ (clangd)
vim.lsp.config.clangd = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "cpp", "c", "objc", "objcpp" },
}
vim.lsp.enable("clangd")

-- 3. Cấu hình Python (pyright)
vim.lsp.config.pyright = {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
vim.lsp.enable("pyright")
