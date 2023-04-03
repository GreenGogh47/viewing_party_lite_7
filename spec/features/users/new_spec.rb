require "rails_helper"

RSpec.describe "User Registration", type: :feature do
  before(:each) do
    visit register_path
  end

  describe "User Story 5" do
    describe "As a user, when I visit the user registration page(/register)" do
      it "I should see a form to register" do
        within "#new_user" do
          expect(page).to have_field("Name")
          expect(page).to have_field("Email")
        end
      end

      it "will be routed to the new user's dashboard page after submitting" do
        within "#new_user" do
          fill_in "Name", with: "Stan Smith"
          fill_in "Email", with: "stan@example.com"
          fill_in "Password", with: "test123"

          click_button "Create New User"
        end

        expect(current_path).to eq("/users/#{User.last.id}")
        expect(page).to have_content("User successfully created")
        expect(page).to have_content("Stan Smith's Dashboard")
      end

      it "will only accept unique email addresses" do
        User.create!(name: "Stan Johnson", email: "stan@example.com", password: "test123", password_confirmation: "test123")

        within "#new_user" do
          fill_in "Name", with: "Stan Smith"
          fill_in "Email", with: "stan@example.com"
          fill_in "Password", with: "test123"

          click_button "Create New User"
        end

        expect(current_path).to eq("/register")
        expect(page).to have_content("Email has already been taken")
      end

      it "sad path for creating a new user" do
        within "#new_user" do
          fill_in "Name", with: "Stan Smith"
          fill_in "Email", with: " "

          click_button "Create New User"
        end

        expect(current_path).to eq("/register")
        expect(page).to have_content("Email can't be blank")
      end
    end
  end

  describe "authentication" do
    it "creates a user with a password" do
      visit root_path

      click_on "Create New User"

      expect(current_path).to eq(register_path)

      username = "funbucket13"
      password = "test"

      fill_in :user_name, with: username
      fill_in :user_password, with: password

      click_on "Create New User"

      expect(User.last[:name]).to eq("Meg")
      expect(User.last[:password]).to_not eq("test")
    end
  end
end
