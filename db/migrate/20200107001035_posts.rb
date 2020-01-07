class Posts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :user_id
      t.string :email
      t.string :content
  end
end
end

