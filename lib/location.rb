class Location
  attr_reader :file, :line_no

  def initialize(file, line_no)
    @file, @line_no = file, line_no
  end

  def match?(other)
    file == other.file && other.match_line?(line_no)
  end

  def match_line?(other_line_no)
    line_no == other_line_no
  end

  def to_s
    "#{file}:#{line_no}"
  end
end

class WildcardLocation
  attr_reader :file
  def initialize(file)
    @file = file
  end

  def match?(other)
    file == other.file
  end

  def match_line?(other_line_no)
    true
  end

  def to_s
    file
  end
end

class RangedLocation
  attr_reader :file, :line_range
  def initialize(file, line_range)
    @file       = file
    @line_range = line_range
  end

  def match?(other)
    file == other.file && line_range.any? { |line_no| other.match_line?(line_no) }
  end

  def match_line?(other_line_no)
    line_range.include?(other_line_no)
  end
end
