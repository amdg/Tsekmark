class ContactsController < ApplicationController

  def index
    @contacts = current_user.contacts
  end

  def save
    contacts = params[:contacts]
    counter = 0
    contacts.each do |c|
      counter += 1
      contact_arr = Marshal.load(c).split('|')
      contact = {name: contact_arr[0], email: contact_arr[1], provider: contact_arr[2]}
      current_user.contacts.create(contact)
    end
    flash[:notice] = "Added #{counter} new contacts!"
    redirect_to contacts_index_path
  end
end