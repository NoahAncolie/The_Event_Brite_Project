class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.references :participant, index: true
      t.references :event, index: true
      t.boolean :reserved
      t.integer :stripe_id

      t.timestamps
    end
  end
end
