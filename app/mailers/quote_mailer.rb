class QuoteMailer < ApplicationMailer

  def send_quote(user, quote)
    @quote = quote
    mail(:to => user.email, :subject => "Quotr - Quote of the day! - #{quote.category.name}")
  end

end
