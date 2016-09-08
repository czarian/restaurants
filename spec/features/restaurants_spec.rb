require 'rails_helper'
describe 'restaurants', js: true do
  let(:restaurant_name){ 'Vegan restaurant' }
  let!(:restaurant){ Restaurant.create(name: restaurant_name) }

  it 'lists restaurant' do
    visit '/'
    expect(page).to have_content(restaurant_name)
  end
end
