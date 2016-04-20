require 'test_helper'

class SignInWorksTest < ActionDispatch::IntegrationTest
  test "login works well" do
    get login_path
    assert_template "new"
    assert_select "#notice", 2
    assert_select "input[type=email]", 1
    assert_select "input[type=password]", 1

    #Log in errantly
    get login_path email: "danel@gmail.com", password_digest: "password"
    assert_redirected_to login_path
    follow_redirect!

    #Make sure that I can see Boards
    assert_select "tbody tr", Boards.count

    #Create a board

    #Make sure that I see one more.

    # Log out

    # Make sure I go to the login page.
  end
end
