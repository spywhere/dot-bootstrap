local registry = require('lib/registry')
local bindings = require('lib/bindings')

registry.install('mhinz/vim-signify', { lazy = 'vim-signify' })
registry.post(function ()
  vim.g.signify_sign_show_count = 0
end)
registry.install('tpope/vim-fugitive', { lazy = 'vim-fugitive' })
registry.post(function ()
  bindings.map.normal('gst', '<cmd>Gstatus<cr>')
end)
registry.install('itchyny/vim-gitbranch')
registry.install('rhysd/git-messenger.vim', { lazy = 'git-messenger.vim' })
