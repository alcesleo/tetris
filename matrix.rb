class Matrix
  def initialize(rows = [])
    @rows = rows
  end

  def [](x, y)
    @rows.fetch(y, [])[x]
  end

  def []=(x, y, value)
    (@rows[y] ||= [])[x] = value
    align
  end

  def rotate
    self.class.new(@rows.transpose.map(&:reverse))
  end

  def find(value)
    @rows.each_with_index do |row, y|
      row.each_with_index do |val, x|
        return [x, y] if val == value
      end
    end
    nil
  end

  def trim
    @rows = @rows.drop_while { |row| row.all?(&:nil?) }
    @rows = @rows.map { |column| column.drop(empty_columns) }
  end

  private

  def align
    @rows.map! { |row| Array(row) }
    @rows.map! { |row| row.concat([nil] * (width - row.length)) }
  end

  def width
    @rows.map(&:length).max
  end

  def empty_columns
    @rows.map { |row| row.find_index { |v| v } }.compact.min
  end
end
