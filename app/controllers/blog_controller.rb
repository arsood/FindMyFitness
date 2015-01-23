class BlogController < ApplicationController
	def new
		if session[:user_id]
			@header_text = "Write a Post"
			#Generate random hash to be associated with images
			@post_id = Digest::MD5.hexdigest(Time.now.to_s)

			render "new", layout: "inner-basic"
		else
			redirect_to "/login"
		end
	end

	def index_personal
		if session[:user_id]
			@blogs = Blog.where(user_id: session[:user_id]).paginate(:page => params[:page], :per_page => 5).order(created_at: :desc)

			@user = User.find(session[:user_id])

			render "index-personal", layout: "inner-info"
		else
			redirect_to "/"
		end
	end

	def index_public
		@blogs = Blog.all.where("user_id != ?", session[:user_id]).where(post_privacy: "public").paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)

		@header_text = "Blog - Inspirational posts from people like you."

		render "index-public", layout: "inner-basic"
	end

	def create
		new_blog = blog_params.merge(user_id: session[:user_id])

		added_blog = Blog.create(new_blog)

		#Save blog tags to db

		blog_tags_array = params[:post_tags].split(",")

		blog_tags_array.each do |tag|
			BlogTag.create(blog_id: added_blog.id, blog_tag: tag)
		end

		redirect_to "/"
	end

	def post_show
		@post = Blog.find(params[:id])
		@user = User.find(@post.user_id)

		@post_photos = BlogPhoto.where(post_id: @post.post_id)

		@post_comments = BlogComment.where(blog_id: @post.id).paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)

		@sidebar_header_text = "About the Author"

		render "post"
	end

	def save_comment
		blog_comment = BlogComment.create(blog_id: params[:id], commentor_id: session[:user_id], blog_comment: params[:comment_text])

		#Create notification for user

		blog_owner_id = Blog.find(params[:id]).user_id

		Notification.create(notification_type: "blog_comment", item_id: params[:id], guest_user_id: session[:user_id], owner_user_id: blog_owner_id)

		redirect_to "/post/" + params[:id]
	end

	def image_upload
		if BlogPhoto.create(post_photo: params[:file], post_id: params[:blog_post_id], contributor_id: session[:user_id])
			render :text => "ok"
		else
			render :text => "not ok"
		end
	end

	def save_follower
		follower = BlogFollower.where(owner_id: params[:owner_id], follower_id: session[:user_id])

		if follower.exists?
			if follower.first.destroy
				render :json => { result: "ok", state: "removed" }
			else
				render :json => { result: "error", error: "There was an error removing the follower." }
			end
		else
			if BlogFollower.create(owner_id: params[:owner_id], follower_id: session[:user_id])
				render :json => { result: "ok", state: "added" }
			else
				render :json => { result: "error", error: "There was a problem adding the follower." }
			end
		end
	end

	def my_followers
		@followers = BlogFollower.where(owner_id: session[:user_id]).paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)

		render "followers"
	end

private
	
	def blog_params
		params.require(:post).permit(:post_title, :post_text, :post_category, :post_privacy, :post_id)
	end
end
