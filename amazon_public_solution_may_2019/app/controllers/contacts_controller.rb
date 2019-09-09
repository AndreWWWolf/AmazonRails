class ContactsController < ApplicationController
  def index
  end

  def create
    # Here it would be possible to use the params submitted in the form
    # if they were needed (We don't need them for this solution). 
    @name = params[:name]
    @email = params[:email]
    @text = params[:text]
  end
end
