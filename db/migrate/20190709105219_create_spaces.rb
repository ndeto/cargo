class CreateSpaces < ActiveRecord::Migration[5.0]
  def change
    create_table :spaces do |t|
      t.string :departure
      t.string :destination
      t.datetime :departure_time
      t.datetime :arrival_time
      t.references :airline, foreign_key: true

      t.timestamps
    end
  end
end
