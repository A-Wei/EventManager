require 'rails_helper'

RSpec.describe "home index page", type: :system do
  it 'renders hello world' do
    visit '/'

    expect(page).to have_text('Welcome to EventManager')
  end
end
