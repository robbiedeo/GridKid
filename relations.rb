class Relations
  def initialize(leftExpression, rightExpression)
    @leftExpression = leftExpression
    @rightExpression = rightExpression
  end
end

class Equals < Relations
  def evaluate(env)
    lv = @leftExpression.evaluate(env)
    rv = @rightExpression.evaluate(env)
    if (lv.is_a?(IntegerV) and rv.is_a?(IntegerV))
      boolPrim = BoolV.new(lv.getI == rv.getI)
      return boolPrim
    elsif (lv.is_a?(BoolV) and rv.is_a?(BoolV))
      boolPrim = BoolV.new(lv.getBool == rv.getBool)
      return boolPrim
    else
      raise Exception.new "These types are not compatible!"
    end
  end
end

class NotEquals < Relations
  def evaluate(env)
    lv = @leftExpression.evaluate(env)
    rv = @rightExpression.evaluate(env)
    if (lv.is_a?(IntegerV) and rv.is_a?(IntegerV))
      boolPrim = BoolV.new(lv.getI != rv.getI)
      return boolPrim
    elsif (lv.is_a?(BoolV) and rv.is_a?(BoolV))
      boolPrim = BoolV.new(lv.getBool != rv.getBool)
      return boolPrim
    else
      raise Exception.new "These types are not compatible!"
    end
  end
end

class LessThan < Relations
  def evaluate(env)
    lv = @leftExpression.evaluate(env)
    rv = @rightExpression.evaluate(env)
    if (lv.is_a?(IntegerV) and rv.is_a?(IntegerV))
      boolPrim = BoolV.new(lv.getI < rv.getI)
      return boolPrim
    elsif (lv.is_a?(FloatV) and rv.is_a?(FloatV))
      boolPrim = BoolV.new(lv.getF < rv.getF)
      return boolPrim
    else
      raise Exception.new "These types are not compatible!"
    end
  end
end

class LessThanOrEqualTo < Relations
  def evaluate(env)
    lv = @leftExpression.evaluate(env)
    rv = @rightExpression.evaluate(env)
    if (lv.is_a?(IntegerV) and rv.is_a?(IntegerV))
      boolPrim = BoolV.new(lv.getI <= rv.getI)
      return boolPrim
    elsif (lv.is_a?(FloatV) and rv.is_a?(FloatV))
      boolPrim = BoolV.new(lv.getF <= rv.getF)
      return boolPrim
    else
      raise Exception.new "These types are not compatible!"
    end
  end
end

class GreaterThan < Relations
  def evaluate(env)
    lv = @leftExpression.evaluate(env)
    rv = @rightExpression.evaluate(env)
    if (lv.is_a?(IntegerV) and rv.is_a?(IntegerV))
      boolPrim = BoolV.new(lv.getI > rv.getI)
      return boolPrim
    elsif (lv.is_a?(FloatV) and rv.is_a?(FloatV))
      boolPrim = BoolV.new(lv.getF > rv.getF)
      return boolPrim
    else
      raise Exception.new "These types are not compatible!"
    end
  end
end

class GreaterThanOrEqualTo < Relations
  def evaluate(env)
    lv = @leftExpression.evaluate(env)
    rv = @rightExpression.evaluate(env)
    if (lv.is_a?(IntegerV) and rv.is_a?(IntegerV))
      boolPrim = BoolV.new(lv.getI >= rv.getI)
      return boolPrim
    elsif (lv.is_a?(FloatV) and rv.is_a?(FloatV))
      boolPrim = BoolV.new(lv.getF >= rv.getF)
      return boolPrim
    else
      raise Exception.new "These types are not compatible!"
    end
  end
end
