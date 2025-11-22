class CreateAdmins < ActiveRecord::Migration[8.1]
  def change
    create_table :admins, id: :uuid do |t|
      t.timestamps
    end
  end
end
