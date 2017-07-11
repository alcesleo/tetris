class Block
  SHAPES = [
    [[[0, 0], [0, 1], [1, 0], [1, 1]], Gosu::Color::AQUA]
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
