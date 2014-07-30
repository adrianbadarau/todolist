require 'spec_helper'

describe 'Deleting Todo Items' do
  let!(:todolist){ Todolist.create(title: 'Groceries', description: 'Groceries List') }
  let!(:todo_item){todolist.todo_items.create(content: 'Milk')}

  it 'Succesfuly deletes a todo item' do
    visit_todo_list(todolist)
    within "#todo_item_#{todo_item.id}" do
      click_link 'Destroy'
    end

    expect(page).to_not have_content('Milk')
    expect(TodoItem.count).to eq(0)

  end

end