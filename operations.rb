require_relative("cell")
require_relative("grid")
require_relative("environment")

class Operations
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
end

class AdditionV < Operations
  def evaluate(env)
    lv = @leftExpression.evaluate(env)
    rv = @rightExpression.evaluate(env)
    # check the type and add
    if (lv.is_a? (IntegerV) and rv.is_a? (IntegerV))
      intPrim = IntegerV.new(lv.getI + rv.getI)
      return intPrim
    elsif (lv.is_a? (FloatV) and rv.is_a? (FloatV))
      floatPrim = FloatV.new(lv.getF + rv.getF)
      return floatPrim
    else
      raise Exception.new "These types are not compatible!"
    end
  end
end

class SubtractionV < Operations
  def evaluate(env)
    lv = @leftExpression.evaluate(env)
    rv = rightExpression.evaluate(env)
    if (lv.is_a? (IntegerV) and rv.instance_of? (IntegerV))
      intPrim = IntegerV.new(lv.getI - rv.getI)
      return intPrim
    elsif (lv.instance_of? (FloatV) and rv.instance_of? (FloatV))
      floatPrim = FloatV.new(lv.getF - rv.getF)
      return floatPrim
    else
      raise Exception.new "These types are not compatible!"
    end
  end
end

class ExponentiationV < Operations
  def evaluate(env)
    lv = @leftExpression.evaluate(env)
    rv = rightExpression.evaluate(env)
    if (lv.is_a? (IntegerV) and rv.instance_of? (IntegerV))
      numExpo = rv.getI
      e = lv.getI
      intPrim = IntegerV.new(e ** numExpo)
      return intPrim
    else
      raise Exception.new "These types are not compatible!"
    end
  end
end

class ModuloV < Operations
  def evaluate(env)
    lv = @leftExpression.evaluate(env)
    rv = rightExpression.evaluate(env)
    if (lv.is_a? (IntegerV) and rv.instance_of? (IntegerV))
      intPrim = IntegerV.new(lv.getI % rv.getI)
      return intPrim
    elsif (lv.instance_of? (FloatV) and rv.instance_of? (FloatV))
      floatPrim = FloatV.new(lv.getF % rv.getF)
      return floatPrim
    else
      raise Exception.new "These types are not compatible!"
    end
  end
end

class MultiplicationV < Operations
  def evaluate(env)
    lv = @leftExpression.evaluate(env)
    rv = rightExpression.evaluate(env)
    if (lv.is_a? (IntegerV) and rv.instance_of? (IntegerV))
      intPrim = IntegerV.new(lv.getI * rv.getI)
      return intPrim
    elsif (lv.instance_of? (FloatV) and rv.instance_of? (FloatV))
      floatPrim = FloatV.new(lv.getF * rv.getF)
      return floatPrim
    else
      raise Exception.new "These types are not compatible!"
    end
  end
end

class DivisionV < Operations
  def evaluate(env)
    lv = @leftExpression.evaluate(env)
    rv = rightExpression.evaluate(env)
    if (lv.is_a? (IntegerV) and rv.instance_of? (IntegerV))
      intPrim = lv.getI / rv.getI
      return IntegerV.new(intPrim)
    elsif (lv.instance_of? (FloatV) and rv.instance_of? (FloatV))
      floatPrim = lv.getF / rv.getF
      return FloatV.new(floatPrim)
    else
      raise Exception.new "These types are not compatible!"
    end
  end
end

class SumV < Operations
  def evaluate(env)
    # lv = leftExpression.evaluate(env)
    # rv = rightExpression.evaluate(env)
    if (leftExpression.is_a?(Cell) and rightExpression.instance_of? (Cell))
      if (leftExpression.column == rightExpression.column)
        leftSide = leftExpression.row
        rightSide = rightExpression.row
        sum = IntegerV.new(0)
        for i in leftSide..rightSide
          cel = env.getGrid.gridGetter(Cell.new(i, rightExpression.column))
          if cel != nil
            lv = cel.evaluate(env)
          end
          sum = AdditionV.new(lv, sum).evaluate(env)
        end
        return sum.to_string
      end
    else
      return IntegerV.new(77)
    end
  end
end

class MinV < Operations
  def evaluate(env)
    if (leftExpression.is_a?(Cell) and rightExpression.instance_of? (Cell))
      if (leftExpression.column == rightExpression.column)
        leftSide = leftExpression.row
        rightSide = rightExpression.row
        min = env.getGrid.gridGetter(Cell.new(leftSide, rightExpression.column))
        for i in leftSide..rightSide
          cel = env.getGrid.gridGetter(Cell.new(i, rightExpression.column))
          if cel != nil
            lv = cel.evaluate(env)
          end
          if LessThan.new(lv, min).evaluate(env).getBool
            min = lv
          end
        end
        return min.to_string
      end
    else
      return IntegerV.new(77)
    end
  end
end

class MaxV < Operations
  def evaluate(env)
    if (leftExpression.is_a?(Cell) and rightExpression.instance_of? (Cell))
      if (leftExpression.column == rightExpression.column)
        leftSide = leftExpression.row
        rightSide = rightExpression.row
        max = env.getGrid.gridGetter(Cell.new(leftSide, rightExpression.column))
        for i in leftSide..rightSide
          cel = env.getGrid.gridGetter(Cell.new(i, rightExpression.column))
          if cel != nil
            lv = cel.evaluate(env)
          end
          if GreaterThan.new(lv, max).evaluate(env).getBool
            max = lv
          end
        end
        return max.to_string
      end
    else
      return IntegerV.new(77)
    end
  end
end

class MeanV < Operations
  def evaluate(env)
    # lv =
    if (leftExpression.is_a?(Cell) and rightExpression.instance_of? (Cell))
      if (leftExpression.column == rightExpression.column)
        leftSide = leftExpression.row
        rightSide = rightExpression.row
        sum = IntegerV.new(0)
        for i in leftSide..rightSide
          cel = env.getGrid.gridGetter(Cell.new(i, rightExpression.column))
          if cel != nil
            lv = cel.evaluate(env)
          end
          sum = AdditionV.new(lv, sum).evaluate(env)
        end
        divisor = SubtractionV.new(IntegerV.new(rightSide + 1), IntegerV.new(leftSide)).evaluate(env)
        sum = DivisionV.new(sum, divisor).evaluate(env)
        return sum.to_string
      end
    else
      return IntegerV.new(77)
    end
  end
end
