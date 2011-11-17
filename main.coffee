_ = require('./helper')._

class Parser
  parse: (str) =>
    lines = str.split('\n')
    result = {}
    @prevIndent = 0
    @wholeKey = []
    
    console.log()
    console.log()
    console.log(lines.length)
    lines.forEach (line) =>
      @indent = _.indents(line)
      line = _.trim(line)
      return if line is ""
      
      [key, value...] = line.split(':')
      value = value.join(':')
      
      if (@indent == @prevIndent)
        @wholeKey.pop()
        @wholeKey.push(key)
      else if (@indent > @prevIndent)
        @wholeKey.push(key)
      else
        @wholeKey.pop()
      
      @setValue(result, @wholeKey, value)
      
      @prevIndent = @indent
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
        result[childProp] = { name: val }

exports.Parser = Parser

