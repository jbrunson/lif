require 'spec_helper'

describe Activity do
  context 'overlaps with another activity' do
    it 'overlaps with another activity that is at the same time' do
      activity = create(:activity)
      activity2 = create(:activity)
      expect(activity.overlaps?(activity2)).to be_true
    end
  end

  context 'doesnt overlap with another activity' do
      it 'doesnt overlap when activity isnt during another activity' do
        activity = create(:activity)
        activity2 = create(:activity, arrival_date: '2015-01-01', departure_date: '2015-01-02')
        expect(activity.overlaps?(activity2)).to be_false
      end
    end






end
