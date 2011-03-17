class KeywordReport < ActiveRecord::Base
  belongs_to :keyword
  validates_presence_of :domain
end
