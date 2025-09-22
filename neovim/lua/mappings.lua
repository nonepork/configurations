-- [[ Keymaps ]]
vim.keymap.set('n', '<Esc>', '<cmd>noh<CR>')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { silent = true })

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', '<C-n>', '')

vim.keymap.set({ 'n', 'v' }, 'j', 'gj')
vim.keymap.set({ 'n', 'v' }, 'k', 'gk')

-- stolen from and-rs
vim.keymap.set('v', '<', "<gv<C-o>'<", { desc = 'Inner indent while remaining in visual mode' })
vim.keymap.set('v', '>', ">gv<C-o>'<", { desc = 'Outer indent while remaining in visual mode' })

-- greatest remap here
vim.keymap.set('x', 'p', [["_dP]])
vim.keymap.set({ 'n', 'v' }, 'y', [["+y]])
vim.keymap.set('n', 'Y', [["+Y]])
vim.keymap.set({ 'n', 'v' }, 'd', [["_d]])

-- Diagnostic keymaps
vim.keymap.set(
  'n',
  '<leader>qd',
  '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
  { desc = 'Trouble: [Q]uickfix [D]iagnostic list', noremap = true, silent = true }
)
vim.keymap.set('n', '<leader>qt', '<cmd>Trouble todo toggle<cr>', { desc = 'Trouble: [Q]uickfix [T]odo list', noremap = true, silent = true })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- TODO: make this better
vim.keymap.set('n', '<C-up>', '3<C-w>+', { desc = 'Increase vertical window height', noremap = true, silent = true })
vim.keymap.set('n', '<C-down>', '3<C-w>-', { desc = 'Decrease vertical window height', noremap = true, silent = true })
vim.keymap.set('n', '<C-left>', '3<C-w><', { desc = 'Decrease horizontal window height', noremap = true, silent = true })
vim.keymap.set('n', '<C-right>', '3<C-w>>', { desc = 'Increase horizontal window height', noremap = true, silent = true })

function SmartBufDelete()
  local buf = vim.api.nvim_get_current_buf()
  local buftype = vim.bo[buf].buftype
  local tab_count = vim.fn.tabpagenr '$'
  local win_count = vim.fn.winnr '$'

  if buftype == 'help' or buftype == 'terminal' or buftype == 'health' then
    vim.cmd 'bd'
    if win_count == 1 and tab_count > 1 then
      vim.cmd 'tabclose'
    end
  else
    vim.cmd 'lua MiniBufremove.delete(0, true)'
    if win_count == 1 and tab_count > 1 then
      vim.cmd 'tabclose'
    end
  end
end

vim.keymap.set('n', '<Tab>', '<cmd>bnext<CR>', { desc = 'Next tab', noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', '<cmd>bprev<CR>', { desc = 'Previous tab', noremap = true, silent = true })
vim.keymap.set('n', 'C', '<cmd>lua SmartBufDelete()<CR>', { desc = 'Close buffer smartly', noremap = true, silent = true })

vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle nvim-tree', noremap = true, silent = true })
vim.keymap.set('n', '<leader>gi', '<cmd>GuessIndent<CR>', { desc = '[G]uess [I]ndent' })

vim.keymap.set('n', 'K', function() -- Stole from petter-tchirkov
  local is_diagnostic = require('misc').is_diagnostic()
  if is_diagnostic == true then
    return vim.diagnostic.open_float { scope = 'cursor', border = 'single' }
  else
    return vim.lsp.buf.hover { border = 'single' }
  end
end, { desc = 'Open docs/Show diagnostic in float' })

vim.keymap.set('n', '<leader>td', function()
  -- Customizable variables
  -- NOTE: Customize the completion label
  local label_done = 'done:'
  -- NOTE: Customize the timestamp format
  local timestamp = os.date '%y%m%d-%H%M'
  -- local timestamp = os.date("%y%m%d")
  -- NOTE: Customize the heading and its level
  local tasks_heading = '## Completed tasks'
  -- Save the view to preserve folds
  vim.cmd 'mkview'
  local api = vim.api
  -- Retrieve buffer & lines
  local buf = api.nvim_get_current_buf()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local start_line = cursor_pos[1] - 1
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local total_lines = #lines
  -- If cursor is beyond last line, do nothing
  if start_line >= total_lines then
    vim.cmd 'loadview'
    return
  end
  ------------------------------------------------------------------------------
  -- (A) Move upwards to find the bullet line (if user is somewhere in the chunk)
  ------------------------------------------------------------------------------
  while start_line > 0 do
    local line_text = lines[start_line + 1]
    -- Stop if we find a blank line or a bullet line
    if line_text == '' or line_text:match '^%s*%-' then
      break
    end
    start_line = start_line - 1
  end
  -- Now we might be on a blank line or a bullet line
  if lines[start_line + 1] == '' and start_line < (total_lines - 1) then
    start_line = start_line + 1
  end
  ------------------------------------------------------------------------------
  -- (B) Validate that it's actually a task bullet, i.e. '- [ ]' or '- [x]'
  ------------------------------------------------------------------------------
  local bullet_line = lines[start_line + 1]
  if not bullet_line:match '^%s*%- %[[x ]%]' then
    -- Not a task bullet => show a message and return
    print 'Not a task bullet: no action taken.'
    vim.cmd 'loadview'
    return
  end
  ------------------------------------------------------------------------------
  -- 1. Identify the chunk boundaries
  ------------------------------------------------------------------------------
  local chunk_start = start_line
  local chunk_end = start_line
  while chunk_end + 1 < total_lines do
    local next_line = lines[chunk_end + 2]
    if next_line == '' or next_line:match '^%s*%-' then
      break
    end
    chunk_end = chunk_end + 1
  end
  -- Collect the chunk lines
  local chunk = {}
  for i = chunk_start, chunk_end do
    table.insert(chunk, lines[i + 1])
  end
  ------------------------------------------------------------------------------
  -- 2. Check if chunk has [done: ...] or [untoggled], then transform them
  ------------------------------------------------------------------------------
  local has_done_index = nil
  local has_untoggled_index = nil
  for i, line in ipairs(chunk) do
    -- Replace `[done: ...]` -> `` `done: ...` ``
    chunk[i] = line:gsub('%[done:([^%]]+)%]', '`' .. label_done .. '%1`')
    -- Replace `[untoggled]` -> `` `untoggled` ``
    chunk[i] = chunk[i]:gsub('%[untoggled%]', '`untoggled`')
    if chunk[i]:match('`' .. label_done .. '.-`') then
      has_done_index = i
      break
    end
  end
  if not has_done_index then
    for i, line in ipairs(chunk) do
      if line:match '`untoggled`' then
        has_untoggled_index = i
        break
      end
    end
  end
  ------------------------------------------------------------------------------
  -- 3. Helpers to toggle bullet
  ------------------------------------------------------------------------------
  -- Convert '- [ ]' to '- [x]'
  local function bulletToX(line)
    return line:gsub('^(%s*%- )%[%s*%]', '%1[x]')
  end
  -- Convert '- [x]' to '- [ ]'
  local function bulletToBlank(line)
    return line:gsub('^(%s*%- )%[x%]', '%1[ ]')
  end
  ------------------------------------------------------------------------------
  -- 4. Insert or remove label *after* the bracket
  ------------------------------------------------------------------------------
  local function insertLabelAfterBracket(line, label)
    local prefix = line:match '^(%s*%- %[[x ]%])'
    if not prefix then
      return line
    end
    local rest = line:sub(#prefix + 1)
    return prefix .. ' ' .. label .. rest
  end
  local function removeLabel(line)
    -- If there's a label (like `` `done: ...` `` or `` `untoggled` ``) right after
    -- '- [x]' or '- [ ]', remove it
    return line:gsub('^(%s*%- %[[x ]%])%s+`.-`', '%1')
  end
  ------------------------------------------------------------------------------
  -- 5. Update the buffer with new chunk lines (in place)
  ------------------------------------------------------------------------------
  local function updateBufferWithChunk(new_chunk)
    for idx = chunk_start, chunk_end do
      lines[idx + 1] = new_chunk[idx - chunk_start + 1]
    end
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  end
  ------------------------------------------------------------------------------
  -- 6. Main toggle logic
  ------------------------------------------------------------------------------
  if has_done_index then
    chunk[has_done_index] = removeLabel(chunk[has_done_index]):gsub('`' .. label_done .. '.-`', '`untoggled`')
    chunk[1] = bulletToBlank(chunk[1])
    chunk[1] = removeLabel(chunk[1])
    chunk[1] = insertLabelAfterBracket(chunk[1], '`untoggled`')
    updateBufferWithChunk(chunk)
    vim.notify('Untoggled', vim.log.levels.INFO)
  elseif has_untoggled_index then
    chunk[has_untoggled_index] = removeLabel(chunk[has_untoggled_index]):gsub('`untoggled`', '`' .. label_done .. ' ' .. timestamp .. '`')
    chunk[1] = bulletToX(chunk[1])
    chunk[1] = removeLabel(chunk[1])
    chunk[1] = insertLabelAfterBracket(chunk[1], '`' .. label_done .. ' ' .. timestamp .. '`')
    updateBufferWithChunk(chunk)
    vim.notify('Completed', vim.log.levels.INFO)
  else
    -- Save original window view before modifications
    local win = api.nvim_get_current_win()
    local view = api.nvim_win_call(win, function()
      return vim.fn.winsaveview()
    end)
    chunk[1] = bulletToX(chunk[1])
    chunk[1] = insertLabelAfterBracket(chunk[1], '`' .. label_done .. ' ' .. timestamp .. '`')
    -- Remove chunk from the original lines
    for i = chunk_end, chunk_start, -1 do
      table.remove(lines, i + 1)
    end
    -- Append chunk under 'tasks_heading'
    local heading_index = nil
    for i, line in ipairs(lines) do
      if line:match('^' .. tasks_heading) then
        heading_index = i
        break
      end
    end
    if heading_index then
      for _, cLine in ipairs(chunk) do
        table.insert(lines, heading_index + 1, cLine)
        heading_index = heading_index + 1
      end
      -- Remove any blank line right after newly inserted chunk
      local after_last_item = heading_index + 1
      if lines[after_last_item] == '' then
        table.remove(lines, after_last_item)
      end
    else
      table.insert(lines, tasks_heading)
      for _, cLine in ipairs(chunk) do
        table.insert(lines, cLine)
      end
      local after_last_item = #lines + 1
      if lines[after_last_item] == '' then
        table.remove(lines, after_last_item)
      end
    end
    -- Update buffer content
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.notify('Completed', vim.log.levels.INFO)
    -- Restore window view to preserve scroll position
    api.nvim_win_call(win, function()
      vim.fn.winrestview(view)
    end)
  end
  vim.cmd 'loadview'
end, { desc = "[P]Toggle task and move it to 'done'" })

vim.keymap.set('n', '<leader>ta', function()
  -- Get the current line/row/column
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local row, _ = cursor_pos[1], cursor_pos[2]
  local line = vim.api.nvim_get_current_line()
  -- 1) If line is empty => replace it with "- [ ] " and set cursor after the brackets
  if line:match '^%s*$' then
    local final_line = '- [ ] '
    vim.api.nvim_set_current_line(final_line)
    -- "- [ ] " is 6 characters, so cursor col = 6 places you *after* that space
    vim.api.nvim_win_set_cursor(0, { row, 6 })
    return
  end
  -- 2) Check if line already has a bullet with possible indentation: e.g. "  - Something"
  --    We'll capture "  -" (including trailing spaces) as `bullet` plus the rest as `text`.
  local bullet, text = line:match '^([%s]*[-*]%s+)(.*)$'
  if bullet then
    -- Convert bullet => bullet .. "[ ] " .. text
    local final_line = bullet .. '[ ] ' .. text
    vim.api.nvim_set_current_line(final_line)
    -- Place the cursor right after "[ ] "
    -- bullet length + "[ ] " is bullet_len + 4 characters,
    -- but bullet has trailing spaces, so #bullet includes those.
    local bullet_len = #bullet
    -- We want to land after the brackets (four characters: `[ ] `),
    -- so col = bullet_len + 4 (0-based).
    vim.api.nvim_win_set_cursor(0, { row, bullet_len + 4 })
    return
  end
  -- 3) If there's text, but no bullet => prepend "- [ ] "
  --    and place cursor after the brackets
  local final_line = '- [ ] ' .. line
  vim.api.nvim_set_current_line(final_line)
  -- "- [ ] " is 6 characters
  vim.api.nvim_win_set_cursor(0, { row, 6 })
end, { desc = 'Convert bullet to a task or insert new task bullet' })

-- [[ Autocommands ]]
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
