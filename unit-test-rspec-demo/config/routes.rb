Rails.application.routes.draw do
  get 'static_page/user', to: 'static_page#user'

  get 'static_page/setting', to: 'static_page#setting'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
