require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_includes @response.body, 'Main'
  end

end
