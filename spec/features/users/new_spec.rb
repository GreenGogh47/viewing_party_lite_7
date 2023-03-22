require "rails_helper"

RSpec.describe "User Registration", type: :feature do
  before(:each) do
    visit register_path
  end

  describe "User Story 5" do
    describe "As a user, when I visit the user registration page(/register)" do
      it "I should see a form to register" do
        expect(page).to have_field("Name")
        expect(page).to have_field("Email")
      end

      xit "will be routed to the new user's dashboard page after submitting" do
        fill_in "Name", with: "Stan Smith"
        fill_in "Email", with: "stan@example.com"

        click_button "Create New User"

        expect(current_path).to eq("/users/#{User.last.id}")
        expect(page).to have_content("User successfully created")
        expect(page).to have_content("Stan's Dashboard")
      end

      it "will only accept unique email addresses" do
        User.create!(name: "Stan Johnson", email: "stan@example.com")
        
        fill_in "Name", with: "Stan Smith"
        fill_in "Email", with: "stan@example.com"

        click_button "Create New User"

        expect(current_path).to eq("/register")
        expect(page).to have_content("Email has already been taken")
      end

      it "sad path for creating a new user" do
        fill_in "Name", with: "Stan Smith"
        fill_in "Email", with: " "

        click_button "Create New User"

        expect(current_path).to eq("/register")
        expect(page).to have_content("Email can't be blank")
      end
    end
  end
end