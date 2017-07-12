class Block
  SHAPES = [
    [[[0, 0], [0, 1], [1, 0], [1, 1]], Gosu::Color::BLUE],
    [[[0, 0], [0, 1], [0, 2], [0, 3]], Gosu::Color::AQUA],
    [[[0, 0], [1, 0], [1, 1], [2, 1]], Gosu::Color::RED],
    [[[0, 1], [1, 1], [1, 0], [2, 0]], Gosu::Color::GREEN],
    [[[0, 0], [1, 0], [1, 1], [1, 2]], Gosu::Color.argb(0xff_ffa500)],
    [[[0, 0], [1, 0], [0, 1], [0, 2]], Gosu::Color::YELLOW],
    [[[1, 0], [0, 1], [1, 1], [2, 1]], Gosu::Color::FUCHSIA]
  ]

  def self.random(grid)
    coordinates, color = SHAPES.sample
    squares = coordinates.map { |x, y| Square.new(x, y, color) }
    new(squares, grid)
  end

  def initialize(squares, grid)
    @squares = squares
    @grid = grid
  end

  def draw
    @squares.each(&:draw)
  end

  def fall
    move(y: 1) unless landed?
  end

  def rotate
    matrix = Matrix.new
    @squares.each { |square| square.place(matrix) }
    matrix.trim
    rotated_matrix = matrix.rotate
    @squares.each { |square| square.move_relative_to_matrices(matrix, rotated_matrix) }
  end

  def land
    @squares.each { |square| @grid.land(square) }
  end

  def landed?
    @squares.any? { |square| square.landed?(@grid) }
  end

  def move_right
    move(x: 1) unless blocked?(1)
  end

  def move_left
    move(x: -1) unless blocked?(-1)
  end

  private

  def move(x: 0, y: 0)
    @squares.each { |square| square.move(x: x, y: y) }
  end

  def blocked?(offset_x)
    @squares.any? { |square| square.blocked?(offset_x, @grid) }
  end
end
