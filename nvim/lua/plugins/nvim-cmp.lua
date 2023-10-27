return {
  "hrsh7th/nvim-cmp",
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local cmp = require("cmp")
    opts.mapping = cmp.mapping.preset.insert({
      ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      -- ["<C-Space>"] = cmp.mapping.complete(),
      ["<Esc>"] = cmp.mapping.abort(),
      ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<S-Tab>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    })
  end,
}

-- return {
--   "hrsh7th/nvim-cmp",
--   dependencies = {
--     "hrsh7th/cmp-emoji",
--   },
--   ---@param opts cmp.ConfigSchema
--   opts = function(_, opts)
--     local has_words_before = function()
--       unpack = unpack or table.unpack
--       local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--       return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
--     end
--
--     local luasnip = require("luasnip")
--     local cmp = require("cmp")
--
--     opts.mapping = vim.tbl_extend("force", opts.mapping, {
--       ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
--       ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
--       ["<Tab>"] = cmp.mapping(function(fallback)
--         if cmp.visible() then
--           -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
--           cmp.confirm({ select = true })
--         -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
--         -- this way you will only jump inside the snippet region
--         elseif luasnip.expand_or_jumpable() then
--           luasnip.expand_or_jump()
--         elseif has_words_before() then
--           cmp.complete()
--         else
--           fallback()
--         end
--       end, { "i", "s" }),
--       ["<S-Tab>"] = cmp.mapping(function(fallback)
--         if cmp.visible() then
--           cmp.confirm({ select = true })
--         elseif luasnip.jumpable(-1) then
--           luasnip.jump(-1)
--         else
--           fallback()
--         end
--       end, { "i", "s" }),
--     })
--   end,
-- }
