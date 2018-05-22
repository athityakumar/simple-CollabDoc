class DocumentController < ApplicationController
  def share
		@user = User.find(session[:user_id])

		if params[:template_id]
			@template = Template.find(params[:template_id])
			puts @template.number_of_signees
		end

  	if request.post?
			@document = Document.create()
			@template.documents << [@document]

			emails = document_emails_params.values
			emails.each do |email|
				signee = User.find_by_email(email)
				unless signee
					signee = User.create(name: "new user", email: email, password: " ", allow_login: false, allow_login_key: ('a'..'z').to_a.shuffle[0..100].join)
				end
				@document.users << [signee]
			end

			@document.users << [@user]
			redirect_to document_show_path(document_id: @document.id)
  	end
  end

  def show
		@user = User.find(session[:user_id])

  	@document = Document.find(params[:document_id])
 		@image_urls = @document.template.rel_image_paths
  end

  def sign
  	user_id = session[:user_id]
  	document_id = params[:document_id]
  	UserDocument.where(user_id: user_id, document_id: document_id).update(submitted: true)

  	redirect_to document_show_path
  end

  def index
		@user = User.find(session[:user_id])
		@documents = @user.documents
  end

  private

  def document_emails_params
  	params.require(:document).require(:emails)
  end
end
