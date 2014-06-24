require 'spec_helper'

feature "users can like other users" do
    scenario 'when activity has a user, another user can like' do
        user = create(:user)
        user2 = create(:user, name: 'jeff')
        activity = Activity.create(user: user, arrival_date: Date.today, departure_date: 10.days.from_now, location: "Vancouver, BC")
        activity2 = Activity.create(user: user2, arrival_date: Date.today, departure_date: 10.days.from_now, location: "Vancouver, BC")
        login_as(user, :scope => :user)
        visit activities_path

        click_link "Vancouver, BC"

        expect(page).to have_content(user2.name)
      end
  end