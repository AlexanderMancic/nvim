vim.api.nvim_set_keymap('i', '(', '()<Left>', { noremap = true })
vim.api.nvim_set_keymap('i', '[', '[]<Left>', { noremap = true })
vim.api.nvim_set_keymap('i', '{', '{}<Left>', { noremap = true })
vim.api.nvim_set_keymap('i', '"', '""<Left>', { noremap = true })
vim.api.nvim_set_keymap('i', "'", "''<Left>", { noremap = true })
vim.api.nvim_set_keymap('i', ')', 'v:lua.CustomFunctions.closeParenthesis()', { expr = true, noremap = true })
vim.api.nvim_set_keymap('i', '}', 'v:lua.CustomFunctions.closeBraces()', { expr = true, noremap = true })
vim.api.nvim_set_keymap('i', ']', 'v:lua.CustomFunctions.closeBrackets()', { expr = true, noremap = true })
vim.api.nvim_set_keymap('i', '<BS>', 'v:lua.CustomFunctions.backspace()', { expr = true, noremap = true })
vim.api.nvim_set_keymap('i', '<CR>', 'v:lua.CustomFunctions.enter()', { expr = true, noremap = true })
vim.api.nvim_set_keymap('i', ';', 'v:lua.CustomFunctions.semicolon()', { expr = true, noremap = true })

_G.CustomFunctions = {}

function CustomFunctions.backspace()
  local col = vim.fn.col '.'
  local prev_char = vim.fn.getline('.'):sub(col - 1, col - 1)
  local next_char = vim.fn.getline('.'):sub(col, col)

  if
    (prev_char == '(' and next_char == ')')
    or (prev_char == '[' and next_char == ']')
    or (prev_char == '{' and next_char == '}')
    or (prev_char == '"' and next_char == '"')
  then
    -- Perform both backspace and delete actions
    return vim.api.nvim_replace_termcodes('<BS><Del>', true, true, true)
  end

  -- Perform a normal backspace
  return vim.api.nvim_replace_termcodes('<BS>', true, true, true)
end

function CustomFunctions.enter()
  local line = vim.fn.getline '.'
  local col = vim.fn.col '.'
  local prev_char = line:sub(col - 1, col - 1)
  local next_char = line:sub(col, col)

  -- Check if we're inside a pair of parentheses/braces/brackets
  if (prev_char == '(' and next_char == ')') or (prev_char == '{' and next_char == '}') or (prev_char == '[' and next_char == ']') then
    return vim.api.nvim_replace_termcodes('<CR><Esc>O', true, true, true)
  end

  -- Default behavior for Enter key
  return vim.api.nvim_replace_termcodes('<CR>', true, true, true)
end

function CustomFunctions.semicolon()
  local line = vim.fn.getline '.'
  local col = vim.fn.col '.'
  local prev_char = line:sub(col - 1, col - 1)

  -- Check if we're inside a pair of parentheses/braces/brackets
  if prev_char == ';' then
    return vim.api.nvim_replace_termcodes('<BS><Esc>A;', true, true, true)
  end

  -- Default behavior for Enter key
  return vim.api.nvim_replace_termcodes(';', true, true, true)
end

function CustomFunctions.closeParenthesis()
  local line = vim.fn.getline '.'
  local col = vim.fn.col '.'
  local next_char = line:sub(col, col)

  if next_char == ')' then
    return vim.api.nvim_replace_termcodes('<Right>', true, true, true)
  end

  return vim.api.nvim_replace_termcodes(')', true, true, true)
end

function CustomFunctions.closeBraces()
  local line = vim.fn.getline '.'
  local col = vim.fn.col '.'
  local next_char = line:sub(col, col)

  if next_char == '}' then
    return vim.api.nvim_replace_termcodes('<Right>', true, true, true)
  end

  return vim.api.nvim_replace_termcodes('}', true, true, true)
end

function CustomFunctions.closeBrackets()
  local line = vim.fn.getline '.'
  local col = vim.fn.col '.'
  local next_char = line:sub(col, col)

  if next_char == ']' then
    return vim.api.nvim_replace_termcodes('<Right>', true, true, true)
  end

  return vim.api.nvim_replace_termcodes(']', true, true, true)
end
