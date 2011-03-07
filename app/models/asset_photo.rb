class AssetPhoto < ActiveRecord::Base

  has_attached_file :photo, :styles => { :thumb => "100x100>" }
  
  scope :recent, order('created_at desc')
  
  validates_attachment_presence :photo
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
    
  def url
    "http://snap.com.ua" + self.photo.url(:original)
  end
  
end
