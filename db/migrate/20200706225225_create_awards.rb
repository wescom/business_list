class CreateAwards < ActiveRecord::Migration[6.0]
  def self.up
    create_table :awards do |t|
      t.string :name
      t.string :description
      t.integer :year
      t.string :place
      t.timestamps
    end
  end

  def self.down
    drop_table :awards
  end
end
