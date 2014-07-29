require 'spec_helper'

describe 'Editing todo items' do
  let!(:todolist){ Todolist.create(title: 'Groceries', description: 'Groceries List') }
  let!(:todo_item){todolist.todo_items.create(content: 'Milk')}
  def visit_todo_list(list)
    visit '/todolists'
    within "#todolist_#{list.id}" do
      click_link "List Items"
    end
  end

  it 'is successful with valid content' do
    visit_todo_list(todolist)
    within("#todo_item_#{todo_item.id}")do
      click_link 'Edit'
    end
    fill_in 'Content', with: 'Tomatoes'
    click_button 'Save'

    expect(page).to have_content('Saved todo item')
    todo_item.reload
    expect(todo_item.content).to eq('Tomatoes')
  end


end