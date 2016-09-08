require 'rails_helper'

describe 'restaurant-comments', js: true do
  let(:restaurant_name){ 'Vegan restaurant' }
  let(:restaurant_address){ 'Plac defilad 1' }
  let!(:restaurant){ Restaurant.create(name: restaurant_name, description: 'restaurant description', address:restaurant_address) }

  context 'new comments' do
    before(:each) do
      visit restaurant_path(restaurant)
    end

    it 'shows restaurant description' do
      expect(page).to have_content('restaurant description')
    end

    it 'add comments' do
      within '.row form' do
        fill_in :author, with: 'Czarian'
        fill_in :body, with: 'Delicious'
        find_button('Submit').click()
      end
      sleep 0.1
      expect(Comment.all.size).to eq 1
      expect(page).to have_content 'Delicious'
    end
  end

  context 'replies' do
    let!(:comment){ Comment.create!(author: 'Czarian', body: 'Delicious!', restaurant: restaurant) }

    it 'upvotes' do
      visit restaurant_path(restaurant)
      find_button('+1').click()
      sleep 1
      expect(find('.comment.row .label.secondary.float-right')).to have_text '1'
    end
  end

  context 'polling comments' do
    let!(:comment){ Comment.create!(author: 'Czarian', body: 'Delicious!', restaurant: restaurant) }
    it 'updates via long polling' do
      visit restaurant_path(restaurant)
      Comment.create!(author: 'John doe', body: 'I disagree', restaurant: restaurant, parent: comment)
      sleep 1
      expect(page).to have_content 'I desagree'
      expect(page).to have_content 'John doe'
    end
  end
end
