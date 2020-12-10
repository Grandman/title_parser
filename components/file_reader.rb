class FileReader
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def read
    lines = File.readlines(file_path)
    normalize(lines)
  end

  private

  def normalize(lines)
    lines.map(&:chomp)
  end
end
