class CreateKeywordPositions < ActiveRecord::Migration
  def self.up
    create_table :keyword_positions do |t|
      t.integer :keyword_id
      t.float :avg_position, :default => -1
      t.string :positions, :default => ''
      t.integer :max_position, :default => -1
      t.date :running_on, :default => nil
      t.timestamps
    end
    add_index :keyword_positions, :keyword_id
  end

  def self.down
    remove_index :keyword_positions, :keyword_id
    drop_table :keyword_positions
  end
end
