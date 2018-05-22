class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :show_flash

  def spoof_admin_user
  	User.new(name: 'IRS', email: 'irsverify@gmail.com', password: 'irs')
  end

  private

  def show_flash
    flash.now[:notice] = "Found the about page!" if request.path == '/pages/about'
  end
end
