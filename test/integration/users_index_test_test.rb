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
  end

  test "index including pagination" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end

  test "presence of will_paginate links" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination', count: 2
    
  end
end
