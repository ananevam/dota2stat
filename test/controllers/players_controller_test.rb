require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  test "should get show" do
    @user = User.first
    get :show, account_id: @user.account_id
    assert_response :success
    assert_not_includes @response.body, 'translation missing'
  end

end
