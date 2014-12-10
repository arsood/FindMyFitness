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
		@blogs = Blog.all.paginate(:page => params[:page], :per_page => 10).order(created_at: :desc)

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

		render "post"
	end

	def image_upload
		if BlogPhoto.create(post_photo: params[:file], post_id: params[:blog_post_id], contributor_id: session[:user_id])
			render :text => "ok"
		else
			render :text => "not ok"
		end
	end

private
	
	def blog_params
		params.require(:post).permit(:post_title, :post_text, :post_category, :post_privacy, :post_id)
	end
end
