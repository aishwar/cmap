_ = require('./helper')._

# Test the Helpers
describe "_", ->
  
  describe "indents", ->
  
    it "computes tab-based indents", ->
      (expect _.indents '\t\tThis is a test').toEqual(2)
    
    it "computes space-based indents", ->
      (expect _.indents '    This is a test').toEqual(4)
    
    it "computes mixed indents", ->
      (expect _.indents ' \t This is a test').toEqual(3)
    
    it "works when there are no indents", ->
      (expect _.indents 'Test').toEqual(0)
    
    it "works when the string is empty", ->
      (expect _.indents '').toEqual(0)
  
  
  describe "trim", ->
    
    it "trims leading and ending whitespaces", ->
      (expect _.trim '\t This is a test\t ').toEqual('This is a test')
    
    it "works when the string is empty", ->
      (expect _.trim '').toEqual('')
    
    it "works when the string is only whitespaces", ->
      (expect _.trim("\t\t  \t ")).toEqual('')
