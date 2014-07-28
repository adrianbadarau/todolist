class TodoItem < ActiveRecord::Base
  belongs_to :todolist
end
