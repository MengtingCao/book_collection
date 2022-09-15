# location: spec/feature/integration_spec.rb
require 'rails_helper'

RSpec.describe 'Creating a book', type: :feature do
  scenario 'valid inputs' do
    visit new_book_path
    fill_in 'Title', with: 'harry potter'
    fill_in 'Author', with: 'j.k. rowling'
    fill_in 'Price', with: '13.49'
    #fill_in 'Published Date', with: 2022-06-26
    select '1997', from: 'book[published_date(1i)]'
    select 'June', from: 'book[published_date(2i)]'
    select '26', from: 'book[published_date(3i)]'
    #page.find('published_date').set('1997-06-26')
    click_on 'Create Book'
    visit books_path
    expect(page).to have_content('harry potter')
    expect(page).to have_content('j.k. rowling')
    expect(page).to have_content('13.49')
    expect(page).to have_content('1997-06-26')
  end
end