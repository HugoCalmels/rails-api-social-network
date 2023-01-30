class ContactMailer < ApplicationMailer

  def contact(contactDemand)
    @contactDemand = contactDemand
    mail(to: "calmels.hugo@yahoo.fr", subject:'PORTOFOLIO - DEMANDE DE CONTACT')
  end
end
