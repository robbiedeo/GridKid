class AndLogic
  require_relative("integer")
  require_relative("float")
  require_relative("boolean")

  def initialize(leftExpression, rightExpression)
    @leftExpression = leftExpression
    @rightExpression = rightExpression
  end

  def leftExpression
    @leftExpression
  end

  def rightExpression
    @rightExpression
  end

  def evaluate(env)
    lv = leftExpression.evaluate(env)
    rv = rightExpression.evaluate(env)
    if (lv.is_a? (BoolV) and rv.is_a? (BoolV))
      boolPrim = BoolV.new(lv.getBool & rv.getBool)
      return boolPrim
    else
      raise Exception.new "These types are not compatible!"
    end
  end
end
