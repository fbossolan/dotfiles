-- ============================================================================
-- OPTIONS
-- ============================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local o = vim.opt
o.termguicolors = true
o.number = true
o.relativenumber = true
o.cursorline = true
o.signcolumn = "yes"
o.wrap = false
o.scrolloff = 8
o.sidescrolloff = 8
o.showmode = false          -- the statusline shows the mode
o.laststatus = 3            -- one global statusline
o.fillchars = { eob = " " } -- hide the ~ on empty lines
o.splitbelow = true
o.splitright = true
o.ignorecase = true
o.smartcase = true
o.inccommand = "split"      -- live preview for :s
o.expandtab = true
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.smartindent = true
o.undofile = true
o.swapfile = false
o.backup = false
o.writebackup = false
o.autoread = true
o.updatetime = 250
o.timeoutlen = 400
o.clipboard = "unnamedplus"
o.mouse = "a"
o.pumheight = 12
o.completeopt = "menuone,noselect,popup"
o.wildmode = "longest:full,full"
o.wildoptions:append("fuzzy")
o.path:append("**")           -- :find searches subdirectories

if vim.fn.executable("rg") == 1 then
  o.grepprg = "rg --vimgrep --smart-case --hidden --glob '!.git/'"
  o.grepformat = "%f:%l:%c:%m"
end

vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = -25 -- negative = columns (positive = percent)

-- per-filetype indentation
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "python" },
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
  end,
})

-- ============================================================================
-- THEME: Catppuccin Mocha, no plugin. Transparent background (inherits from the terminal).
-- ============================================================================
local p = {
  base = "#1e1e2e", mantle = "#181825", surface0 = "#313244", surface1 = "#45475a",
  surface2 = "#585b70", overlay0 = "#6c7086", overlay1 = "#7f849c", subtext0 = "#a6adc8",
  text = "#cdd6f4", rosewater = "#f5e0dc", flamingo = "#f2cdcd", pink = "#f5c2e7",
  mauve = "#cba6f7", red = "#f38ba8", maroon = "#eba0ac", peach = "#fab387",
  yellow = "#f9e2af", green = "#a6e3a1", teal = "#94e2d5", sky = "#89dceb",
  sapphire = "#74c7ec", blue = "#89b4fa", lavender = "#b4befe",
}

vim.cmd("highlight clear")
vim.g.colors_name = "catppuccin-mocha-min"

local hl = {
  Normal       = { fg = p.text, bg = "NONE" },
  NormalNC     = { bg = "NONE" },
  NormalFloat  = { fg = p.text, bg = p.mantle },
  FloatBorder  = { fg = p.overlay0, bg = p.mantle },
  CursorLine   = { bg = p.mantle },
  CursorLineNr = { fg = p.lavender, bold = true },
  LineNr       = { fg = p.surface2 },
  SignColumn   = { bg = "NONE" },
  WinSeparator = { fg = p.surface1 },
  Visual       = { bg = p.surface1 },
  Search       = { fg = p.base, bg = p.yellow },
  IncSearch    = { fg = p.base, bg = p.peach },
  MatchParen   = { fg = p.peach, bold = true },
  Pmenu        = { fg = p.text, bg = p.mantle },
  PmenuSel     = { fg = p.base, bg = p.blue, bold = true },
  Folded       = { fg = p.overlay1, bg = p.mantle },
  Comment      = { fg = p.overlay0, italic = true },
  Constant     = { fg = p.peach },
  String       = { fg = p.green },
  Number       = { fg = p.peach },
  Boolean      = { fg = p.peach },
  Identifier   = { fg = p.text },
  Function     = { fg = p.blue },
  Statement    = { fg = p.mauve },
  Keyword      = { fg = p.mauve },
  Operator     = { fg = p.sky },
  Type         = { fg = p.yellow },
  PreProc      = { fg = p.mauve },
  Special      = { fg = p.pink },
  Delimiter    = { fg = p.subtext0 },
  Error        = { fg = p.red },
  StatusLine   = { fg = p.base, bg = p.green },
  StatusLineNC = { fg = p.subtext0, bg = p.surface0 },
  DiagnosticError = { fg = p.red },
  DiagnosticWarn  = { fg = p.yellow },
  DiagnosticInfo  = { fg = p.sky },
  DiagnosticHint  = { fg = p.teal },
  DiagnosticUnderlineError = { undercurl = true, sp = p.red },
  DiagnosticUnderlineWarn  = { undercurl = true, sp = p.yellow },
  DiagnosticUnderlineInfo  = { undercurl = true, sp = p.sky },
  DiagnosticUnderlineHint  = { undercurl = true, sp = p.teal },
}
for group, opts in pairs(hl) do
  vim.api.nvim_set_hl(0, group, opts)
end

-- ============================================================================
-- STATUSLINE (branch cached: no git call on every redraw)
-- ============================================================================
local mode_names = {
  n = "NORMAL", i = "INSERT", v = "VISUAL", V = "V-LINE", ["\22"] = "V-BLOCK",
  c = "COMMAND", R = "REPLACE", s = "SELECT", t = "TERMINAL",
}
local branch = ""

local function refresh_branch()
  local out = vim.fn.systemlist("git branch --show-current 2>/dev/null")
  branch = (vim.v.shell_error == 0 and out[1] and out[1] ~= "") and ("  " .. out[1]) or ""
end

function _G.statusline()
  local mode = mode_names[vim.fn.mode()] or vim.fn.mode()
  return string.format("  %s │ %%f %%h%%m%%r%s │ %%y%%=%%l:%%c  %%P ", mode, branch)
end

vim.o.statusline = "%{%v:lua.statusline()%}"

vim.api.nvim_create_autocmd({ "BufEnter", "DirChanged", "FocusGained" }, {
  callback = refresh_branch,
})

-- ============================================================================
-- KEYMAPS: general
-- ============================================================================
local map = vim.keymap.set

map("n", "<leader>w", "<cmd>write<CR>", { desc = "Save" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Close window" })
map("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Quit all" })
map("n", "<leader>wq", "<cmd>x<CR>", { desc = "Save and quit" })
map("n", "<leader>c", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<leader>e", "<cmd>Lexplore<CR>", { desc = "Toggle file explorer" })
map("n", "<leader>ff", ":find ", { desc = "Find file" })
map("n", "Y", "y$", { desc = "Yank to end of line" })
map("n", "n", "nzzzv", { desc = "Next match (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous match (centered)" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
map("n", "<M-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<M-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("v", "<M-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- windows: C-h/j/k/l to move, <C-w>+ - < > to resize (native)
map("n", "<C-h>", "<C-w>h", { desc = "Left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Right window" })

-- buffers
map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
map("n", "<leader>b", ":ls<CR>:b ", { desc = "Switch buffer" })

-- copy file names
local function yank(expr, what)
  return function()
    vim.fn.setreg("+", vim.fn.expand(expr))
    vim.notify(what .. " copied")
  end
end
map("n", "<leader>fn", yank("%:t", "file name"), { desc = "Copy file name" })
map("n", "<leader>fp", yank("%:p", "full path"), { desc = "Copy full path" })
map("n", "<leader>fr", yank("%:.", "relative path"), { desc = "Copy relative path" })

-- grep (results open in quickfix automatically)
map("n", "<leader>g", ":silent grep! ", { desc = "Grep" })
map("n", "<leader>G", ":silent grep! <C-r><C-w> .<CR>", { desc = "Grep word under cursor" })

-- run and test (pdb: put breakpoint() in the code and run <leader>rr)
map("n", "<leader>rr", "<cmd>write | split | terminal python %<CR>", { desc = "Run file" })
map("n", "<leader>rt", "<cmd>write | compiler pytest | make %<CR>", { desc = "Test file (quickfix)" })
map("n", "<leader>rT", "<cmd>write | compiler pytest | make<CR>", { desc = "Test project (quickfix)" })

-- ============================================================================
-- AUTOCOMMANDS
-- ============================================================================
local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- reload files changed outside nvim (pairs with focus-events in tmux)
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  group = augroup,
  command = "if mode() != 'c' | checktime | endif",
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function() vim.hl.on_yank() end,
})

-- reopen files at the last edit position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- netrw: after opening a file with "v" (new split), keep the tree at its width
vim.api.nvim_create_autocmd("WinNew", {
  group = augroup,
  callback = function()
    vim.schedule(function()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "netrw" then
          vim.api.nvim_win_set_width(win, 25)
        end
      end
    end)
  end,
})

-- netrw: if the editor window closes and only the tree is left, open an empty one
-- (otherwise opening a file from the tree fails with E471 "keepj keepalt 2wincmd 1")
vim.api.nvim_create_autocmd("WinClosed", {
  group = augroup,
  callback = function()
    vim.schedule(function()
      local wins = vim.api.nvim_list_wins()
      if #wins == 1 and vim.bo[vim.api.nvim_win_get_buf(wins[1])].filetype == "netrw" then
        vim.cmd("rightbelow vnew")
        vim.api.nvim_set_current_win(wins[1]) -- focus stays on the tree
      end
    end)
  end,
})

-- open quickfix after grep
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  group = augroup,
  pattern = "[^l]*",
  command = "cwindow",
})

-- show the diagnostic under the cursor after a short pause
vim.api.nvim_create_autocmd("CursorHold", {
  group = augroup,
  callback = function() vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" }) end,
})

-- terminal buffers: no numbers, close when the shell exits cleanly
vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup,
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.signcolumn = "no"
  end,
})
vim.api.nvim_create_autocmd("TermClose", {
  group = augroup,
  callback = function(ev)
    if vim.v.event.status == 0 then vim.api.nvim_buf_delete(ev.buf, { force = true }) end
  end,
})

-- ============================================================================
-- FLOATING TERMINAL: <leader>tt toggles, <Esc><Esc> hides from terminal mode
-- ============================================================================
local term = { buf = nil, win = nil }

local function toggle_term()
  if term.win and vim.api.nvim_win_is_valid(term.win) then
    vim.api.nvim_win_hide(term.win)
    term.win = nil
    return
  end
  if not (term.buf and vim.api.nvim_buf_is_valid(term.buf)) then
    term.buf = vim.api.nvim_create_buf(false, true)
  end
  local w = math.floor(vim.o.columns * 0.8)
  local h = math.floor(vim.o.lines * 0.8)
  term.win = vim.api.nvim_open_win(term.buf, true, {
    relative = "editor",
    width = w,
    height = h,
    row = math.floor((vim.o.lines - h) / 2),
    col = math.floor((vim.o.columns - w) / 2),
    style = "minimal",
    border = "rounded",
  })
  if vim.bo[term.buf].buftype ~= "terminal" then
    vim.fn.jobstart({ vim.o.shell }, { term = true })
  end
  vim.cmd("startinsert")
end

map("n", "<leader>tt", toggle_term, { desc = "Toggle floating terminal" })
map("t", "<Esc><Esc>", toggle_term, { desc = "Hide floating terminal" })

-- ============================================================================
-- LSP (native, no plugins). Servers: basedpyright + ruff for Python, lua_ls for this config.
-- ============================================================================
vim.lsp.config("basedpyright", {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", ".git" },
  settings = {
    basedpyright = {
      analysis = { typeCheckingMode = "standard", autoImportCompletions = true },
    },
  },
})

vim.lsp.config("ruff", {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
})

vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".git" },
  settings = { Lua = { diagnostics = { globals = { "vim" } } } },
})

vim.lsp.enable({ "basedpyright", "ruff", "lua_ls" })

vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  virtual_text = { spacing = 2, prefix = "●" },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local buf = ev.buf

    -- hover comes from basedpyright; ruff only contributes lint and format
    if client.name == "ruff" then
      client.server_capabilities.hoverProvider = false
    end

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })

      -- also complete while typing words (autotrigger only fires on "." and friends)
      vim.api.nvim_create_autocmd("TextChangedI", {
        group = vim.api.nvim_create_augroup("LspWordComplete" .. buf, { clear = true }),
        buffer = buf,
        callback = function()
          local col = vim.api.nvim_win_get_cursor(0)[2]
          local char = vim.api.nvim_get_current_line():sub(col, col)
          if vim.fn.pumvisible() == 0 and char:match("[%w_]") then
            vim.lsp.completion.get()
          end
        end,
      })
    end

    local lmap = function(keys, fn, desc)
      map("n", keys, fn, { buffer = buf, desc = desc })
    end
    lmap("gd", vim.lsp.buf.definition, "Go to definition")
    lmap("<leader>rn", vim.lsp.buf.rename, "Rename")
    lmap("<leader>ca", vim.lsp.buf.code_action, "Code action")
    lmap("<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format")

    -- inferred types inline (basedpyright); toggle because it can be noisy
    if client.name == "basedpyright" then
      vim.lsp.inlay_hint.enable(true, { bufnr = buf })
      lmap("<leader>ih", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
      end, "Toggle inlay hints")
    end
  end,
})

-- format Python on save with ruff
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = "*.py",
  callback = function(ev)
    vim.lsp.buf.format({
      bufnr = ev.buf,
      timeout_ms = 1000,
      filter = function(client) return client.name == "ruff" end,
    })
  end,
})

-- diagnostics navigation
map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Previous diagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- completion: Tab/S-Tab move through the menu, Enter accepts, C-Space forces it
map("i", "<C-Space>", function() vim.lsp.completion.get() end, { desc = "Trigger completion" })
map("i", "<Tab>", function()
  return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end, { expr = true })
map("i", "<S-Tab>", function()
  return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
end, { expr = true })
map("i", "<CR>", function()
  return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
end, { expr = true })
