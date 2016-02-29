require 'test_helper'

class AdminViewAnIndividualGifTest < ActionDispatch::IntegrationTest
  def test_admin_can_view_and_individual_gif
    admin = User.create(username: "admin",
                        password: "password",
                        role: 1)

    Gif.create(image_url: "www.test.com", category: "Test")

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit admin_gifs_path

    click_link_or_button "Test"
    click_link_or_button "Delete"

    refute page.has_content?("Test")

    assert_equal "/admin/gifs", current_path
  end
end
