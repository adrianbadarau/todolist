require 'spec_helper'

describe 'Editing todo lists' do
  let!(:todolist){ Todolist.create(title: 'Groceries', description: 'Groceries List') }

  def update_todo_list(options={})
    options[:title] ||= "New Title"
    options[:description] ||= "New Description"
    todolist = options[:todolist]
    visit '/todolists'
    within "#todolist_#{todolist.id}" do
      click_link 'Edit'
    end
    fill_in 'Title', with: options[:title]
    fill_in 'Description', with: options[:description]
    click_button 'Update Todolist'
  end

  it 'updates succesfuly with the correct information' do
    update_todo_list todolist:todolist

    todolist.reload

    expect(page).to have_content('was successfully updated')
    expect(todolist.title).to eq('New Title')
    expect(todolist.description).to eq('New Description')

  end

  it 'diplays an error for no title' do
    update_todo_list title: '',
                     description: 'My todolist description',
                     todolist: todolist

    expect(page).to have_content('error')
  end

  it 'displays an error for short title' do
    update_todo_list title: 'HI',
                     description: 'My todolist description',
                     todolist: todolist

    expect(page).to have_content('error')
  end

  it 'displays an error for no description' do
    update_todo_list title: 'My Title',
                     description: '',
                     todolist: todolist

    expect(page).to have_content('error')
  end

  it 'displays an error for short description' do
    update_todo_list title: 'My Title',
                     description: 'desc',
                     todolist: todolist

    expect(page).to have_content('error')
  end

end