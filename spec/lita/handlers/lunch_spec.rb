require 'spec_helper'

describe Lita::Handlers::Lunch, lita_handler: true do
  before do
    subject.reset!
  end

  describe 'suggesting a place' do
    it { is_expected.to route_command('lunch suggestion').to(:suggest) }
    it { is_expected.to route_command('lunch suggest').to(:suggest) }
    it { is_expected.to route('where should I go for lunch?').to(:suggest) }
    it { is_expected.to route('where should we go for lunch?').to(:suggest) }
    it { is_expected.to route('where should they go for lunch?').to(:suggest) }

    it 'suggest when no places have been added' do
      send_command('lunch suggest')
      expect(replies.last).to eq 'How about that place you like?'
    end

    it 'will use an added place' do
      send_command('lunch place add yolo')
      send_command('lunch suggest')
      expect(replies.last).to eq 'How about yolo?'
    end

    it 'will not use a removed place' do
      send_command('lunch place add yolo')
      send_command('lunch place remove yolo')
      send_command('lunch suggest')
      expect(replies.last).to eq 'How about that place you like?'
    end
  end

  describe 'list all places' do
    it { is_expected.to route_command('lunch places').to(:list_suggestions) }
    it { is_expected.to route_command('lunch place').to(:list_suggestions) }

    it 'tells you if there are no places' do
      send_command('lunch places')
      expect(replies.last).to eq 'None added yet'
    end

    it 'lists all the known places' do
      send_command('lunch place add foo')
      send_command('lunch place add bar')
      send_command('lunch places')
      expect(replies.last).to eq "foo\nbar"
    end
  end

  describe 'adding a place' do
    it { is_expected.to route_command('lunch place add PLACE').to(:add_suggestion) }
    it { is_expected.to route_command('lunch places add PLACE').to(:add_suggestion) }

    it 'will confirm place added' do
      send_command('lunch place add blah')
      expect(replies.last).to eq 'blah has been added'
    end
  end

  describe 'removing a place' do
    it { is_expected.to route_command('lunch place remove PLACE').to(:remove_suggestion) }
    it { is_expected.to route_command('lunch place delete PLACE').to(:remove_suggestion) }
    it { is_expected.to route_command('lunch places remove PLACE').to(:remove_suggestion) }
    it { is_expected.to route_command('lunch places delete PLACE').to(:remove_suggestion) }

    it 'will confirm place removed' do
      send_command('lunch place add blah')
      send_command('lunch place remove blah')
      expect(replies.last).to eq 'Removed'
    end

    it 'will confirm if place cannot be found' do
      send_command('lunch place remove yolo')
      expect(replies.last).to eq 'You will need to be more specific'
    end
  end
end
