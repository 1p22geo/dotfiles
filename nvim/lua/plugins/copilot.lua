return {}
  or {
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("copilot").setup({
          panel = {
            enabled = true,
            auto_refresh = true,
            keymap = {
              jump_prev = "[[",
              jump_next = "]]",
              accept = "<CR>",
              refresh = "gr",
              open = "<M-CR>",
            },
            layout = {
              position = "bottom",
              ratio = 0.4,
            },
          },
          suggestion = {
            enabled = true,
            auto_trigger = true,
            debounce = 75,
            keymap = {
              accept = "<M-l>",
              accept_word = false,
              accept_line = false,
              next = "<M-]>",
              prev = "<M-[>",
              dismiss = "<C-]>",
            },
          },
          filetypes = {
            yaml = true,
            markdown = true,
            help = false,
            gitcommit = true,
            gitrebase = true,
            hgcommit = false,
            svn = false,
            cvs = false,
            ["."] = false,
          },
          copilot_node_command = "node",
          server_opts_overrides = {},
        })
      end,
    },

    {
      "CopilotC-Nvim/CopilotChat.nvim",
      branch = "canary",
      dependencies = {
        { "zbirenbaum/copilot.lua" },
        { "nvim-lua/plenary.nvim" },
      },
      opts = {
        debug = false,
        show_help = "yes",
        prompts = {
          Explain = "Explain how this code works.",
          Review = "Review this code and provide concise suggestions.",
          Tests = "Briefly explain how the selected code works, then generate unit tests.",
          Refactor = "Refactor this code to improve clarity and readability.",
          FixCode = "Fix the following code to make it work as intended.",
          FixError = "Explain the error in the following text and provide a solution.",
          BetterNamings = "Provide better names for the following variables and functions.",
          Documentation = "Write documentation for the following code.",
          SwaggerApiDocs = "Write swagger API documentation for the following code.",
          SwaggerJsDocs = "Write JSDoc comments for the following code.",
          Summarize = "Summarize the following text.",
          Spelling = "Correct any grammar and spelling errors in the following text.",
          Wording = "Improve the grammar and wording of the following text.",
          Concise = "Rewrite the following text to make it more concise.",
        },
        auto_follow_cursor = true,
        window = {
          layout = "vertical",
          width = 0.5,
          height = 0.5,
          relative = "editor",
        },
        mappings = {
          complete = {
            detail = "Use @<Tab> or /<Tab> for options.",
            insert = "<Tab>",
          },
          close = {
            normal = "q",
            insert = "<C-c>",
          },
          reset = {
            normal = "<C-l>",
            insert = "<C-l>",
          },
          submit_prompt = {
            normal = "<CR>",
            insert = "<C-s>",
          },
          accept_diff = {
            normal = "<C-y>",
            insert = "<C-y>",
          },
          yank_diff = {
            normal = "gy",
          },
          show_diff = {
            normal = "gd",
          },
          show_system_prompt = {
            normal = "gp",
          },
          show_user_selection = {
            normal = "gs",
          },
        },
      },
      config = function(_, opts)
        local chat = require("CopilotChat")
        local select = require("CopilotChat.select")

        opts.selection = select.unnamed

        chat.setup(opts)

        vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
          chat.ask(args.args, { selection = select.visual })
        end, { nargs = "*", range = true })

        vim.api.nvim_create_user_command("CopilotChatInline", function(args)
          chat.ask(args.args, {
            selection = select.visual,
            window = {
              layout = "float",
              relative = "cursor",
              width = 1,
              height = 0.4,
              row = 1,
            },
          })
        end, { nargs = "*", range = true })

        vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
          chat.ask(args.args, { selection = select.buffer })
        end, { nargs = "*", range = true })

        vim.api.nvim_create_autocmd("BufEnter", {
          pattern = "copilot-*",
          callback = function()
            vim.opt_local.relativenumber = true
            vim.opt_local.number = true
          end,
        })
      end,
      event = "VeryLazy",
      keys = {
        { "<leader>cpe", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
        { "<leader>cpt", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
        { "<leader>cpr", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
        { "<leader>cpR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
        { "<leader>cpn", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },
        { "<leader>cpv", ":CopilotChatVisual ", mode = "x", desc = "CopilotChat - Open in vertical split" },
        { "<leader>cpx", ":CopilotChatInline<cr>", mode = "x", desc = "CopilotChat - Inline chat" },
        {
          "<leader>cpi",
          function()
            local input = vim.fn.input("Ask Copilot: ")
            if input ~= "" then
              vim.cmd("CopilotChat " .. input)
            end
          end,
          desc = "CopilotChat - Ask input",
        },
        { "<leader>cpm", "<cmd>CopilotChatCommit<cr>", desc = "CopilotChat - Generate commit message" },
        {
          "<leader>cpM",
          "<cmd>CopilotChatCommitStaged<cr>",
          desc = "CopilotChat - Generate commit message for staged",
        },
        {
          "<leader>cpq",
          function()
            local input = vim.fn.input("Quick Chat: ")
            if input ~= "" then
              require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
            end
          end,
          desc = "CopilotChat - Quick chat",
        },
        { "<leader>cpd", "<cmd>CopilotChatDebugInfo<cr>", desc = "CopilotChat - Debug Info" },
        { "<leader>cpf", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
        { "<leader>cpl", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Clear buffer and chat history" },
        { "<leader>cpb", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
        { "<leader>cp?", "<cmd>CopilotChatModels<cr>", desc = "CopilotChat - Select Models" },
      },
    },
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        {
          "zbirenbaum/copilot-cmp",
          dependencies = { "zbirenbaum/copilot.lua" },
          config = function()
            require("copilot_cmp").setup()
          end,
        },
      },
      opts = function(_, opts)
        table.insert(opts.sources, 1, {
          name = "copilot",
          group_index = 1,
          priority = 100,
        })
      end,
    },
    {
      "nvim-lualine/lualine.nvim",
      optional = true,
      event = "VeryLazy",
      opts = function(_, opts)
        local snacks = require("snacks")
        local colors = {
          [""] = { fg = snacks.util.color("Special") },
          ["Normal"] = { fg = snacks.util.color("Special") },
          ["Warning"] = { fg = snacks.util.color("DiagnosticError") },
          ["InProgress"] = { fg = snacks.util.color("DiagnosticWarn") },
        }
        table.insert(opts.sections.lualine_x, 2, {
          function()
            local icon = require("lazyvim.config").icons.kinds.Copilot
            local status = require("copilot.api").status.data
            return icon .. (status.message or "")
          end,
          cond = function()
            if not package.loaded["copilot"] then
              return
            end
            local ok, clients = pcall(vim.lsp.get_clients, { name = "copilot", bufnr = 0 })
            if not ok then
              return false
            end
            return ok and #clients > 0
          end,
          color = function()
            if not package.loaded["copilot"] then
              return
            end
            local status = require("copilot.api").status.data
            return colors[status.status] or colors[""]
          end,
        })
      end,
    },
  }
