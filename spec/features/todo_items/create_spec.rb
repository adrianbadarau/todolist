require 'spec_helper'

describe 'Creating todo_items' do
  let!(:todolist){Todolist.create(title: 'Grocery List', description: 'Groceries')}

  it 'is sucesfull with valid content' do
    visit_todo_list(todolist)
    click_link 'New Todo Item'
    fill_in 'Content', with: 'Milk'
    click_button 'Save'

    expect(page).to have_content('Added todo item')
    within 'ul.todo_items' do
      expect(page).to have_content('Milk')
    end
  end

  it 'displays an error when there is no content' do
    visit_todo_list(todolist)
    click_link 'New Todo Item'
    fill_in 'Content', with: ''
    click_button 'Save'

    within('div.flash') do
      expect(page).to have_content('error')
    end

    expect(page.all('ul.todo_items li').size).to eq(0)
  end

end