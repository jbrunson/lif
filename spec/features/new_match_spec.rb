require 'spec_helper'

feature 'users match with other users where there is a mutual like' do

    scenario 'user can see match' do
        user = create(:user)
        user2 = create(:user, name: 'jeff')
        user3 = create(:user, name: 'sally')
        login_as(user, :scope => :user)
        activity = create(:activity, user: user)
        activity2 = create(:activity, user: user2)
        activity3 = create(:activity, user: user3)
        like = user.matches.create(matched_user: user2)
        like2 = user2.matches.create(matched_user: user)
        like3 = user3.matches.create(matched_user: user)
        like4 = user.matches.create(matched_user: user3)
        # like = create(:like, user: user, liked_user: user2)
        # like = create(:like, user: user2, liked_user: user)

        visit user_matches_path(user)

        expect(page).to have_content("jeff")
        expect(page).to have_content("sally")
    end


   scenario 'user can see match' do
        user = create(:user, name: "henry")
        user2 = create(:user, name: 'jeff')
        login_as(user2, :scope => :user)
        activity = create(:activity, user: user)
        activity2 = create(:activity, user: user2)
        like = user.matches.create(matched_user: user2)
        like2 = user2.matches.create(matched_user: user)
        # like = create(:like, user: user, liked_user: user2)
        # like = create(:like, user: user2, liked_user: user)

        visit user_matches_path(user2)

        expect(page).to have_content("henry")
    end




  end