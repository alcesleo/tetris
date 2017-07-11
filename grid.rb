class Grid
  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @squares = []
  end

  def add_square(square)
    @squares << square
  end

  def blocked?(x)
    x < 0 || x >= @columns
  end
end