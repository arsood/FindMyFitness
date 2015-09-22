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

	def index_specific
		@blogs = Blog.where(user_id: params[:user_id]).paginate(:page => params[:page], :per_page => 5).order(created_at: :desc)

		@user = User.find(params[:user_id])

		if @user.user_type == "business"
			@business = Business.where(user_id: @user.id).first
		end

		if session[:user_type] == "standard"
			render "index-personal", layout: "inner-info"
		else
			render "index-personal", layout: "inner-info-business"
		end
	end

	def index_public
		if params[:hash_tags]
			given_tags = params[:hash_tags].split(",")
			
			statement = ""

			given_tags.each_with_index do |tag, index|
				if index == 0
					statement += "LOWER(blog_tag) LIKE ?"
				elsif index == given_tags.length - 1
					statement += " OR LOWER(blog_tag) LIKE ?"
					#statement += " AND user_id != " + session[:user_id].to_s
					statement += " ORDER BY created_at DESC"
				else
					statement += " OR LOWER(blog_tag) LIKE ?"
				end
			end

			given_tags.map! do |tag|
				"%" + tag.downcase + "%"
			end

			match_condition = given_tags.unshift("SELECT DISTINCT blog_id FROM blog_tags WHERE " + statement)
			matches = BlogTag.find_by_sql match_condition

			blogs = []

			matches.each do |match|
				blog = Blog.find(match.blog_id)
				blogs << blog

				@blogs = blogs.paginate(:page => params[:page], :per_page => 10)
			end
		else
			#If there is a category specified only show those posts
			if params[:cat] && params[:cat] == "all" || !params[:cat]
				@blogs = Blog.all.where(post_privacy: "public").paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)
			else
				following = BlogFollower.where(follower_id: session[:user_id])

				@blogs = Blog.where("user_id IN (?)", following.ids).paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)
			end
		end

		@header_text = "Blogs - recently added"

		if session[:user_type] == "business"
			render "index-public", layout: "business-topbar"
		else
			render "index-public", layout: "inner-basic"
		end
	end

	def create
		new_blog = blog_params.merge(user_id: session[:user_id])

		#Add in business id if it's a business user

		if session[:business_id]
			new_blog.merge!(business_id: session[:business_id])
		end

		added_blog = Blog.create(new_blog)

		#Save blog tags to db

		blog_tags_array = params[:post_tags].split(",")

		blog_tags_array.each do |tag|
			BlogTag.create(blog_id: added_blog.id, blog_tag: tag, user_id: session[:user_id])
		end

		if session[:business_id]
			redirect_to "/business-admin/blogs/" + session[:business_id].to_s
		else
			redirect_to "/blog/me"
		end
	end

	def post_show
		@post = Blog.find(params[:id])
		@user = User.find(@post.user_id)

		if @user.user_type == "business"
			@business = Business.where(user_id: @user.id).first
			@type = "business"
		else
			@type = "standard"
		end

		@post_photos = BlogPhoto.where(post_id: @post.post_id)

		@post_comments = BlogComment.where(blog_id: @post.id).paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)

		@like_exists = BlogLike.where(user_id: session[:user_id], post_id: @post.id).exists?

		@sidebar_header_text = "About the Author"

		if session[:user_type] == "business"
			render "post", layout: "business-topbar"
		else
			render "post", layout: "standard-20"
		end
	end

	def post_edit
		@post = Blog.find(params[:id])

		if @post.user_id == session[:user_id]
			@photos = BlogPhoto.where(post_id: @post.post_id)
			render "edit"
		else
			flash[:error] = "You must be logged in to do that."
			redirect_to "/login"
		end
	end

	def post_update
		blog = Blog.find(params[:id])

		if blog.user_id == session[:user_id]
			blog.update_attributes(blog_params)

			#Save blog tags to db

			BlogTag.where(blog_id: params[:id]).destroy_all

			blog_tags_array = params[:post_tags].split(",")

			blog_tags_array.each do |tag|
				BlogTag.create(blog_id: blog.id, blog_tag: tag)
			end

			if session[:business_id]
				redirect_to "/business-admin/blogs/" + session[:business_id].to_s
			else
				redirect_to "/post/" + blog.id.to_s
			end
		else
			flash[:error] = "You must be logged in to do that."
			redirect_to "/login"
		end
	end

	def save_comment
		old_posters = BlogComment.where(blog_id: params[:id]).where.not(commentor_id: session[:user_id])

		blog_comment = BlogComment.create(blog_id: params[:id], commentor_id: session[:user_id], blog_comment: params[:comment_text])

		#Create notification for user

		blog_owner_id = Blog.find(params[:id]).user_id

		if blog_owner_id != session[:user_id]
			Notification.create(notification_type: "blog_comment", item_id: params[:id], guest_user_id: session[:user_id], owner_user_id: blog_owner_id)
		end

		#Create notification for users who have previously commented on the same post

		if old_posters.any?
			old_posters.each do |poster|
				Notification.create(notification_type: "old_blog_comment", item_id: params[:id], guest_user_id: session[:user_id], owner_user_id: poster.commentor_id)
			end
		end

		redirect_to "/post/" + params[:id]
	end

	def image_upload
		if BlogPhoto.create(post_photo: params[:file], post_id: params[:blog_post_id], contributor_id: session[:user_id])
			render :text => "ok"
		else
			render :text => "not ok"
		end
	end

	def image_delete
		if BlogPhoto.find(params[:image_id]).destroy
			render :json => { result: "ok" }
		else
			render :json => { result: "error", error: "There was a problem deleting this photo." }
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

				Notification.create(notification_type: "new_follower", item_id: nil, guest_user_id: session[:user_id], owner_user_id: params[:owner_id])

				render :json => { result: "ok", state: "added" }
			else
				render :json => { result: "error", error: "There was a problem adding the follower." }
			end
		end
	end

	def my_followers
		@followers = BlogFollower.where(owner_id: session[:user_id]).paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)

		render "followers", layout: "standard-20"
	end

	def my_following
		@followers = BlogFollower.where(follower_id: session[:user_id]).paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)

		render "following", layout: "standard-20"
	end

	def public_followers
		@followers = BlogFollower.where(owner_id: params[:user_id]).paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)

		if session[:user_type] == "standard"
			render "followers", layout: "standard-20"
		else
			render "followers", layout: "business-topbar"
		end
	end

	def public_following
		@followers = BlogFollower.where(follower_id: params[:user_id]).paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)

		if session[:user_type] == "standard"
			render "following", layout: "standard-20"
		else
			render "following", layout: "business-topbar"
		end
	end

	def like_post
		user_id = Blog.find(params[:post_id]).user_id

		BlogLike.create(user_id: session[:user_id], post_id: params[:post_id])

		Notification.create(notification_type: "post_like", item_id: params[:post_id], guest_user_id: session[:user_id], owner_user_id: user_id)

		render :json => { result: "ok" }
	end

private
	
	def blog_params
		params.require(:post).permit(:post_title, :post_text, :post_category, :post_privacy, :post_id)
	end
end
