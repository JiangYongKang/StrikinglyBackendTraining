class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :send_dept_id
      t.timestamps null: false
    end
    add_foreign_key :users, :depts
  end
end
