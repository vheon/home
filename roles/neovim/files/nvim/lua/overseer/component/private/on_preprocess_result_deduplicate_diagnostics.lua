return {
  desc = "Remove duplicate diagnostics from results",
  editable = false,
  serializable = true,
  constructor = function()
    return {
      on_preprocess_result = function(_, _, result)
        if not result.diagnostics then return end
        ---@type table<string, true>
        local already_seen = {}
        result.diagnostics = vim.tbl_filter(function(diagnostic)
          local key = ("%s:%s:%s"):format(diagnostic.filename, diagnostic.lnum, diagnostic.text)
          if already_seen[key] then
            return false
          else
            already_seen[key] = true
            return true
          end
        end, result.diagnostics)
      end,
    }
  end,
}
