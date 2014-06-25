require 'spec_helper'

feature 'users can see other users profile page' do

    scenario 'user can see match name on profile page' do
        user = create(:user)
        user2 = create(:user, name: 'jeff')
        login_as(user, :scope => :user)
        activity = create(:activity, user: user)
        activity2 = create(:activity, user: user2)
        visit activity_path(activity)
        click_link("jeff")

        expect(page).to have_content("jeff")
    end
  end