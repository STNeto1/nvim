local set = vim.keymap.set
local opt = vim.opt

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Make line numbers default
opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = 'a'

-- tab
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
opt.breakindent = true

-- Save undo history
-- opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = 'yes'
opt.shada = { "'10", '<0', 's10', 'h' }

-- Decrease update time
opt.updatetime = 250

opt.swapfile = false

opt.wrap = true
opt.linebreak = true

opt.more = false

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
-- opt.list = true
-- opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
opt.inccommand = 'split'

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Remap to "home"
set('n', '<leader>pv', vim.cmd.Ex)

-- Diagnostic keymaps
set('n', '<leader>[d', function()
  vim.diagnostic.jump { count = -1 }
end, { desc = 'Go to previous [D]iagnostics message' })

set('n', '<leader>]d', function()
  vim.diagnostic.jump { count = 1 }
end, { desc = 'Go to next [D]iagnostics message' })
set('n', '<leader>vd', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror message' })
set('n', '<leader>t', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
set('n', '<leader>e', function()
  vim.diagnostic.setqflist()
end, { desc = 'No idea' })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- quickfix list
set('n', '<leader>[q', vim.cmd.cp, { desc = 'Go to previous quickfix list item' })
set('n', '<leader>]q', vim.cmd.cn, { desc = 'Go to next quickfix list item' })
set('n', '<leader>[[', vim.cmd.cclose, { desc = 'Go to next quickfix list item' })
set('n', '<leader>]]', vim.cmd.copen, { desc = 'Go to next quickfix list item' })

vim.opt.spell = true
vim.opt.spelllang = { 'pt_br', 'en_us' }
-- set('n', '<leader>ss', ':set spell!<CR>', { desc = 'Toggle spell check' })
-- set('n', '<leader>sn', ']s', { desc = 'Next misspelled word' })
-- set('n', '<leader>sp', '[s', { desc = 'Previous misspelled word' })
set('n', '<leader>sa', 'zg', { desc = 'Add word to dictionary' })
set('n', '<leader>s?', 'z=', { desc = 'Spelling suggestions' })
