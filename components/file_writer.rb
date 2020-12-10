class FileWriter
  attr_reader :file_path, :file

  def initialize(file_path)
    @file_path = file_path
    @file = File.new(file_path, 'w')
  end

  def write(line)
    file.puts line
  rescue IOError => e
    p e
  end

  def close
    file.close
  end
end
