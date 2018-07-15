Rails.application.routes.draw do

  get 'account/register'
  post 'account/create'
  get 'account/login'
  post 'account/login_attempt'
  get 'account/logout'

  get 'account/home'
  post 'account/logout'

  get 'profiles/new'
  post 'profiles/create'
  get 'profiles/all'

  get 'mails/profile/:id' => 'mails#profile'
  get 'mails/messages/:id' => 'mails#messages'

  root :to => 'account#register'
end
