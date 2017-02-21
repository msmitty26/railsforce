class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy], :unless => :initial_search?

  # GET /contacts
  # GET /contacts.json
  def index
    
    if params[:simple_query]
      @contacts = Contact.search_by_contact_full_name(params[:simple_query]).order("created_at DESC")
    else
      @contacts = Contact.all.order('created_at DESC')
    end
    
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        # Tell the UserMailer to send email after save based on affiliation
        if @contact.affiliation.present?
          if @contact.affiliation.name == "Industry"
            UserMailer.industry_notification.deliver
          elsif @contact.affiliation.name == "Government"
            UserMailer.government_notification.deliver
          elsif @contact.affiliation.name == "Education"
            UserMailer.education_notification.deliver
          end
        end

        # Tell the UserMailer to send email after save based on attributes
        if @contact.golf? == true
          UserMailer.golf_notification.deliver
        end
         
        format.html { redirect_to contacts_url, notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
        format.js
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        # Tell the UserMailer to send email after save based on affiliation
        if @contact.affiliation.present?
          if @contact.affiliation.name == "Industry"
            UserMailer.industry_notification.deliver
          elsif @contact.affiliation.name == "Government"
            UserMailer.government_notification.deliver
          elsif @contact.affiliation.name == "Education"
            UserMailer.education_notification.deliver
          end
        end
        
        # Tell the UserMailer to send email after save based on attributes
        if @contact.golf? == true
          UserMailer.golf_notification.deliver
        end

        format.html { redirect_to contacts_url, notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :email_address, :organization, :title, :phone_number, :member,
                                      :speaker, :events, :golf, :affiliation_id, :comments)
    end
    
    def search
      term = params[:term] || nil
      contacts = []
      contacts = Contact.where('name LIKE ?', "%#{term}%") if term
      render json: contacts
    end
    
    def initial_search?
      params[:id] == "search"
    end
end
