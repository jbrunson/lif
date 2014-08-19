require 'spec_helper'


feature 'Users can add an activity' do
    before(:each) do
        @vancouver_geocode_response = '
            {
              "results": [
                {
                  "address_components": [
                    {
                      "long_name": "Vancouver",
                      "short_name": "Vancouver",
                      "types": [
                        "locality",
                        "political"
                      ]
                    },
                    {
                      "long_name": "Greater Vancouver",
                      "short_name": "Greater Vancouver",
                      "types": [
                        "administrative_area_level_2",
                        "political"
                      ]
                    },
                    {
                      "long_name": "British Columbia",
                      "short_name": "BC",
                      "types": [
                        "administrative_area_level_1",
                        "political"
                      ]
                    },
                    {
                      "long_name": "Canada",
                      "short_name": "CA",
                      "types": [
                        "country",
                        "political"
                      ]
                    }
                  ],
                  "formatted_address": "Vancouver, BC, Canada",
                  "geometry": {
                    "bounds": {
                      "northeast": {
                        "lat": 49.31409499999999,
                        "lng": -123.023068
                      },
                      "southwest": {
                        "lat": 49.1998604,
                        "lng": -123.22474
                      }
                    },
                    "location": {
                      "lat": 49.261226,
                      "lng": -123.1139268
                    },
                    "location_type": "APPROXIMATE",
                    "viewport": {
                      "northeast": {
                        "lat": 49.31409499999999,
                        "lng": -123.023068
                      },
                      "southwest": {
                        "lat": 49.1998604,
                        "lng": -123.22474
                      }
                    }
                  },
                  "types": [
                    "locality",
                    "political"
                  ]
                }
              ],
              "status": "OK"
            }
            '
    end

  scenario 'with an arrival date and location' do
    user = create(:user)
    login_as(user, :scope => :user)
    visit activities_path

    click_link "Add activity"

    fill_in "activity[arrival_date]", with: "13-08-2014"
    fill_in "activity[location]", with: "Vancouver, BC"
    
    stub_request(:get, "http://maps.googleapis.com/maps/api/geocode/json?address=Vancouver,%20BC&language=en&sensor=false").
         with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => @vancouver_geocode_response, :headers => {})

    click_button "Create Activity"

    expect(page).to have_content("Trip added")
  end


  scenario 'with an arrival date, departure date and location' do
    user = create(:user)
    login_as(user, :scope => :user)
    visit activities_path

    click_link "Add activity"

    fill_in "activity[arrival_date]", with: "13-08-2014"
    fill_in "activity[departure_date]", with: "18-08-2014"
    fill_in "activity[location]", with: "Vancouver, BC"

    stub_request(:get, "http://maps.googleapis.com/maps/api/geocode/json?address=Vancouver,%20BC&language=en&sensor=false").
         with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => @vancouver_geocode_response, :headers => {})

    click_button "Create Activity"

    expect(page).to have_content("Trip added")
  end


  scenario 'with a departure date and location' do
    user = create(:user)
    login_as(user, :scope => :user)
    visit activities_path

    click_link "Add activity"


    fill_in "activity[departure_date]", with: "18-08-2014"
    fill_in "activity[location]", with: "Vancouver, BC"

    stub_request(:get, "http://maps.googleapis.com/maps/api/geocode/json?address=Vancouver,%20BC&language=en&sensor=false").
         with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => @vancouver_geocode_response, :headers => {})

    click_button "Create Activity"

    expect(page).to have_content("Trip added")
  end


end
