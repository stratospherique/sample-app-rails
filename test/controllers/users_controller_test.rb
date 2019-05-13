require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end
  test "should get new" do
    get signup_path
    assert_response :success
    assert_select 'title', "Sign up | #{@base_title}"
  end

end
