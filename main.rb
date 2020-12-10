require_relative './components/parser.rb'
require_relative './components/client.rb'
require_relative './components/file_reader.rb'
require_relative './components/file_writer.rb'

file_name_with_urls = ARGV[0]
file_name_for_titles = ARGV[1]
threads_count = ARGV[2].to_i
timeout = ARGV[3].to_i

if file_name_with_urls.nil?
  p 'Wrong file name with urls'
  return
end

if file_name_for_titles.nil?
  p 'Wrong file name for saving titles'
  return
end

if threads_count <= 0
  p 'Wrong threads count'
  return
end

if timeout <= 0
  p 'Wrong timeout: must be greater than zero'
  return
end

reader = FileReader.new(file_name_with_urls)
writer = FileWriter.new(file_name_for_titles)
client = Client.new(timeout)

Parser.new(reader, writer, client).parse(threads_count)
