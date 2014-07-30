require 'spec_helper'

describe 'Completing todo items' do
  let!(:todolist){ Todolist.create(title: 'Groceries', description: 'Groceries List') }
  let!(:todo_item){todolist.todo_items.create(content: 'Milk')}

  it 'is sucesfull when marking a single item complete' do
    expect(todo_item.completed_at).to be_nil
    visit_todo_list(todolist)
    within("#todo_item_#{todo_item.id}")do
      click_link 'Mark Completed'
    end
    todo_item.reload
  end

  context 'with completed items' do
    let!(:completed_todo_item){todolist.todo_items.create(content: 'Eggs', completed_at: 5.minutes.ago )}

    it 'shows completed items as complete' do
      visit_todo_list(todolist)
      within("#todo_item_#{todo_item.id}")do
        expect(page).to have_content(completed_todo_item.completed_at)
      end
    end

    it 'does not give the option to mark completed' do
      visit_todo_list(todolist)
      within("#todo_item_#{todo_item.id}")do
        expect(page).to_not have_content('Mark Completed')
      end

    end

  end

end