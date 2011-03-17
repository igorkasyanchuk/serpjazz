class SearchEngine < ActiveRecord::Base
  has_and_belongs_to_many :projects

  validates_presence_of :name
  validates_presence_of :domain
  validates_uniqueness_of :name
  validates_uniqueness_of :domain
  validates_uniqueness_of :short_name
  validates_presence_of :short_name
end
