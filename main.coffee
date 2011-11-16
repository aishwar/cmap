class Parser
  parse: (str) =>
    lines = str.split('\n')
    result = {}
    
    lines.forEach (line) ->
      [key, value...] = line.split(':')
      value = value.join(':')
      
      if (result[key])
        # If this is the first time there is a clash, convert the value 
        # into an Array that stores all values for this key
        result[key] = [ result[key] ] if !(result[key] instanceof Array)
        # Put the new value into the array
        result[key].push({ name:value })
      else
        result[key] = { name:value }
    
    result


exports.Parser = Parser

