require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "method kda" do
    player = Player.order("RAND()").first
    assert_instance_of Float, player.kda
  end

  test "method gold_earned" do
    player = Player.order("RAND()").first
    assert_instance_of Fixnum, player.gold_earned
  end

  test "method win" do
    player = Player.order("RAND()").first
    assert (player.win?.is_a?(TrueClass) or player.win?.is_a?(FalseClass))
  end
end
