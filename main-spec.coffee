Parser = require('./main').Parser

describe 'Parser', ->
  beforeEach ->
    @parser = new Parser
  
  describe 'Parsing siblings', ->
    it 'Converts single key-value pair', ->
      input = 
      '''
      Person:Aishwar
      '''
      
      result = 
        Person:
          name:"Aishwar"
      
      (expect @parser.parse input).toEqual result
    
    
    it 'Converts multi-line key-value pair', ->
      input =
      '''
      Person:Aishwar
      Person:Aishwar2
      Person:Aishwar3
      Person:Aishwar4
      '''
      
      result = 
        Person:[
          { name:'Aishwar' }
          { name:'Aishwar2' }
          { name:'Aishwar3' }
          { name:'Aishwar4' }
        ]
      
      (expect @parser.parse input).toEqual result
  
