class Grid
  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @squares = []
  end

  def land(square)
    @squares << square
  end

  def blocked?(x)
    x < 0 || x >= @columns
  end

  def landed?(x, y)
    y >= @rows -1
  end

  def draw
    @squares.each(&:draw)
  end
end
