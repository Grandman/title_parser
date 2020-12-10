require 'nokogiri'
require 'faraday'
require 'ruby-progressbar'

class Parser
  attr_reader :reader, :writer, :client

  def initialize(reader, writer, client)
    @reader = reader
    @writer = writer
    @client = client
  end

  def parse(threads_count)
    lines = reader.read
    progressbar = ProgressBar.create(total: lines.count)

    urls = Queue.new
    lines.each { |e| urls << e }
    urls.close

    threads = threads_count.to_i.times.map do |number|
      Thread.new do
        while url = urls.pop
          progressbar.log "Thread[#{number}]: parsing #{url}"
          begin
            body = client.get_body_from_url(url)
            title = get_title_from_body(body)
          rescue StandardError => e
            progressbar.log "Thread[#{number}]: failed parsing #{url}; Error #{e}"
            next
          end

          writer.write(title) unless title.nil?
          progressbar.increment
        end
      end
    end

    threads.each(&:join)
    writer.close
  end

  private

  def get_title_from_body(body)
    title_xpath = '/html/head/title'
    doc = Nokogiri::HTML(body)
    doc.xpath(title_xpath)&.first&.content
  end
end
