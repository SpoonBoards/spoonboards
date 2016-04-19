require 'test_helper'

class SignInWorksTest < ActionDispatch::IntegrationTest
  test "login works well" do
    get root_path
    assert_redirected_to login_path
    follow_redirect!
    assert_template "new"
    assert_select "#notice", 1
    assert_select "input[type=email]", 1
    assert_select "input[type=password]", 1

    #Log in
    post login_path email: "daniel@gmail.com", password: "password"
    assert_redirected_to boards_path
    follow_redirect!

    #Make sure that I can see Boards
    assert_select "tbody tr", Boards.count

    #Create a board

    #Make sure that I see one more.

    # Log out

    # Make sure I go to the login page.
  end
end
