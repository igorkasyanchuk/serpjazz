class CreateKeywordReports < ActiveRecord::Migration
  def self.up
    create_table :keyword_reports do |t|
      t.integer :keyword_id
      t.string :domain
      t.float :avg_position, :default => -1
      t.string :positions, :default => ''
      t.integer :max_position, :default => -1
      t.date :running_on, :default => nil
    end
  end

  def self.down
    drop_table :keyword_reports
  end
end
