###
When an element is given a value, it is the name property of that element
to which the value is assigned.
E.g.
  "City:Toronto" will translate to "City: { name:Toronto }"


The following illustrates the major steps on how the parser does it's 
conversion:

Source:
  Person:Aishwar
    City:Toronto
    City:Scarborough

Major Steps in Transformation:
{ Person: { name:Aishwar} }
{ Person: { 
    name:Aishwar, 
    City: { name:Toronto }
  }
}
{ Person: {
    name:Aishwar,
    City: [ { name:Toronto } ]
  }
}
{ Person: {
    name:Aishwar
    City: [
      { name:Toronto },
      { name:Scarborough }
    ]
  }
}
###
_ = require('./helper')._

class Parser
  parse: (str) =>
    lines = str.split('\n')
    result = {}
    prevIndent = 0
    wholeKey = []
    
    lines.forEach (line) =>
      indent = _.indents(line)
      line = _.trim(line)
      return if line is ""
      
      [key, value...] = line.split(':')
      value = value.join(':')
      
      if (indent == prevIndent)
        wholeKey.pop()
        wholeKey.push(key)
      else if (indent > prevIndent)
        wholeKey.push(key)
      else
        wholeKey.pop()
      
      @setValue(result, wholeKey, value)
      
      prevIndent = indent
    result
  
  getLastItem: (result, key) ->
    if ((result = result?[key]) instanceof Array)
      result = result[result.length - 1]
    result
  
  setValue: (result, key, val) ->
    [parentProps..., childProp] = key
    parentProps.forEach (prop) =>
      result =  @getLastItem(result, prop)
    
    if (result)
      if (result[childProp])
        # If this is the first time there is a clash, convert the value 
        # into an Array that stores all values for this key
        result[childProp] = [ result[childProp] ] if !(result[childProp] instanceof Array)
          # Put the new value into the array
        result[childProp].push({ name: val })
      else
        if (val)
          if (childProp == 'name')
            # If the name property is being set, no need to set it as name = {name:val}, just set it as name = val
            result[childProp] = val
          else
            result[childProp] = { name: val }
        else
          # If a value is not provided, set the value to a blank map
          result[childProp] = {}

exports.Parser = Parser

