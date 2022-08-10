Rails.application.routes.draw do

 

  get 'notes/index'
  # get 'users/new'
  # get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  resources :users 
  resources :tickets
  resources :notes
  get "/ticket", to: "tickets#ticket"
  post "/sort", to: "tickets#sort"
  post "/tickets/filter/:option", to: "tickets#tickets_filter"
  post "/tickets/update/:id", to: "tickets#update_array"
  get "/tickets/update/delete/delete_array", to: "tickets#delete_array"
  delete "/delete/bulk", to: "tickets#bulk_delete"
  delete "/tickets/select/bulk/assigned_to", to: "tickets#bulk_delete"
  put "/tickets/select/bulk/:option", to: "tickets#option"
  post "/tickets/update/all/select", to: "tickets#select_all"
  put "/notes/tickets/:id", to: "notes#update_ticket"
  post "/notes/response/:id", to: "notes#add_response"
  put "/notes/tickets/close/:id", to: "notes#close_ticket"
  get "/search", to: "tickets#search", as: :search
  get "/signin", to: "sessions#new", as: :new_sessions
  post "/signin", to: "sessions#create", as: :sessions
  delete "/signout", to: "sessions#destroy", as: :destroy_session 
  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"
  get "password/reset/edit", to: "password_resets#edit", as: :password_reset_edit
  patch "password/reset/edit", to: "password_resets#update"
end
