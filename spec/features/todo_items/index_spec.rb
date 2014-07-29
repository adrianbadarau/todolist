require 'spec_helper'

describe 'Viewing todo_items' do
  let!(:todolist){Todolist.create(title: 'Grocery List', description: 'Groceries')}

  def visit_todo_list(list)
    visit '/todolists'
    within "#todolist_#{list.id}" do
      click_link "List Items"
    end
  end


  it 'displays the title of the todo list' do
    visit_todo_list (todolist)
    within('h1') do
      expect(page).to have_content(todolist[:title])
    end

  end

  it 'displays no items for an empty list' do
    visit_todo_list(todolist)
    expect(page.all('ul.todo_items li').size).to eq(0)
  end

  it 'displays the items when a todo list has content'do
    todolist.todo_items.create(content: 'Milk')
    todolist.todo_items.create(content: 'Eggs')
    visit_todo_list(todolist)

    expect(page.all('ul.todo_items li').size).to eq(2)
    within 'ul.todo_items' do
      expect(page).to have_content('Milk')
      expect(page).to have_content('Milk')
    end
  end

end