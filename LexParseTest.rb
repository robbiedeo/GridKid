class LexParseTest
  require_relative("integer")
  require_relative("float")
  require_relative("boolean")
  require_relative("not")
  require_relative("environment")
  require_relative("grid")
  require_relative("and")
  require_relative("or")
  require_relative("floatToInt")
  require_relative("intToFloat")
  require_relative("relations")
  require_relative("bitOperations")
  require_relative("cell")
  require_relative("operations")
  require_relative("Parser")
end

lexer = Lexer.new
# puts "                  LEXER                     "
# puts "--------------------------------------------"
# tokens = lexer.lex("+-***!||%^()[31,2] 7 7.7")
# puts tokens
# tokens = lexer.lex("7")
# puts tokens
# tokens = lexer.lex("5>>2")
# puts tokens
# tokens = lexer.lex("[3,2]")
# puts tokens
# tokens = lexer.lex("pi tau e")
# puts tokens
# puts "--------------------------------------------"
# puts "                  PARSER                     "
# puts "--------------------------------------------"
# parser = Parser.new(lexer.lex("(2**3 + 7) * 4 / 5"))
# expr = parser.parse
# puts expr.evaluate(nil).to_string
# puts expr

# parser = Parser.new(lexer.lex("3 * 2 + 5 * 3"))
# expr = parser.parse
# puts expr.evaluate(nil).to_string

# parser = Parser.new(lexer.lex("(6 / 2) + 5 * 3"))
# expr = parser.parse
# puts expr.evaluate(nil).to_string

# parser = Parser.new(lexer.lex("!5"))
# expr = parser.parse
# puts expr

# parser = Parser.new(lexer.lex("4^5"))
# expr = parser.parse
# puts expr.evaluate(nil).to_string

# parser = Parser.new(lexer.lex("true || false"))
# expr = parser.parse
# puts expr.evaluate(nil).to_string

# parser = Parser.new(lexer.lex("5 < 3"))
# expr = parser.parse
# puts expr.evaluate(nil).to_string

# parser = Parser.new(lexer.lex("5 >= 3"))
# expr = parser.parse
# puts expr

# parser = Parser.new(lexer.lex("5 | 3"))
# expr = parser.parse
# puts expr

# parser = Parser.new(lexer.lex("(5+4 * (10 % (5+2)))"))
# expr = parser.parse
# puts expr.evaluate(nil).to_string

# parser = Parser.new(lexer.lex("(5<<4 * (10 % (5+2)))"))
# expr = parser.parse
# puts expr.evaluate(nil).to_string

g = Grid.new
env = Environment.new(g)
c = Cell.new(1, 2)
c1 = Cell.new(2, 2)
c2 = Cell.new(3, 2)
c3 = Cell.new(4, 2)
c4 = Cell.new(5, 2)
# parser = Parser.new(lexer.lex("tau * pi"))
# tokens = lexer.lex("pi * 3.0")
# puts tokens
# expr = parser.parse
# puts expr.evaluate(env).to_string
# parser = Parser.new(lexer.lex("pi * e"))
# expr = parser.parse
# puts expr.evaluate(nil).to_string
# parser = Parser.new(lexer.lex("pi * tau"))
# expr = parser.parse
# puts expr.evaluate(nil).to_string
# parser = Parser.new(lexer.lex("pi * 0.5"))
# expr = parser.parse
# puts expr.evaluate(nil).to_string
# tokens = lexer.lex("sum max min mean")
# puts tokens
g.gridSetter(c, IntegerV.new(2))
g.gridSetter(c1, IntegerV.new(8))
g.gridSetter(c2, IntegerV.new(999))
g.gridSetter(c3, IntegerV.new(10))
g.gridSetter(c4, IntegerV.new(11))
expr = SumV.new(c, c4)
env = Environment.new(g)
puts expr.evaluate(env)
expr = MinV.new(c, c4)
puts expr.evaluate(env)
expr = MaxV.new(c, c4)
puts expr.evaluate(env)
expr = MeanV.new(c, c4)
puts expr.evaluate(env)
tokens = lexer.lex("sum [1,2] [5,2]")
puts tokens
puts "SUM"
parser = Parser.new(lexer.lex("sum [1,2] [5,2]"))
expr = parser.parse
puts expr.evaluate(env)
puts "MEAN"
parser = Parser.new(lexer.lex("mean [1,2] [5,2]"))
expr = parser.parse
puts expr.evaluate(env)
puts "MIN"
parser = Parser.new(lexer.lex("min [1,2] [5,2]"))
expr = parser.parse
puts expr.evaluate(env)
puts "MAX"
parser = Parser.new(lexer.lex("max [1,2] [5,2]"))
expr = parser.parse
puts expr.evaluate(env)
#puts expr.evaluate(env).to_string
# g.gridSetter(c, AdditionV.new(IntegerV.new(4), IntegerV.new(5)))
# puts g.gridGetter(c).to_string
# parser = Parser.new(lexer.lex("((5+5) + 5)"))
# expr = parser.parse
# puts expr.evaluate(g).to_string
# puts "--------------------------------------------"
# parser = Parser.new(lexer.lex("2+2"))
# expr = parser.parse
# puts expr.evaluate(nil).to_string
