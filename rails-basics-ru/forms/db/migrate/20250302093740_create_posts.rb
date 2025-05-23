class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.text :summary
      t.boolean :published

      t.timestamps
    end
  end
end
