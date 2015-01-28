class Quote < ActiveRecord::Base
  belongs_to :category
  has_many :user_quotes
  has_many :users, :through => :user_quotes

  validates :message, :presence => true, :uniqueness => true

  def self.send_to_users
    users = User.all.select do |u| 
      u.user_time_zone do
        u.when_notified.include?(Time.zone.now.hour)
      end
    end

    user.each { |u| u.send_quote }
  end

  def to_s
    "#{message} -- #{author}"
  end

end
