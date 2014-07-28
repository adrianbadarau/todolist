require 'spec_helper'

describe Todolist do
  it {should have_many(:todo_items)}
end
