class Location
  attr_reader :file, :line_no
  protected :file, :line_no

  def initialize(file, line_no)
    @file, @line_no = file, line_no
  end

  def match?(other)
    file == other.file && line_no == other.line_no
  end

  def to_s
    "#{file}:#{line_no}"
  end
end
