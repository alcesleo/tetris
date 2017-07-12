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

  def fall_towards(y)
    move(y: 1) if @y < y
  end

  def move(x: 0, y: 0)
    @x += x
    @y += y
  end

  def place(matrix)
    matrix[@x, @y] = self
  end

  def move_relative_to_matrices(matrix1, matrix2)
    x1, y1 = matrix1.find(self)
    x2, y2 = matrix2.find(self)
    move(x: x2 - x1, y: y2 - y1)
  end

  def blocked?(offset_x, grid)
    grid.blocked?(@x + offset_x, @y)
  end

  def landed?(grid)
    grid.landed?(@x, @y)
  end

  def occupies?(x, y)
    @x == x && @y == y
  end

  def occupies_row?(y)
    @y == y
  end
end
