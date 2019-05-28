require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "sign up page" do 
    get signup_path
    assert :success
    assert_no_difference 'User.count' do
      post users_path, params: {user: {name: "",
                                  email:"azesd@okoo",
                                  password: "asdsas",
                                  password_confirmation: "adsas"
      }}
    end 
  end

  test "sign up page again" do 
    get signup_path
    assert :success
    before_adding = User.count
    post users_path, params: {user: {name: "",
                                  email:"azesd@okoo",
                                  password: "asdsas",
                                  password_confirmation: "adsas"
    }}
    after_adding = User.count
    assert_equal before_adding,after_adding

    assert_template 'users/new'
    
  end

  test "invalid signup information" do
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "name can't be blank" do 
    get signup_path
    post users_path, params: {user: {name: "",
      email:"azesd@okoo.com",
      password: "asdsas",
      password_confirmation: "asdsas"
}}
      assert_template 'users/new'
      assert_select "li",{text: "Name can't be blank"}
  end

  test "email can't be blank" do 
    get signup_path
    post users_path, params: {user: {name: "alexxa",
      email:"",
      password: "asdsas",
      password_confirmation: "asdsas"
}}
      assert_template 'users/new'
      assert_select "li",{text: "Email can't be blank"}
  end

  test "email is invalid" do 
    get signup_path
    post users_path, params: {user: {name: "alexxa",
      email:"asda@fgh@",
      password: "asdsas",
      password_confirmation: "asdsas"
}}
      assert_template 'users/new'
      assert_select "li",{text: "Email is invalid"}
  end

  test "password can't be blank" do 
    get signup_path
    post users_path, params: {user: {name: "alexxa",
      email:"asdfsdf@ljkljkl.po",
      password: "",
      password_confirmation: "asdsas"
}}
      assert_template 'users/new'
      assert_select "li",{text: "Password can't be blank"}
  end

  test "password is too short" do 
    get signup_path
    post users_path, params: {user: {name: "alexxa",
      email:"asdfsdf@ljkljkl.po",
      password: "asasa",
      password_confirmation: "asasa"
}}
      assert_template 'users/new'
      assert_select "li",{text: "Password is too short (minimum is 6 characters)"}
  end

  test "passwords don't match" do 
    get signup_path
    post users_path, params: {user: {name: "alexxa",
      email:"asdfsdf@ljkljkl.po",
      password: "asasab",
      password_confirmation: "asasac"
}}
      assert_template 'users/new'
      assert_select "li",{text: "Password confirmation doesn't match Password"}
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
    assert is_logged_in?
  end
end
