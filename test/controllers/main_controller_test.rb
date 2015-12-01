require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, locale: :en
    assert_response :success
    assert_includes @response.body, 'Latest Matches'
    assert_not_includes @response.body, 'translation missing'

  end

end
