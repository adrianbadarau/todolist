require 'spec_helper'

describe 'Creating to do lists' do
  def create_todo_list(options={})
    options[:title] ||= "MY todo list"
    options[:description] ||= "Description of my todo list"

    visit '/todolists'
    click_link 'New Todolist'
    expect(page).to have_content('New todolist')

    fill_in 'Title', with: options[:title]
    fill_in 'Description', with: options[:description]
    click_button 'Create Todolist'
  end

  it 'redirects to the todolist indexpage on succes' do
    create_todo_list
    expect(page).to have_content('MY todo list')
  end

  it "display's an error when submiting a blank title field" do
    expect(Todolist.count).to eq(0)

    create_todo_list title: ""

    expect(page).to have_content('error')
    expect(Todolist.count).to eq(0)

    visit '/todolists'
    expect(page).to_not have_content('Description of my todo list')

  end

  it "display's an error when submiting a <3 chars title field" do
    expect(Todolist.count).to eq(0)

    create_todo_list title: 'Hi'

    expect(page).to have_content('error')
    expect(Todolist.count).to eq(0)

    visit '/todolists'
    expect(page).to_not have_content('Hi')

  end

  it "display's an error when submiting a blank description field" do
    expect(Todolist.count).to eq(0)

    create_todo_list description: ''

    expect(page).to have_content('error')
    expect(Todolist.count).to eq(0)

    visit '/todolists'
    expect(page).to_not have_content('My Title')

  end

  it "display's an error when submiting a <5 chars description field" do
    expect(Todolist.count).to eq(0)

    create_todo_list description: 'descr'

    expect(page).to have_content('error')
    expect(Todolist.count).to eq(0)

    visit '/todolists'
    expect(page).to_not have_content('descr')

  end


end