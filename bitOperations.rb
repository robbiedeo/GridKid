class BitOperations
    def initialize(num)
        @num = num
        end
end

class NotBit < BitOperations
  def evaluate(env)
    numToNot = @num.evaluate(env)
    if(numToNot.is_a?(IntegerV))
      intPrim = IntegerV.new(~numToNot.getI)
      return intPrim
    else
      raise Exception.new "These types are not compatible!"
    end
  end
  end

class AndBit < BitOperations
  def initialize(leftExpression,rightExpression)
    @leftExpression = leftExpression
    @rightExpression = rightExpression
  end

  def evaluate(env)
    lv = @leftExpression.evaluate(env)
    rv = @rightExpression.evaluate(env)
    if ((lv.is_a? (IntegerV) and rv.is_a? (IntegerV)))
      intPrim = IntegerV.new(lv.getI & rv.getI)
      return intPrim
    else
      raise Exception.new "These types are not compatible!"
  end
  end
end

class OrBit < BitOperations
  def initialize(leftExpression,rightExpression)
    @leftExpression = leftExpression
    @rightExpression = rightExpression
  end
  def evaluate(env)
    lv = @leftExpression.evaluate(env)
    rv = @rightExpression.evaluate(env)
      if(lv.is_a? (IntegerV) and rv.is_a? (IntegerV))
        intPrim = IntegerV.new(lv.getI | rv.getI)
        return intPrim
      else
        raise Exception.new "These types are not compatible!"
      end
  end
end
class XorBit < BitOperations
  def initialize(leftExpression,rightExpression)
    @leftExpression = leftExpression
    @rightExpression = rightExpression
  end
  def evaluate(env)
    lv = @leftExpression.evaluate(env)
    rv = @rightExpression.evaluate(env)
      if(lv.is_a? (IntegerV) and rv.is_a? (IntegerV))
        intPrim = IntegerV.new(lv.getI ^ rv.getI)
        return intPrim
      else
        raise Exception.new "These types are not compatible!"
      end
  end
end

class Leftshift < BitOperations
  def initialize(leftExpression,rightExpression)
    @leftExpression = leftExpression
    @rightExpression = rightExpression
  end
  def evaluate(env)
    lv = @leftExpression.evaluate(env)
    rv = @rightExpression.evaluate(env)
      if(lv.is_a? (IntegerV) and rv.is_a? (IntegerV))
        intPrim = IntegerV.new(lv.getI << rv.getI)
        return intPrim
      else
        raise Exception.new "These types are not compatible!"
      end
  end
end

class Rightshift < BitOperations
  def initialize(leftExpression,rightExpression)
    @leftExpression = leftExpression
    @rightExpression = rightExpression
  end
  def evaluate(env)
    lv = @leftExpression.evaluate(env)
    rv = @rightExpression.evaluate(env)
      if(lv.is_a? (IntegerV) and rv.is_a? (IntegerV))
        intPrim = IntegerV.new(lv.getI >> rv.getI)
        return intPrim
      else
        raise Exception.new "These types are not compatible!"
      end
  end
end
