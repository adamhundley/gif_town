require 'test_helper'

class AdminMakesAGifTest < ActionDispatch::IntegrationTest
  def test_admin_can_grab_a_gif
    admin = User.create(username: "admin",
                        password: "password",
                        role: 1)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_gifs_path

    click_link_or_button "Find New Gif"
    fill_in "Category", with: "Hello"
    click_link_or_button "Find"
    assert_equal "/admin/gifs", current_path

  end
end
