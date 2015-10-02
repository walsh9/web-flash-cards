class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.text :front, null: false
      t.text :back, null: false
      t.integer :deck_id, null: false

      t.timestamps :null => false
    end
  end
end
