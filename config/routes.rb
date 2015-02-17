Rails.application.routes.draw do

  root "home#index"

  #Business

  get "business/learn-more" => "business#learn_more"
  post "business-signup" => "business#signup_process"
  post "business/save" => "business#save_business"
  post "business/images" => "business#image_upload"
  get "business-signup" => "business#signup"
  get "business/:id" => "business#business_show"
  get "businesses/find" => "business#search"
  post "review/new" => "business#new_review"

  #Business admin

  get "business-admin" => "business#admin_index"
  get "business-admin/edit/:business_id" => "business#admin_edit"
  post "businesses/edit/:business_id" => "business#update"
  get "business-admin/reviews/:business_id" => "business#admin_reviews"
  get "business-admin/analytics/:business_id" => "business#admin_analytics"
  post "business-admin/analytics/get-views" => "business#get_analytics_views"
  get "business-admin/photos/:business_id" => "business#get_photos"
  post "business-admin/photos/:business_id/delete" => "business#delete_photo"
  post "business-admin/reviews/reply" => "business#admin_save_reply"

  #User

  post "/newuser" => "user#signup_process"
  post "/login" => "user#login_process"
  get "/logout" => "user#logout_process"
  get "/forgot-password" => "user#forgot_password"
  post "/forgot-password/1" => "user#forgot_password_1"
  post "/forgot-password/2" => "user#forgot_password_2"
  post "/forgot-password/3" => "user#forgot_password_3"

  #Event

  get "events" => "event#index"
  get "event/new" => "event#new"
  get "events/:id" => "event#show"
  get "events/:id/edit" => "event#edit"
  post "events/:id/edit" => "event#update"
  post "event/new" => "event#new_event_process"
  post "event/images" => "event#image_upload"
  post "event/images/delete" => "event#image_delete"
  get "event/all" => "event#get_all_events"

  #Blog

  get "blog/new" => "blog#new"
  post "blog/new" => "blog#create"
  post "blog/images" => "blog#image_upload"
  get "blog/me" => "blog#index_personal"
  get "blogs" => "blog#index_public"
  get "post/:id" => "blog#post_show"
  get "post/:id/edit" => "blog#post_edit"
  post "post/:id/edit" => "blog#post_update"
  post "post/images/delete" => "blog#image_delete"
  post "comments/:id" => "blog#save_comment"
  post "followers/add" => "blog#save_follower"
  get "followers" => "blog#my_followers"
  get "followers/:user_id" => "blog#public_followers"
  get "following/:user_id" => "blog#public_following"
  
  #Profile

  get "profile/photos" => "profile#my_photos"
  post "profile/photos/delete" => "profile#delete_photo"
  get "profile" => "profile#notifications"
  get "profile/edit" => "profile#edit"
  post "profile/edit" => "profile#update"
  get "profile/saves" => "profile#saves"
  post "profile/upload" => "profile#upload"
  get "/profile/events" => "profile#get_user_events"

  #Login

  get "login" => "login#index"

  #Omniauth

  get '/auth/:provider/callback', to: 'login#fb_auth'

  #Admin

  get "/admin" => "admin#index"
  post "/admin/delete" => "admin#delete"
  get "/admin/photos/:type" => "admin#photos"
  post "/admin/photos/delete" => "admin#photos_delete"
end
