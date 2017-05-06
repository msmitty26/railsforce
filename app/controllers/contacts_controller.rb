class ContactsController < ApplicationController
#  before_action :set_contact, only: [:show, :edit, :update, :destroy], :unless => :initial_search?

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
    @contact = set_contact
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
    @contact = set_contact
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
    @contact = set_contact
    
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
    @contact = set_contact
    
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    if params.blank?
      @contacts
    else
      if params[:name].present?
        name = params[:name]
        name = "%#{name}%"
      else
        name = ""
      end
      
      if params[:email_address].present?
        email_address = params[:email_address]
        email_address = "%#{email_address}%"
      else
        email_address = ""
      end
      
      if params[:organization].present?
        organization = params[:organization]
        organization = "%#{organization}%"
      else
        organization = ""
      end
      
      if params[:title].present?
        title = params[:title]
        title = "%#{title}%"
      else
        title = ""
      end
      
      if params[:phone_number].present?
        phone_number = params[:phone_number]
        phone_number = "%#{phone_number}%"
      else
        phone_number = ""
      end
      
      if params[:member].present?
        member = true
      end
      
      if params[:speaker].present?
        speaker = true
      end
      
      if params[:events].present?
        events = true
      end
      
      if params[:golf].present?
        golf = true
      end
      
      if params[:sponsorship].present?
        sponsorship = true
      end
      
      # if params[:search_type] == "or"
        @contacts = Contact.where("first_name like ? OR last_name like ? OR email_address like ? OR organization like ? OR title like ? 
                                    OR phone_number like ? OR member like ? OR speaker like ? OR events like ? OR golf like ? OR sponsorship like ?",
                                    name, name, email_address, organization, title, phone_number, member, speaker, events, golf, sponsorship)
      # elsif params[:search_type] == "and"
      #   @contacts = Contact.where("first_name like ? AND last_name like ? AND email_address like ? AND organization like ? AND title like ? 
      #                               AND phone_number like ? AND member like ? AND speaker like ? AND events like ? AND golf like ? AND sponsorship like ?",
      #                               name, name, email_address, organization, title, phone_number, member, speaker, events, golf, sponsorship)
      # end

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
                                      :speaker, :sponsorship, :events, :golf, :affiliation_id, :comments)
    end
    
    def quick_search
      term = params[:term] || nil
      contacts = []
      contacts = Contact.where('name LIKE ?', "%#{term}%") if term
      render json: contacts
    end
    
end
