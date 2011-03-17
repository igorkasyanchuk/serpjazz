class CreateKeywords < ActiveRecord::Migration
  def self.up
    create_table :keywords do |t|
      t.integer :project_id
      t.string :name
      t.float :avg_position, :default => -1
      t.integer :max_position, :default => -1
      t.timestamps
    end
    add_index :keywords, :project_id
  end

  def self.down
    remove_index :keywords, :project_id
    drop_table :keywords
  end
end
