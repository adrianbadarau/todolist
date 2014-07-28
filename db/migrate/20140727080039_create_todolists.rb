class CreateTodolists < ActiveRecord::Migration
  def change
    create_table :todolists do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
