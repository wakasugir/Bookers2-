class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.text :text
      t.integer :my_id
      t.integer :your_id

      t.timestamps
    end
  end
end
