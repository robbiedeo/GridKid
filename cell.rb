require_relative("environment")
require_relative("grid")

class Cell
  attr_accessor :row, :column

  def initialize(row, column)
    @row = row
    @column = column
  end

  def evaluate(env)
    env.getGrid.gridGetter(self)
  end

  def to_key
    [@row, @column]
  end

  def to_string()
    return "#{@row},#{@column}"
  end
end
