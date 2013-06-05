class Cat < ActiveRecord::Base
  attr_accessible :age, :birthdate, :color, :name, :sex

  validates :age, :birthdate, :color, :name, :sex, :presence => true
  validates :color, :inclusion => { :in => %w(white black brown) }

  has_many :cat_rental_requests, :dependent => :destroy
end
