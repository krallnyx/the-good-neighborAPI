class CreateRequest < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.belongs_to :user, index: true
      t.string :title
      t.text :description
      t.string :category
      t.string :status, default: 'unfulfilled'
      t.integer :start_count, default: 0
      t.integer :active, default: 1
      t.datetime :start_date
      t.string :location
      t.decimal :longitude
      t.decimal :latitude

      t.timestamps
    end
  end
end
