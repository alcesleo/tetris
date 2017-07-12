class Grid
  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @squares = []
  end

  def land(square)
    @squares << square
  end

  def destroy(square)
    @squares.delete(square)
  end

  def blocked?(x, y)
    x < 0 || x >= @columns || occupied?(x, y)
  end

  def landed?(x, y)
    y >= @rows - 1 || occupied?(x, y + 1)
  end

  def destroy_completed_rows
    completed_rows.each do |row|
      row.each do |square|
        destroy(square)
      end
    end
  end

  def draw
    @squares.each(&:draw)
  end

  private

  def occupied?(x, y)
    @squares.any? { |square| square.occupies?(x, y) }
  end

  def completed_rows
    squares_in_rows.select { |row| row.length == @columns }
  end

  def squares_in_rows
    (0..@rows).map { |row| @squares.select { |square| square.occupies_row?(row) } }
  end
end
