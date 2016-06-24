require 'test_helper'

class MusicControllerTest < ActionController::TestCase
  test "should get main" do
    get :main
    assert_response :success
  end

  test "should get songs" do
    get :songs
    assert_response :success
  end

end
