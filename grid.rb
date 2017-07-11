class Grid
  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @squares = []
  end

  def land(square)
    @squares << square
  end

  def blocked?(x, y)
    x < 0 || x >= @columns || occupied?(x, y)
  end

  def landed?(x, y)
    y >= @rows - 1 || occupied?(x, y + 1)
  end

  def draw
    @squares.each(&:draw)
  end

  private

  def occupied?(x, y)
    @squares.any? { |square| square.occupies?(x, y) }
  end
end
