class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :professional, null: false, foreign_key: { on_delete: :cascade }
      t.datetime :start_time, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
  end
end
