class Test
    require_relative('integer')
    require_relative('float')
    require_relative('boolean')
    require_relative('not')
    require_relative('environment')
    require_relative('grid')
    require_relative('and')
    require_relative('or')
    require_relative('floatToInt')
    require_relative('intToFloat')
    require_relative('relations')
    require_relative('bitOperations')
    require_relative('cell')
    require_relative('operations')
end
g = Grid.new
e = Environment.new(g)
# *********** Test the Operations ****************
# #test the floats
l = FloatV.new(1.1)
r = FloatV.new(4.1)
s = AdditionV.new(l,r)
sr = AdditionV.new(s,l)
puts sr.evaluate(e).to_string
puts "5.2 is expected"
puts s.evaluate(e).to_string
# #test the integers
l = IntegerV.new(5)
r = IntegerV.new(5)
s = AdditionV.new(l,r)
sr = AdditionV.new(s,s)
srt = AdditionV.new(sr,sr)
puts srt.evaluate(e).to_string

# #test the exponentiation
l = IntegerV.new(3)
r = IntegerV.new(3)
s = ExponentiationV.new(l,r)
sr = ExponentiationV.new(s,IntegerV.new(2))
puts "27 is expected: "
puts s.evaluate(e).to_string
puts sr.evaluate(e).to_string


#test the division
l = IntegerV.new(6)
r = IntegerV.new(2)
s = DivisionV.new(l,r)
puts s.evaluate(e).to_string
l = IntegerV.new(6.6)
r = IntegerV.new(1.2)
s = DivisionV.new(l,r)
puts s.evaluate(e).to_string

# test the multiplication
l = IntegerV.new(6)
r = IntegerV.new(2)
s = MultiplicationV.new(l,r)
puts s.evaluate(e).to_string
l = IntegerV.new(6.6)
r = IntegerV.new(1.2)
s = MultiplicationV.new(l,r)
puts s.evaluate(e).to_string

# test the subtraction
l = IntegerV.new(6)
r = IntegerV.new(2)
s = SubtractionV.new(l,r)
puts s.evaluate(e).to_string
l = FloatV.new(6.6)
r = FloatV.new(1.2)
s = SubtractionV.new(l,r)
puts s.evaluate(e).to_string

# #test modulo
l = IntegerV.new(77)
r = IntegerV.new(10)
s = ModuloV.new(l,r)
sr = ModuloV.new(s,IntegerV.new(4))
puts s.evaluate(e).to_string
puts sr.evaluate(e).to_string

# # tests when you add a subtraction to the problem
l = IntegerV.new(6)
r = IntegerV.new(1)
s = SubtractionV.new(l,r)
n = IntegerV.new(5)
no = NotBit.new(s)
puts no.evaluate(e).to_string

# #test and
# #boolean
l = BoolV.new(true)
r = BoolV.new(true)
s = AndLogic.new(l,r)
sr = AndLogic.new(s,BoolV.new(false))
puts s.evaluate(e).to_string
puts sr.evaluate(e).to_string

# # testnot
l = BoolV.new(true)
s = NotBool.new(l)
puts s.evaluate(e).to_string

# #test or
l = BoolV.new(true)
r = BoolV.new(false)
s = OrLogic.new(l,r)
sr = OrLogic.new(s,BoolV.new(false))
puts s.evaluate(e).to_string
puts sr.evaluate(e).to_string

# #float to int
f = 2.2
s = Float_to_Int.new(f)
puts s.evaluate(e).to_string

# #int to float
i = 17/4.0
s = Int_to_Float.new(i)
puts s.evaluate(e).to_string

# #equals
l = IntegerV.new(5)
r = IntegerV.new(5)
s = Equals.new(l,r)
puts s.evaluate(e).to_string
l = BoolV.new(true)
r = BoolV.new(false)
s = Equals.new(l,r)
puts s.evaluate(e).to_string

# #Notequals
l = IntegerV.new(5)
r = IntegerV.new(6)
s = NotEquals.new(l,r)
puts s.evaluate(e).to_string
l = BoolV.new(true)
r = BoolV.new(true)
s = NotEquals.new(l,r)
puts s.evaluate(e).to_string

# #less than
l = IntegerV.new(5)
r = IntegerV.new(6)
s = LessThan.new(l,r)
puts s.evaluate(e).to_string
l = FloatV.new(53.2)
r = FloatV.new(52.2)
s = LessThan.new(l,r)
puts s.evaluate(e).to_string

# #less than or equal to
l = IntegerV.new(6)
r = IntegerV.new(6)
s = LessThanOrEqualTo.new(l,r)
puts s.evaluate(e).to_string
l = FloatV.new(53.2)
r = FloatV.new(53.2)
s = LessThanOrEqualTo.new(l,r)
puts s.evaluate(e).to_string

# #greater than
l = IntegerV.new(7)
r = IntegerV.new(6)
s = GreaterThan.new(l,r)
puts s.evaluate(e).to_string
l = FloatV.new(54.2)
r = FloatV.new(53.2)
s = GreaterThan.new(l,r)
puts s.evaluate(e).to_string

# #greater than or equal to
l = IntegerV.new(7)
r = IntegerV.new(7)
s = GreaterThanOrEqualTo.new(l,r)
puts s.evaluate(e).to_string
l = FloatV.new(51.2)
r = FloatV.new(53.2)
s = GreaterThanOrEqualTo.new(l,r)
puts s.evaluate(e).to_string

# # **************** Test Bit Operations ***********************
# #test not
n = IntegerV.new(5)
no = NotBit.new(n)
puts no.evaluate(e).to_string

# #test and
l = IntegerV.new(5)
r = IntegerV.new(4)
s = AndBit.new(l,r)
puts s.evaluate(e).to_string

# #test or
l = IntegerV.new(12)
r = IntegerV.new(5)
s = OrBit.new(l,r)
puts s.evaluate(e).to_string

# #test xor
l = IntegerV.new(12)
r = IntegerV.new(5)
s = XorBit.new(l,r)
puts s.evaluate(e).to_string

# #test leftShift
l = IntegerV.new(12)
r = IntegerV.new(2)
s = Leftshift.new(l,r)
puts s.evaluate(e).to_string

# #test leftShift
l = IntegerV.new(12)
r = IntegerV.new(2)
s = Rightshift.new(l,r)
puts s.evaluate(e).to_string

# #***************** Test the cell *****************************
c = Cell.new(1,2)
c1 = Cell.new(1,3)
c2 = Cell.new(1,4)
puts c.to_string
g = Grid.new
g.gridSetter(c,IntegerV.new(4))
puts g.gridGetter(c).to_string
g.gridSetter(c, AdditionV.new(IntegerV.new(4),IntegerV.new(5)))
puts g.gridGetter(c).to_string
g.gridSetter(c, AdditionV.new(AdditionV.new(IntegerV.new(4),IntegerV.new(5)),AdditionV.new(IntegerV.new(4),IntegerV.new(5))))
puts g.gridGetter(c).to_string
g.gridSetter(c1,IntegerV.new(5))
g.gridSetter(c2,IntegerV.new(6))
puts g.gridGetter(c1).to_string
puts g.gridGetter(c2).to_string
l = IntegerV.new(2)
r = IntegerV.new(3)
s = ExponentiationV.new(l,r)
puts s.evaluate(e).to_string
s = LessThan.new(l,r)
puts s.evaluate(e).to_string

# # # ****************** These tests throw exceptions ***************
# # this chunk of code throws an exception
# l = FloatV.new(51.2)
# r = IntegerV.new(53)
# s = GreaterThanOrEqualTo.new(l,r)
# puts s.evaluate(e).to_string
# g.gridGetter(Cell.new(1,3)).to_string
