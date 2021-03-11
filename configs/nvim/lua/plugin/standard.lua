local registry = require('lib/registry')

registry.install('editorconfig/editorconfig-vim')
registry.post(function ()
  vim.g.Editorconfig_exclude_patterns = { 'fugitive://.*', 'scp://.*' }
end)
registry.install('tpope/vim-sensible')
