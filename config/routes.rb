Rails.application.routes.draw do

  root "home#index"

  #Business

  post "business-signup" => "business#signup_process"
  post "business/save" => "business#save_business"

  post "business/images" => "business#image_upload"

  get "business-signup" => "business#signup"
  get "business/:id" => "business#business_show"

  get "businesses/find" => "business#search"
  post "review/new" => "business#new_review"

  #Business admin

  get "business-admin" => "business#admin_index"
  post "businesses/edit" => "business#update"
  get "business-admin/reviews" => "business#admin_reviews"

  #User

  post "/newuser" => "user#signup_process"
  post "/login" => "user#login_process"
  get "/logout" => "user#logout_process"

  #Event

  get "events" => "event#index"
  get "event/new" => "event#new"
  get "events/:id" => "event#show"
  post "event/new" => "event#new_event_process"
  post "event/images" => "event#image_upload"

  #Blog

  get "blog/new" => "blog#new"
  post "blog/new" => "blog#create"
  post "blog/images" => "blog#image_upload"
  get "blog/me" => "blog#index_personal"
  get "blogs" => "blog#index_public"
  get "post/:id" => "blog#post_show"
  post "comments/:id" => "blog#save_comment"
  
  #Profile

  get "profile/photos" => "profile#my_photos"
  post "profile/photos/delete" => "profile#delete_photo"
  get "profile" => "profile#notifications"
  get "profile/edit" => "profile#edit"
  post "profile/edit" => "profile#update"
  get "profile/saves" => "profile#saves"

  #Login

  get "login" => "login#index"

  #Omniauth

  get '/auth/:provider/callback', to: 'login#fb_auth'
end
