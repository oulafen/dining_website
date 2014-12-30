class User < ActiveRecord::Base
  has_secure_password
  validates :name, :email, presence: true
  validates :email,:name, uniqueness: true
  attr_accessible :name,:password, :password_confirmation,:status,:email,:active_num
end
