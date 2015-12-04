require 'test_helper'

class MatchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "generate map" do
    match = Match.order("RAND()").first
    assert_instance_of MiniMagick::Image, match.generate_map
  end
end
