require_relative("grid")
require_relative("cell")

class Environment
  def initialize(grid)
    @grid = grid
    @variables =
      {
        "pi" => FloatV.new(Math::PI),
        "tau" => MultiplicationV.new(FloatV.new(Math::PI), FloatV.new(2.0)),
        "e" => FloatV.new(Math::E),
      }
  end

  def grid
    @grid
  end

  def getGrid
    return @grid
  end

  def setVariable(name, value)
    @variables[name] = value
  end

  def getVariable(name)
    @variables[name]
  end
end
