class TemplateController < ApplicationController
  def fill
  	@user = User.find(session[:user_id])
  	@template = Template.find(params[:template_id])
  	if request.patch?
			@template.update(template_params)
			redirect_to document_share_path(template_id: @template.id)
  	end
  end

  def upload
  	@user = User.find(session[:user_id])
  	if request.get?
  		@template = Template.new
  	else
  		pdf = template_params["pdf"]
  		puts pdf.original_filename
  		# puts File.read(pdf.tempfile)

  		tempfile_path = pdf.tempfile.path
  		filename = process_uploaded_pdf(tempfile_path)
			@template = Template.create(name: pdf.original_filename, filepath: filename, number_of_signees: 2)

			if @template.save
				@user.templates << [@template]
		 		redirect_to template_fill_path(template_id: @template.id)
		 	end
  	end
  end

  def share
  	@user = User.find(session[:user_id])
  end

  private

  def process_uploaded_pdf(tempfile_path)
		puts tempfile_path
		filename = tempfile_path.split('/').last

		unless Dir.entries(Rails.root.to_s).include?('storage')
			`mkdir #{Rails.root.join('storage')}`	
		end

		dirname = Rails.root.join('storage', filename)
		`mkdir #{dirname}`

		pdf = ::Magick::ImageList.new(tempfile_path)
		pdf.each_with_index do |page_img, i|
		  page_img.write "#{dirname}/#{i}.png"
		end

		return filename
		# `cp #{tempfile_path} #{Rails.root.join('storage', filename)}`
  end

  def template_params
		params.require('template').permit(:name, :pdf, :number_of_signees)
  end
end
