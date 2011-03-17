class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.integer :user_id
      t.string :name
      t.string :domain
      t.integer :keywords_count
      t.date :last_run, :default => nil
      t.date :last_successful_run, :default => nil

      t.timestamps
    end
    add_index :projects, :user_id
  end

  def self.down
    remove_index :projects, :user_id
    drop_table :projects
  end
end
