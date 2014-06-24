require 'spec_helper'

feature 'users can see other users with specific location and time' do

    scenario 'other user at location at the same time' do
        user = create(:user)
        user2 = create(:user, name: 'jeff')
        login_as(user, :scope => :user)
        activity = create(:activity, user: user)
        activity2 = create(:activity, user: user2)
        visit activity_path(activity)

        expect(page).to have_content("jeff")
      end

      scenario 'users shouldnt be matched with themselves' do
        user = create(:user)
        user2 = create(:user, name: 'jeff')
        login_as(user, :scope => :user)
        activity = create(:activity, user: user)
        activity2 = create(:activity, user: user2)
        visit activity_path(activity)

        expect(page).to_not have_content(user.name)
      end


end