class Parser
  parse: (str) =>
    [key, value...] = str.split(':')
    value = value.join(':')
    
    result = {}
    result[key] = { name:value }
    result


exports.Parser = Parser

