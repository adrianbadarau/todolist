module TodolistHelpers
  def visit_todo_list(list)
    visit '/todolists'
    within "#todolist_#{list.id}" do
      click_link "List Items"
    end
  end
end