class CreatePostComments < ActiveRecord::Migration[7.2]
  def change
    create_table :post_comments do |t|
      t.references :post, null: false, foreign_key: true
      t.string :comment

      t.timestamps
    end
  end
end
