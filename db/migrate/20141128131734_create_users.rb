class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, null: false
      t.string :token, null: false
      t.string :password_digest, null: false
      t.integer :role, null: false, default: 1 #Default to regular user role

      t.timestamps null: false
    end
  end
end
