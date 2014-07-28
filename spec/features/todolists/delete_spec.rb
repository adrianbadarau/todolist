require 'spec_helper'

describe 'Deleting Todo lists' do
  let!(:todolist){ Todolist.create(title: 'Groceries', description: 'Groceries List') }
  it 'Succesfuly deletes a todo list' do
    visit '/todolists'
    within "#todolist_#{todolist.id}" do
      click_link 'Destroy'
    end

    expect(page).to_not have_content('Groceries')


  end

end