require 'spec_helper'

describe 'Viewing todo_items' do
  let!(:todolist){Todolist.create(title: 'Grocery List', description: 'Groceries')}
  it 'displays no items for an empty list' do
    visit '/todolists'
    within "#todolist_#{todolist.id}" do
      click_link "List Items"
    end
    expect(page).to have_content('TodoItems#index')

  end

end