# location: spec/feature/integration_spec.rb
require 'rails_helper'

RSpec.describe 'Creating a book', type: :feature do
  scenario 'valid inputs' do
    visit new_book_path
    fill_in 'Title', with: 'harry potter'
    fill_in 'Author', with: 'j.k. rowling'
    fill_in 'Price', with: '13.49'
    select '1997', from: 'book[published_date(1i)]'
    select 'June', from: 'book[published_date(2i)]'
    select '26', from: 'book[published_date(3i)]'
    click_on 'Create Book'
    visit books_path
    expect(page).to have_content('harry potter')
    expect(page).to have_content('j.k. rowling')
    expect(page).to have_content('13.49')
    expect(page).to have_content('1997-06-26')
    expect(Book.count).to eq(1)
  end

  scenario 'invalid title input' do
    visit new_book_path
    fill_in 'Author', with: 'j.k. rowling'
    fill_in 'Price', with: '13.49'
    select '1997', from: 'book[published_date(1i)]'
    select 'June', from: 'book[published_date(2i)]'
    select '26', from: 'book[published_date(3i)]'
    click_on 'Create Book'
    expect(page).to have_content('Title can\'t be blank')
    expect(Book.count).to eq(0)
  end

  scenario 'invalid author input' do
    visit new_book_path
    fill_in 'Title', with: 'harry potter'
    fill_in 'Price', with: '13.49'
    select '1997', from: 'book[published_date(1i)]'
    select 'June', from: 'book[published_date(2i)]'
    select '26', from: 'book[published_date(3i)]'
    click_on 'Create Book'
    expect(page).to have_content('Author can\'t be blank')
    expect(Book.count).to eq(0)
  end

  scenario 'invalid price input' do
    visit new_book_path
    fill_in 'Title', with: 'harry potter'
    fill_in 'Author', with: 'j.k. rowling'
    select '1997', from: 'book[published_date(1i)]'
    select 'June', from: 'book[published_date(2i)]'
    select '26', from: 'book[published_date(3i)]'
    click_on 'Create Book'
    expect(page).to have_content('Price can\'t be blank')
    expect(Book.count).to eq(0)
  end
end

RSpec.describe 'Editing a book', type: :feature do
  let!(:book) { Book.create(title: 'harry potter', author: 'j.k. rowling', price: '13.49', published_date: '1997-06-26') }

  scenario 'valid updates' do
    visit books_path
    click_on 'Edit'
    fill_in 'Title', with: 'frankenstein'
    fill_in 'Author', with: 'mary wollstonecraft shelley'
    fill_in 'Price', with: '5.99'
    select '1818', from: 'book[published_date(1i)]'
    select 'January', from: 'book[published_date(2i)]'
    select '1', from: 'book[published_date(3i)]'
    click_on 'Update Book'
    visit books_path
    expect(page).to have_content('frankenstein')
    expect(page).to have_content('mary wollstonecraft shelley')
    expect(page).to have_content('5.99')
    expect(page).to have_content('1818-01-01')
    expect(Book.count).to eq(1)
  end

  scenario 'invalid title updates' do
    visit books_path
    click_on 'Edit'
    fill_in 'Title', with: ''
    click_on 'Update Book'
    expect(page).to have_content('Title can\'t be blank')
    expect(Book.count).to eq(1)
  end

  scenario 'invalid author updates' do
    visit books_path
    click_on 'Edit'
    fill_in 'Author', with: ''
    click_on 'Update Book'
    expect(page).to have_content('Author can\'t be blank')
    expect(Book.count).to eq(1)
  end

  scenario 'invalid price updates' do
    visit books_path
    click_on 'Edit'
    fill_in 'Price', with: ''
    click_on 'Update Book'
    expect(page).to have_content('Price can\'t be blank')
    expect(Book.count).to eq(1)
  end
end

RSpec.describe 'Deleting a book', type: :feature do
  let!(:book) { Book.create(title: 'harry potter', author: 'j.k. rowling', price: '13.49', published_date: '1997-06-26') }

  scenario 'valid delete' do
    visit books_path
    click_on 'Delete'
    click_on 'Delete Book'
    expect(page).to have_content('Book was successfully destroyed.')
    expect(Book.count).to eq(0)
  end
end
