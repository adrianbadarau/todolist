require 'spec_helper'

describe 'Creating to do lists' do

  it 'redirects to the todolist indexpage on succes' do
    visit '/todolists'
    click_link 'New Todolist'
    expect(page).to have_content('New todolist')

    fill_in 'Title', with: 'MY todo list'
    fill_in 'Description', with: 'Description of my todo list'
    click_button 'Create Todolist'

    expect(page).to have_content('MY todo list')
  end

  it "display's an error when submiting a blank title field" do
    expect(Todolist.count).to eq(0)
    visit '/todolists'
    click_link 'New Todolist'
    expect(page).to have_content('New todolist')

    fill_in 'Title', with: ''
    fill_in 'Description', with: 'My description'

    click_button 'Create Todolist'
    expect(page).to have_content('error')
    expect(Todolist.count).to eq(0)

    visit '/todolists'
    expect(page).to_not have_content('My description')

  end

  it "display's an error when submiting a <3 chars title field" do
    expect(Todolist.count).to eq(0)
    visit '/todolists'
    click_link 'New Todolist'
    expect(page).to have_content('New todolist')

    fill_in 'Title', with: 'Hi'
    fill_in 'Description', with: 'My description'

    click_button 'Create Todolist'
    expect(page).to have_content('error')
    expect(Todolist.count).to eq(0)

    visit '/todolists'
    expect(page).to_not have_content('Hi')

  end

  it "display's an error when submiting a blank description field" do
    expect(Todolist.count).to eq(0)
    visit '/todolists'
    click_link 'New Todolist'
    expect(page).to have_content('New todolist')

    fill_in 'Title', with: 'My Title'
    fill_in 'Description', with: ''

    click_button 'Create Todolist'
    expect(page).to have_content('error')
    expect(Todolist.count).to eq(0)

    visit '/todolists'
    expect(page).to_not have_content('My Title')

  end

  it "display's an error when submiting a <5 chars description field" do
    expect(Todolist.count).to eq(0)
    visit '/todolists'
    click_link 'New Todolist'
    expect(page).to have_content('New todolist')

    fill_in 'Title', with: 'My Title'
    fill_in 'Description', with: 'descr'

    click_button 'Create Todolist'
    expect(page).to have_content('error')
    expect(Todolist.count).to eq(0)

    visit '/todolists'
    expect(page).to_not have_content('descr')

  end


end