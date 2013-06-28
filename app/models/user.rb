class User < ActiveRecord::Base
  attr_accessible :email, :password_digest, :password, :password_confirmation
  has_secure_password
  	validates_presence_of :password, :on => :create
  	validates :email, uniqueness: true, presence: true
end
