local jdtls = require('jdtls')

local debug_paths = vim.fn.glob("/run/current-system/sw/share/vscode/extensions/vscjava.vscode-java-debug/server/com.microsoft.java.debug.plugin-*.jar", true, true)
if #debug_paths == 0 then
  debug_paths = vim.fn.glob(vim.fn.expand("~/.nix-profile/share/vscode/extensions/vscjava.vscode-java-debug/server/com.microsoft.java.debug.plugin-*.jar"), true, true)
end

local bundles = {}
if #debug_paths > 0 then
  table.insert(bundles, debug_paths[1])
else
  vim.notify("Không tìm thấy vscode-java-debug từ Nix!", vim.log.levels.WARN)
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace-root/' .. project_name

local config = {
  cmd = {
    'jdtls',
    '-data', workspace_dir
  },
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'}),
  init_options = {
    bundles = bundles,
  },
  on_attach = function(client, bufnr)
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
    require('jdtls.dap').setup_dap_main_class_configs()
  end,
}

jdtls.start_or_attach(config)
