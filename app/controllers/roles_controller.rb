class RolesController < ApplicationController
  def index
    @roles = Role.all
  end

  def new
    @role = Role.new()
  end

  def create
    @role = Role.new(create_role_params)
    if @role.save
      redirect_to roles_path
    else
      render 'new'
    end
  end

  def show
    @role = Role.find(params[:id])
  end

  def edit
    @role = Role.find(params[:id])
  end

  def update
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
    @role = Role.find(params[:id]).destroy
    # Need to update all the user's hashes when a role is destroyed.
    # Likely a good candidate for a background job
  end

  private
    def create_role_params
      params.require(:role).permit(:name, :description, :hierarchy_ranking)
    end
end
