class Api::V1::ContactController < ApplicationController

  def new
    @contact = Contact.new
    @contact.save
  end

  def contact

    contactDemand = Hash.new
    contactDemand["email"] = params[:contact_demand][:email]
    contactDemand["name"] = params[:contact_demand][:name]
    contactDemand["content"] = params[:contact_demand][:content]
    ContactMailer.contact(contactDemand)
    render json: {message: "contact demand sent"}
  end
end
