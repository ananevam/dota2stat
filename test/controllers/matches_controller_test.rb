require 'test_helper'

class MatchesControllerTest < ActionController::TestCase
  test "should get show" do
    @user = User.first
    get :show, id: @user.all_matches.first.id
    assert_response :success
  end

end
