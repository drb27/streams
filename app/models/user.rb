class User < ActiveRecord::Base
  
  validates :name, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :pwd, :presence => true
  validates_length_of :pwd, :in => 3..20, :on => :create

  before_save :encrypt_password
  after_save :clear_password

  def encrypt_password
    if pwd.present?
    end
  end

  def clear_password
    self.pwd = nil
  end

  def self.authenticate(name,pwd)
    user = User.find_by_name name
    if user && user.pwd == pwd
      return user
    else
      return false
    end
  end

  def admin?
    self.isadmin
  end
end
