class RolesController < ApplicationController
  def index
    authorize self
    @roles = Role.all
  end

  def new
    authorize self
    @role = Role.new()
  end

  def create
    authorize self
    @role = Role.new(create_role_params)
    if @role.save
      redirect_to roles_path
    else
      render 'new'
    end
  end

  def show
    authorize self
    @role = Role.find(params[:id])
  end

  def edit
    authorize self
    @role = Role.find(params[:id])
  end

  def update
    authorize self
    @role = Role.find(params[:id])

    if @role.update_attributes(create_role_params)
      if @role.save
        redirect_to roles_path
      else
        render 'edit'
      end
    else
      render 'edit'
    end
  end

  def destroy
    authorize self
    @role = Role.find(params[:id]).destroy
    # Need to update all the user's hashes when a role is destroyed.
    # Likely a good candidate for a background job
  end

  private
    def create_role_params
      params.require(:role).permit(:name, :description, :hierarchy_ranking)
    end
end
