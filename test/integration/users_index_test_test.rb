require 'test_helper'

class UsersIndexTestTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should display the link to each user except the logged in user" do
    log_in_as(@user)
    assert_redirected_to user_path(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'img.gravatar', count: User.count-1
    assert_select 'a[href=?]', user_path(@other_user)
  end
end
