Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get '/hcaptcha', to: 'hcaptcha#hcaptcha'
  get '/invisible_hcaptcha', to: 'hcaptcha#invisible_hcaptcha'
  post '/verify_demo', to: 'hcaptcha#verify_demo'
end
