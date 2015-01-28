class Category < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  has_many :user_categories
  has_many :users, :through => :user_categories
  has_many :quotes
end
