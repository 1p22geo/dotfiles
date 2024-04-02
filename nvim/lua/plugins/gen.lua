vim.keymap.set({ "n", "v" }, "<C-x>", ":Gen<CR>")

vim.keymap.set({ "n", "i" }, "<C-a>", function()
  local current_win = vim.api.nvim_get_current_win()
  local filename = vim.fn.expand("%:p")
  local pos = vim.api.nvim_win_get_cursor(current_win)
  vim.notify(string.format("Starting infill %s %s:%s`", filename, tostring(pos[1]), tostring(pos[2])))
  vim.api.nvim_cmd(
    vim.api.nvim_parse_cmd(string.format("!infill %s %s:%s", filename, tostring(pos[1]), tostring(pos[2])), {}),
    {}
  )
  vim.notify(string.format("DONE infill %s %s:%s`", filename, tostring(pos[1]), tostring(pos[2])))
end)
return {
  {
    "David-Kunz/gen.nvim",
    opts = {
      model = "codellama:34b", -- The default model to use.
      host = "minisforum", -- The host running the Ollama service.
      port = "9000", -- The port on which the Ollama service is listening.
      quit_map = "q", -- set keymap for close the response window
      retry_map = "<c-r>", -- set keymap to re-send the current prompt
      init = function(options) end,
      -- Function to initialize Ollama
      command = function(options)
        local body = { model = "codellama:34b", stream = true }
        return "curl --silent --no-buffer -X POST http://"
          .. options.host
          .. ":"
          .. options.port
          .. "/api/chat -d $body"
      end,
      -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
      -- This can also be a command string.
      -- The executed command must return a JSON object with { response, context }
      -- (context property is optional).
      -- list_models = '<omitted lua function>', -- Retrieves a list of model names
      display_mode = "float", -- The display mode. Can be "float" or "split".
      show_prompt = false, -- Shows the prompt submitted to Ollama.
      show_model = true, -- Displays which model you are using at the beginning of your chat session.
      no_auto_close = true, -- Never closes the window automatically.
      debug = false, -- Prints errors and the command which is run.
    },
  },
  {
    "sourcegraph/sg.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", --[[ "nvim-telescope/telescope.nvim ]]
    },

    -- If you have a recent version of lazy.nvim, you don't need to add this!
    build = "nvim -l build/init.lua",
  },
}
