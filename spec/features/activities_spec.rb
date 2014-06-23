require 'spec_helper'


feature 'Users can add an activity' do


  scenario 'with an arrival date and location' do
    user = create(:user)
    login_as(user, :scope => :user)
    visit root_path

    click_link "Add trip"

    select "2014", from: "activity[arrival_date(1i)]"
    select "July", from: "activity[arrival_date(2i)]"
    select "23", from: "activity[arrival_date(3i)]"
    fill_in "Location", with: "Vancouver, BC"

    click_button "Create"

    expect(page).to have_content("Trip added")
  end


  scenario 'with an arrival date, departure date and location' do
    user = create(:user)
    login_as(user, :scope => :user)
    visit root_path

    click_link "Add trip"

    select "2014", from: "activity[arrival_date(1i)]"
    select "July", from: "activity[arrival_date(2i)]"
    select "23", from: "activity[arrival_date(3i)]"
    select "2014", from: "activity[departure_date(1i)]"
    select "July", from: "activity[departure_date(2i)]"
    select "30", from: "activity[departure_date(3i)]"
    fill_in "Location", with: "Vancouver, BC"

    click_button "Create"

    expect(page).to have_content("Trip added")
  end


  scenario 'with a departure date and location' do
    user = create(:user)
    login_as(user, :scope => :user)
    visit root_path

    click_link "Add trip"

    select "2014", from: "activity[departure_date(1i)]"
    select "July", from: "activity[departure_date(2i)]"
    select "30", from: "activity[departure_date(3i)]"
    fill_in "Location", with: "Vancouver, BC"

    click_button "Create"

    expect(page).to have_content("Trip added")
  end


end