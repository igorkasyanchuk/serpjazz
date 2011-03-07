class Asset < ActiveRecord::Base
  has_attached_file :file
  
  scope :recent, order('created_at desc')
  
  validates_attachment_presence :file
    
  def url
    "http://usadvisors.org" + self.photo.url(:original)
  end

end