class Client
  attr_reader :client

  def initialize(timeout)
    @client = Faraday.new do |conn|
      conn.options.timeout = timeout
    end
  end

  def get_body_from_url(url)
    response = client.get(url)
    response.body
  end
end
