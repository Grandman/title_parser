require 'minitest/autorun'

require_relative '../components/parser.rb'
require_relative '../components/file_reader.rb'
require_relative '../components/file_writer.rb'
require_relative './support/fake_client.rb'

class TestParser < Minitest::Test
  def setup
    @path_to_file_with_correct_titles = 'test/fixtures/correct_titles.txt'
    @path_to_save_titles = 'tmp/titles.txt'
    client = FakeClient.new
    reader = FileReader.new('test/fixtures/urls.txt')
    writer = FileWriter.new(@path_to_save_titles)
    @parser = Parser.new(reader, writer, client)
  end

  def test_that_parse_correct_titles
    @parser.parse(10)
    assert_equal(File.readlines(@path_to_save_titles).sort, File.readlines(@path_to_file_with_correct_titles).sort)
  end
end
