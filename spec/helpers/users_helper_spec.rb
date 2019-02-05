require 'rails_helper'

RSpec.describe UsersHelper do
  describe '#gravatar_for' do
    it 'returns an `img` tag containing the gravatar for the given users email address' do
      user = build(:user)

      image_tag = gravatar_for(user)

      expect(image_tag).to match(%r{src="https://secure.gravatar.com/avatar/.*"})
    end

    it 'sets the `alt` of the image to the name of the user' do
      user = build(:user, name: 'Bob')

      image_tag = gravatar_for(user)

      expect(image_tag).to match(%r{alt="Bob"})
    end
  end
end
