class NotBool
  require_relative('boolean')

  def initialize(b)
  @b = b
  end


  def evaluate(env)
    bToNot = @b.evaluate(env)
    if(bToNot.is_a?(BoolV))
      boolPrim = BoolV.new(!bToNot.getBool)
      return boolPrim
    end
  end
end
