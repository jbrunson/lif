require 'spec_helper'

feature 'users match with other users where there is a mutual like' do

    scenario 'user can see match' do
        user = create(:user)
        user2 = create(:user, name: 'jeff')
        login_as(user, :scope => :user)
        activity = create(:activity, user: user)
        activity2 = create(:activity, user: user2)
        like = user.likes.create(liked_user: user2)
        like2 = user2.likes.create(liked_user: user)
        # like = create(:like, user: user, liked_user: user2)
        # like = create(:like, user: user2, liked_user: user)

        visit user_matches_path(user)

        expect(page).to have_content("jeff")
    end
  end