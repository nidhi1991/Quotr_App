class QuotesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @categories = Category.all
    @user_categories = current_user.categories
  end

  def create
    current_user.user_categories.delete_all
    save_categories
    save_when_notified
    save_how_notified
    redirect_to dashboards_path
  end

  def send_quote
    current_user.send_quote
    redirect_to dashboards_path
  end

private

  def save_categories
    categories = params[:category].map { |i| Category.find_by_id(i.to_s) }.compact
    categories.each do |c|
      current_user.user_categories.create!(:category_id => c.id)
    end
  end

  def save_when_notified
    when_notified = params[:when_send].map { |w| User::SEND_TIMES[w] && User::SEND_TIMES[w][:time] }.compact
    current_user.update_attributes!(:when_notified => when_notified)
  end

  def save_how_notified
    current_user.update_attributes!(
      :notify_text => params[:text].present?, :notify_email => params[:email].present?
    )
  end

end
