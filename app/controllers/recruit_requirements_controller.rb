class RecruitRequirementsController < ApplicationController
  def index
    @recruit_requirements = RecruitRequirement.all
  end

  def create
    @recruit_requirement = RecruitRequirement.new(create_recruit_requirement_params)
    if @recruit_requirement.save
      redirect_to recruit_requirements_path
    else
      @existing_recruit_requirements = RecruitRequirement.all
      render 'new'
    end
  end

  def new
    @recruit_requirement = RecruitRequirement.new()
    @existing_recruit_requirements = RecruitRequirement.all
  end

  def edit
    @recruit_requirement = RecruitRequirement.find(params[:id])
  end

  def show
    @recruit_requirement = RecruitRequirement.find(params[:id])
  end

  def update
    @recruit_requirement = RecruitRequirement.find(params[:id])

    if @recruit_requirement.update_attributes(create_recruit_requirement_params)
      if @recruit_requirement.save
        redirect_to recruit_requirements_path
      else
        render 'edit'
      end
    else
      render 'edit'
    end
  end

  def destroy
    RecruitRequirement.find(params[:id]).destroy
    redirect_to recruit_requirements_path
  end

  private
    def create_recruit_requirement_params
      params.require(:recruit_requirement).permit(:detail)
    end
end
