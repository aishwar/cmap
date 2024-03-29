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
  
  
  describe 'Parse children', ->
  
    it 'Converts Parent-Child key-value pair', ->
      input = 
      '''
      Person:Aishwar
        City:Toronto
          Area:Scarborough
      '''
      
      result =
        Person:
          name:"Aishwar"
          City:
            name:"Toronto"
            Area:
              name:"Scarborough"
      
      (expect @parser.parse input).toEqual result
    
    
    it 'Converts Parent-Sibling-Child', ->
      input = 
      '''
      Person:Aishwar
        City:Chennai
        City:Toronto
          Area:Scarborough
      '''
      
      result =
        Person:
          name:"Aishwar"
          City:
            [
              { name:"Chennai" }
              { name:"Toronto", Area: name:"Scarborough" } 
            ]
      
      (expect @parser.parse input).toEqual result
      
    
    it 'Converts Multiple Sibling-with-Child', ->
      input = 
      '''
      Person:Aishwar
        City:Chennai
          Area:Nungambakkam
        City:Toronto
          Area:Scarborough
      '''
      
      result =
        Person:
          name:"Aishwar"
          City:
            [
              { name:"Chennai", Area: name:"Nungambakkam" }
              { name:"Toronto", Area: name:"Scarborough" } 
            ]
      
      (expect @parser.parse input).toEqual result
      
    
    it 'Converts Multiple Sibling-with-Multiple-Children', ->
      input = 
      '''
      Person:Aishwar
        Address:Home
          City:Toronto
          Area:North York
        Address:Work
          City:Toronto
          Area:Scarborough
      '''
      
      result =
        Person:
          name:"Aishwar"
          Address:
            [
              {
                name:"Home"
                City:
                  name: "Toronto"
                Area:
                  name: "North York" 
              }
              {
                name:"Work"
                City:
                  name: "Toronto"
                Area:
                  name: "Scarborough"
              } 
            ]
      
      (expect @parser.parse input).toEqual result

    it 'Converts blank input correctly', ->
      input =
      '''
      '''
      
      result = {}
      
      (expect @parser.parse input).toEqual result
    
    it 'Converts when name is not specified on same line as item', ->
      input =
      '''
        Person
          name:Aishwar
      '''
      
      result = {
        Person:
          name:"Aishwar"
      }
      
      (expect @parser.parse input).toEqual result
    
    
    it 'Converts when name is not specified', ->
      input =
      '''
        Person
          Address:Home
            City:Toronto
          Address:Work
            City:Toronto
            Area:North York
      '''
      
      result = {
        Person:
          Address: [
            {
              name:"Home"
              City:
                name:"Toronto"
            },
            {
              name:"Work"
              City:
                name:"Toronto"
              Area:
                name:"North York"
            }
          ]
      }
      
      (expect @parser.parse input).toEqual result
    
    
    it 'Converts when properties read are multiple-indentation levels different', ->
      # Moving from Area to Address, changes by 2 indentation levels
      input =
      '''
        Person
          Address:Home
            City:Toronto
              Area:Scarborough
          Address:Work
            City:Toronto
              Area:North York
      '''
      
      result = {
        Person:
          Address: [
            {
              name:"Home"
              City:
                name:"Toronto"
                Area:
                  name:"Scarborough"
            },
            {
              name:"Work"
              City:
                name:"Toronto"
                Area:
                  name:"North York"
            }
          ]
      }
      
      (expect @parser.parse input).toEqual result
  
  
    it 'Fails gracefully when structure is malformed', ->
      input =
      '''
        Person
              Test
            Test
      '''
      
      (expect () => @parser.parse input).toThrow()
