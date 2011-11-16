Parser = require('./main').Parser

describe 'Parser', ->
  beforeEach ->
    @parser = new Parser
  
  it 'Converts key-value pair to JS map', ->
    
