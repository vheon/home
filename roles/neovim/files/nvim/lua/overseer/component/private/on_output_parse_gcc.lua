local log = require("overseer.log")
local parser = require("overseer.parser")
local problem_matcher = require("overseer.template.vscode.problem_matcher")

---@type overseer.ComponentFileDefinition
local comp = {
  desc = "Parses task output and sets task result",
  params = {
    parser = {
      desc = "Parser definition to extract values from output",
      type = "opaque",
      optional = true,
      order = 1,
    },
    precalculated_vars = {
      desc = "Precalculated VS Code task variables",
      long_desc = "Tasks that are started from the VS Code provider precalculate certain interpolated variables (e.g. ${workspaceFolder}). We pass those in as params so they will remain stable even if Neovim's state changes in between creating and running (or restarting) the task.",
      type = "opaque",
      optional = true,
      order = 4,
    },
  },
  constructor = function(params)
    if not params.parser then
      log:error("on_output_parse_gcc: 'parser' is required")
      return {}
    end
    local parser_defn = params.parser
    if not parser_defn then
      return {}
    end
    return {
      on_init = function(self, task)
        self.parser = parser.new(parser_defn)
        self.set_results_sub = function()
          local result = self.parser:get_result()
          task:set_result(result)
        end
        self.parser:subscribe("set_results", self.set_results_sub)
      end,
      on_dispose = function(self)
        if self.set_results_sub then
          self.parser:unsubscribe("set_results", self.set_results_sub)
          self.set_results_sub = nil
        end
      end,
      on_reset = function(self)
        self.parser:reset()
      end,
      on_output_lines = function(self, _, lines)
        self.parser:ingest(lines)
      end,
      on_pre_result = function(self, _)
        return self.parser:get_result()
      end,
    }
  end,
}

return comp
