require 'spec_helper'

feature 'users can like other users and match' do

    scenario 'user can like a users page' do
        user = create(:user)
        user2 = create(:user, name: 'jeff')
        login_as(user, :scope => :user)
        activity = create(:activity, user: user)
        activity2 = create(:activity, user: user2)
        visit activity_path(activity)
        expect(user.likes.count).to eq 0
        click_link('jeff')
        click_button('like')
        expect(user.likes.count).to eq 1

    end

end
