class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string  :nickname
      t.string  :email
      t.string  :phone
      t.string  :password
      t.integer :status, default: 0
      t.timestamps null: false
    end
  end
end
