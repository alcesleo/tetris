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

  def destroy_completed_rows
    (0...@rows).each do |y|
      row = row(y)

      if row.length == @columns
        destroy(row)
        drop(y)
      end
    end
  end

  def draw
    @squares.each(&:draw)
  end

  private

  def row(y)
    @squares.select { |square| square.occupies_row?(y) }
  end

  def drop(y)
    @squares.each { |square| square.fall_towards(y) }
  end

  def destroy(squares)
    @squares -= squares
  end

  def occupied?(x, y)
    @squares.any? { |square| square.occupies?(x, y) }
  end
end
