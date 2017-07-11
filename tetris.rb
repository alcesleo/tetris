require "gosu"
require_relative "grid"
require_relative "square"
require_relative "block"

class Tetris < Gosu::Window
  COLUMNS = 10
  ROWS = 22
  SQUARE_SIZE = 40
  FALL_INTERVAL = 500

  def initialize
    super(COLUMNS * SQUARE_SIZE, ROWS * SQUARE_SIZE)
    @grid = Grid.new(ROWS, COLUMNS)
    @active_block = Block.random(@grid)
    @time = Gosu.milliseconds
  end

  def draw
    Gosu.draw_rect(0, 0, width, height, Gosu::Color::GRAY)
    @active_block.draw
  end

  def update
    if Gosu.milliseconds - @time > FALL_INTERVAL
      @time = Gosu.milliseconds
      @active_block.fall
    end
  end

  def button_down(key)
    case key
    when Gosu::KbLeft then @active_block.move_left
    when Gosu::KbRight then @active_block.move_right
    when Gosu::KbDown then @active_block.fall
    when Gosu::KbEscape then close
    end
  end

  def needs_cursor?
    true
  end
end

Tetris.new.show
