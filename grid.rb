class Grid
  def initialize()
    @table = {}
  end

  def cell
    @cell
  end

  def value
    @value
  end

  def gridSetter(addr, express)
    @table[addr.to_key] = express
  end

  def gridGetter(addr)
    expression = @table[addr.to_key]
    if (expression.nil?)
      return
    else
      #prim = @table[addr.to_key].evaluate(self)
      prim = @table[addr.to_key]
      return prim
    end
  end
end
