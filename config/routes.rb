Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  resource 'dashboards'
  resources 'quotes' do
    collection do
      get 'send_quote'
    end
  end

  root :to => 'home#index'
end
