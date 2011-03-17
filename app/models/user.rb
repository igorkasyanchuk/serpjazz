class User < ActiveRecord::Base
  attr_accessor :require_password, :code
  
  PLANS = [
    "free",
    "premium free",
    "premium",
    "premium plus"
  ]
  
  # setup authlogic and use bcrypt to store passwords
  acts_as_authentic do |config|
    config.crypto_provider = Authlogic::CryptoProviders::BCrypt
  end

  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :admin
  
  has_many :projects, :dependent => :destroy

  validates_presence_of :email
  validates_presence_of :first_name
  validates_presence_of :last_name
  
  validates_presence_of :password, :if => :require_password?
  validates_presence_of :password_confirmation, :if => :require_password?
  
  scope :admins, where(:admin => true)
  scope :forward,  order('created_at ASC')
  scope :backward, order('created_at DESC')  
  
  def name
    "#{first_name} #{last_name}"
  end
  
  def short_information
    "#{name} - #{email}"
  end
  
  def require_password?
    new_record? || require_password
  end
  
  def is_admin?
    admin
  end
  
  def toggle_admin!
    self.admin = !is_admin?
    self.save
  end
  
  def free?
    self.plan == 'free'
  end
  
  def premium?
    self.plan =~ /premium|^premium free$|premium plus/
  end
  
  def premium_plus?
    self.plan == 'premium plus'
  end

end
