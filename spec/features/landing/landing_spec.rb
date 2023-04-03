require "rails_helper"

RSpec.describe "Landing", type: :feature do
  before(:each) do
    @user_1 = create(:user, password: "test123", password_confirmation: "test123")
    @user_2 = create(:user, password: "test123", password_confirmation: "test123")
    @user_3 = create(:user, password: "test123", password_confirmation: "test123")

    visit root_path
  end

  describe "User Story 4" do
    it "shows the landing page with the name of the app and a button to create a new user" do
      expect(page).to have_content("Viewing Party")
      expect(page).to have_button("Create New User")

      click_button "Create New User"
      expect(current_path).to eq(register_path)
    end

    it "shows the existing users as a link to their dashboard" do
      within("#user_#{@user_1.id}") do
        expect(page).to have_link("#{@user_1.name} - #{@user_1.email}", href: user_path(@user_1.id))
      end
      within("#user_#{@user_2.id}") do
        expect(page).to have_link("#{@user_2.name} - #{@user_2.email}", href: user_path(@user_2.id))
      end
      within("#user_#{@user_3.id}") do
        expect(page).to have_link("#{@user_3.name} - #{@user_3.email}", href: user_path(@user_3.id))
      end
    end

    it "has a link to the landing page" do
      expect(page).to have_link("Home", href: root_path)
    end
  end

  describe "User Story 3 - Authentication" do
    it "has a login link that takes me to the login page" do
      
      expect(page).to have_link("Log In")
      click_link "Log In"
      
      expect(current_path).to eq(login_path)

      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password
      click_button "Log In"

      expect(current_path).to eq(user_path(@user_1.id))
    end
  end
end
