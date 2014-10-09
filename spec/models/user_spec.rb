require 'spec_helper'

describe User do
  describe ".create" do
    it "generates its own profile object" do
      expect(User.create(email: "davidkovsky@gmail.com", password: "password22").profile).to be_valid
    end
  end
end
