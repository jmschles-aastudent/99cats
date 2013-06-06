class User < ActiveRecord::Base
  attr_accessible :password, :username, :session_token

  validates :username, :password, :presence => true
  validates :username, :uniqueness => true

  has_many :cats, :foreign_key => :owner_id
end
