class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.text :status
      t.text :creator
      t.text :performer
      t.boolean :completed

      t.timestamps
    end
  end
end
