class CreateProfessionals < ActiveRecord::Migration[7.1]
  def change
    create_table :professionals do |t|
      t.string :name, null: false
      t.integer :specialty, null: false

      t.timestamps
    end
  end
end
