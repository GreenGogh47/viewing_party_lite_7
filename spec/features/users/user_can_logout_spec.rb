require "rails_helper"

RSpec.describe "Landing", type: :feature do
  before(:each) do
    @user_1 = create(:user, password: "test123", password_confirmation: "test123")
    @user_2 = create(:user, password: "test123", password_confirmation: "test123")
    @user_3 = create(:user, password: "test123", password_confirmation: "test123")

    visit root_path
  end

  describe "Authorization and Sessions Challenge" do
    describe "User Story 2 - Log Out a User" do
      it "has a link to log out a user" do
        save_and_open_page
        click_link "Log In"

        fill_in :email, with: @user_1.email
        fill_in :password, with: @user_1.password
        save_and_open_page
        click_button "Log In"

        expect(current_path).to eq(user_path(@user_1.id))
        expect(page).to have_link("Log Out")
        click_link "Log Out"

        expect(current_path).to eq(root_path)
        expect(page).to have_link("Log In")
      end
    end
  end
end