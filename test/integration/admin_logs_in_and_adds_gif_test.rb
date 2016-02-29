require 'test_helper'

class AdminLogsInAndAddsGifTest < ActionDispatch::IntegrationTest
  def test_logged_in_admin_see_gif_index
    admin = User.create(username: "admin",
                        password: "password",
                        role: 1)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit '/login'
    fill_in 'Username', with: admin.username
    fill_in 'Password', with: admin.password
    click_link_or_button "Login"

    visit admin_gifs_path


    assert page.has_content?("All Gifs")
  end

  def test_defaut_user_cannot_see_admin_tools_index
    user = User.create(username: "loser",
                        password: "password",
                        role: 0)

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit admin_gifs_path

    refute page.has_content?("All Gifs")
    assert page.has_content?("The page you were looking for doesn't exist")
  end
end
