require 'spec_helper'

feature 'Sign in as a user' do
  let!(:user) { FactoryGirl.create(:user, 
                email: "me@example.com", 
                password: "password", 
                password_confirmation: "password") } 

  scenario 'with a valid username and password' do
    visit root_path

    click_link "Sign in"

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Sign in"

    expect(page).to have_content("Signed in successfully")
  end
end

feature 'A user cannot sign in ' do
let!(:user) { FactoryGirl.create(:user, 
                email: "me@example.com", 
                password: "password", 
                password_confirmation: "password") } 

  scenario  'without a valid password' do
    visit root_path

    click_link "Sign in"

    fill_in "Email", with: user.email
    fill_in "Password", with: "somerandomtext"

    click_button "Sign in"

    expect(page).to have_content("Invalid email or password")
  end
end