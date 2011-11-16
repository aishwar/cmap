Parser = require('./main').Parser

describe 'Parser', ->
  beforeEach ->
    @parser = new Parser
  
  describe 'Parsing siblings', ->
    it 'Converts single key-value pair to JS map', ->
      input = 
      '''
      Person:Aishwar
      '''
      
      result = 
        Person:
          name:"Aishwar"
      
      (expect @parser.parse input).toEqual result
    
    
    it 'Converts multi-line (2 siblings) key-value pair to JS map', ->
      input =
      '''
      Person:Aishwar
      Person:Aishwar2
      '''
      
      result = 
        Person:[
          { name:'Aishwar' }
          { name:'Aishwar2' }
        ]
      
      (expect @parser.parse input).toEqual result
    
    
    it 'Converts multi-line (> 2 siblings) key-value pair to JS map', ->
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
    
