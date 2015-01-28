class User < ActiveRecord::Base
  SEND_TIMES = {
    "Morning" => { :readable => '8 am', :time => 8 },
    "Noon" => { :readable => '12 pm', :time => 12 },
    "Evening" => { :readable => '6 pm', :time => 18 },
    "Night" => { :readable => '10 pm', :time => 22 }
  }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_categories, :dependent => :destroy
  has_many :user_quotes, :dependent => :destroy
  has_many :categories, :through => :user_categories
  has_many :quotes, :through => :user_quotes

  serialize :how_notified, Array
  serialize :when_notified, Array

  def user_time_zone(&block)
    Time.use_zone(self.time_zone, &block)
  end

  def get_quote
    category = self.user_categories.pluck(:category_id).sample
    return nil if category.blank?

    quote = Quote.where(:category_id => category).sample
    return nil if quote.blank?

    quote
  end

  def send_quote
    quote = get_quote
    return if quote.blank?

    self.text(quote.to_s) if self.notify_text
    QuoteMailer.send_quote(self, quote).deliver_now! if self.notify_email
    UserQuote.create!(:quote_id => quote.id, :user_id => self.id)
  end

  def text(msg)
    return if self.phone.blank?
    TWILIO_CLIENT.messages.create(:from => '(650) 492-6713', :to => self.phone, :body => "[Quotr] #{msg}")
  end
end
