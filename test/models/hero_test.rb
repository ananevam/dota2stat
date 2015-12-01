require 'test_helper'
require 'net/http'

class HeroTest < ActiveSupport::TestCase
  test "method kda_by_user" do
    hero = Hero.order("RAND()").first
    assert_instance_of Float, hero.kda_by_user(User.new)
  end

  test "method picture_url" do
    hero = Hero.order("RAND()").first
    uri = URI.parse(hero.picture_url)

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Head.new(uri.request_uri)

    response = http.request(request)
    assert_instance_of Net::HTTPOK, response
  end
end
