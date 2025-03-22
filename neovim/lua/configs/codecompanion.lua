require("codecompanion").setup {
  display = {
    diff = {
      enabled = true,
      close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
      layout = "vertical", -- vertical|horizontal split for default provider
      opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
      provider = "mini_diff", -- default|mini_diff
    },
  },
  strategies = {
    chat = {
      roles = {
        ---The header name for the LLM's messages
        ---@type string|fun(adapter: CodeCompanion.Adapter): string
        llm = function(adapter)
          return adapter.formatted_name
        end,

        ---The header name for your messages
        ---@type string
        user = "hedzer",
      },
      adapter = "openai_compatible",
    },
    inline = {
      adapter = "openai_compatible",
    },
  },
  adapters = {
    openai_compatible = function()
      return require("codecompanion.adapters").extend("openai_compatible", {
        env = {
          url = "https://openrouter.ai/api",
          api_key = "YOUR-API-KEY",
          chat_url = "/v1/chat/completions",
        },
        schema = {
          model = {
            default = "YOUR-MODEL-PATH",
          },
        },
      })
    end,
  },
}
