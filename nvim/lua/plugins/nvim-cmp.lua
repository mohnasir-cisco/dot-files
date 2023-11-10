return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    -- local select_opts = { behavior = cmp.SelectBehavior.Select }
    -- opts.performance = {
    --   trigger_debounce_time = 500,
    --   throttle = 550,
    --   fetching_timeout = 80,
    --   debounce = 150,
    -- }

    -- do not add no inser, it will not preselect the first item
    opts.completion = {
      completeopt = "menu,menuone",
    }

    opts.snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    }
    -- opts.experimental = {
    --   ghost_text = false,
    -- }
    opts.mapping = cmp.mapping.preset.insert({
      ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<Esc>"] = cmp.mapping.abort(),
      -- ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<S-Tab>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.confirm()
        elseif luasnip.expand_or_jumpable() then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
        else
          fallback()
        end
      end, { "i", "s" }),
      -- ["<S-Tab>"] = cmp.mapping(function(fallback)
      --   if cmp.visible() then
      --     cmp.select_prev_item()
      --   elseif luasnip.jumpable(-1) then
      --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      --   else
      --     fallback()
      --   end
      -- end),
      ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    })
    opts.sources = cmp.config.sources({
      -- { name = "nvim_lsp", keyword_length = 1 },
      { name = "cmp-nvim-lsp-signature-help" },
      { name = "path" }, -- file system paths
      { name = "nvim_lsp", keyword_length = 1 },
      { name = "buffer", keyword_length = 3 }, -- text within current buffer
      { name = "luasnip", keyword_length = 2 }, -- snippets
    })

    opts.sorting = {
      comparators = {
        cmp.config.compare.score,
        cmp.config.compare.offset,
        -- cmp.config.compare.exact,
        -- cmp.config.compare.kind,
        -- -- cmp.config.compare.sort_text,
        -- cmp.config.compare.length,
        -- cmp.config.compare.order,
      },
    }

    opts.window = {
      documentation = cmp.config.window.bordered(),
    }
    opts.formatting = {
      fields = { "menu", "abbr", "kind" },
      format = function(entry, item)
        local menu_icon = {
          nvim_lsp = "λ",
          luasnip = "⋗",
          buffer = "Ω",
          path = "🖫",
        }

        item.menu = menu_icon[entry.source.name]
        return item
      end,
    }

    --
    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })
    --
    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })

    -- For adding parans after method/function
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    -- local handlers = require("nvim-autopairs.completion.handlers")
    -- cmp.event:on(
    --   "confirm_done",
    --   cmp_autopairs.on_confirm_done({
    --     filetypes = {
    --       -- "*" is a alias to all filetypes
    --       ["*"] = {
    --         ["("] = {
    --           kind = {
    --             cmp.lsp.CompletionItemKind.Function,
    --             cmp.lsp.CompletionItemKind.Method,
    --           },
    --           handler = handlers["*"],
    --         },
    --       },
    --       html = {
    --         ["["] = {
    --           -- kind = {
    --           --   cmp.lsp.CompletionItemKind.Function,
    --           --   cmp.lsp.CompletionItemKind.Method,
    --           -- },
    --           ---@param char string
    --           ---@param item table item completion
    --           ---@param bufnr number buffer number
    --           ---@param rules table
    --           ---@param commit_character table<string>
    --           handler = function(char, item, bufnr, rules, commit_character)
    --             -- Your handler function. Inpect with print(vim.inspect{char, item, bufnr, rules, commit_character})
    --             print(vim.inspect({ char, item, bufnr, rules, commit_character }))
    --           end,
    --         },
    --       },
    --     },
    --   })
    -- )
  end,
}
