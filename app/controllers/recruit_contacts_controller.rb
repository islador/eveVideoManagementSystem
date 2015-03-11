class RecruitContactsController < ApplicationController
  def index
    @latest_contacts = RecruitContact.last(20)
  end

  def create
    recruit_contact = RecruitContact.new(create_recruit_contacts_params)
    if recruit_contact.save
      redirect_to recruit_contacts_path
    else
      redirect_to new_recruit_contact_path
    end
  end

  def new
    @recruit_contact = RecruitContact.new()

    @conversation_type_options = ["TeamSpeak", "Private Conversation", "Public Conversation"]
    tzs = ActiveSupport::TimeZone.us_zones
    @timezone_options = []
    tzs.each do |tz|
      @timezone_options.push(tz.name)
    end
    @timezone_options.push("Europe")
    @timezone_options.push("Australia")
  end

  def edit
  end

  def show
    @recruit_contact = RecruitContact.find(params[:id])
  end

  def search_name
    recruit_contact = RecruitContact.find_by(name: params[:name])
    if recruit_contact.nil?
      flash[:alert] = "Contact '#{params[:name]}' not found"
      redirect_to recruit_contacts_path
    else
      redirect_to recruit_contact_path(recruit_contact)
    end
  end

  def update
  end

  def destroy
  end

  private
    def create_recruit_contacts_params
      params.require(:recruit_contact).permit(:name, :found_by, :conversation_type, :timezone, :conclusion)
    end
end
