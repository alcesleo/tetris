require "gosu"
require_relative "grid"
require_relative "square"
require_relative "block"
require_relative "matrix"

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
    @grid.draw
  end

  def update
    if Gosu.milliseconds - @time > FALL_INTERVAL
      @time = Gosu.milliseconds
      step
    end
  end

  def step
    if @active_block.landed?
      @active_block.land
      @grid.destroy_completed_rows
      @active_block = Block.random(@grid)
    else
      @active_block.fall
    end
  end

  def button_down(key)
    case key
    when Gosu::KbLeft then @active_block.move_left
    when Gosu::KbRight then @active_block.move_right
    when Gosu::KbDown then @active_block.fall
    when Gosu::KbUp then @active_block.rotate
    when Gosu::KbEscape then close
    end
  end

  def needs_cursor?
    true
  end
end

Tetris.new.show
