---- experimental
---@type overseer.ComponentFileDefinition
return {
  desc = 'filters results',
  -- Define parameters that can be passed in to the component
  params = {
    -- See :help overseer-params
  },
  editable = true,
  serializable = true,
  -- The params passed in will match the params defined above
  constructor = function(params)
    print('hello from my.filter')
    return {
      ---@param result table A result table.
      on_pre_result = function(self, task, result)
        -- Called right before on_result. Intended for logic that needs to preprocess the result table and update it in-place.
        print('on_preprocess_result', vim.inspect(result))
      end,
    }
  end,
}
