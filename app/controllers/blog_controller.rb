class BlogController < ApplicationController
	def new
		@header_text = "Write a Post"
		#Generate random hash to be associated with images
		@post_id = Digest::MD5.hexdigest(Time.now.to_s)

		render "new", layout: "inner-basic"
	end

	def create
		new_blog = blog_params.merge(user_id: session[:user_id])

		Blog.create(new_blog)

		redirect_to "/"
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
