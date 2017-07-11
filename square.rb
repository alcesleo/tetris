class Square
  def initialize(x, y, color)
    @x = x
    @y = y
    @color = color
  end

  def draw
    stroke = 1
    Gosu.draw_rect(@x * Tetris::SQUARE_SIZE, @y * Tetris::SQUARE_SIZE, Tetris::SQUARE_SIZE, Tetris::SQUARE_SIZE, Gosu::Color::BLACK)
    Gosu.draw_rect(@x * Tetris::SQUARE_SIZE + stroke, @y * Tetris::SQUARE_SIZE + stroke, Tetris::SQUARE_SIZE - 2 * stroke, Tetris::SQUARE_SIZE - 2 * stroke, @color)
  end

  def move(x: 0, y: 0)
    @x += x
    @y += y
  end

  def blocked?(offset_x, grid)
    grid.blocked?(@x + offset_x)
  end

  def landed?(grid)
    grid.landed?(@x, @y)
  end

  def occupies?(x, y)
    @x == x && @y == y
  end
end
