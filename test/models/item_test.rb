require 'test_helper'
require 'net/http'

class ItemTest < ActiveSupport::TestCase
  test "method picture_url" do
    item = Item.order("RAND()").first
    
    uri = URI.parse(item.picture_url)

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Head.new(uri.request_uri)

    response = http.request(request)
    assert_instance_of Net::HTTPOK, response
  end
end
