class RecruitContactsController < ApplicationController
  def index
    @latest_contacts = RecruitContact.last(20)

    authorize RecruitContact
  end

  def create
    authorize RecruitContact

    @recruit_contact = RecruitContact.new(create_recruit_contacts_params)
    if @recruit_contact.save
      redirect_to recruit_contacts_path
    else
      @conversation_type_options = assemble_conversation_options
      @timezone_options = assemble_timezone_options
      render 'new'
    end
  end

  def new
    authorize RecruitContact

    @recruit_contact = RecruitContact.new()
    @timezone_options = assemble_timezone_options
    @conversation_type_options = assemble_conversation_options
    @requirements = RecruitRequirement.all
  end

  def edit
    authorize RecruitContact
  end

  def show
    authorize RecruitContact
    @recruit_contact = RecruitContact.find(params[:id])
  end

  def search_name
    authorize RecruitContact
    recruit_contact = RecruitContact.find_by(name: params[:name])
    if recruit_contact.nil?
      flash[:alert] = "Contact '#{params[:name]}' not found"
      redirect_to recruit_contacts_path
    else
      redirect_to recruit_contact_path(recruit_contact)
    end
  end

  def update
    authorize RecruitContact
  end

  def destroy
    authorize RecruitContact
  end

  private
    def create_recruit_contacts_params
      params.require(:recruit_contact).permit(:name, :contacted_by, :conversation_type, :timezone, :conclusion)
    end

    def assemble_timezone_options
      tzs = ActiveSupport::TimeZone.us_zones
      timezone_options = []
      tzs.each do |tz|
        timezone_options.push(tz.name)
      end
      timezone_options.push("Europe")
      timezone_options.push("Australia")
      timezone_options.push("Asia")
      timezone_options.push("Unknown")

      return timezone_options
    end

    def assemble_conversation_options
      ["TeamSpeak", "Private Conversation", "Public Conversation"]
    end
end
