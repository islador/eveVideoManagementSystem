class DoctrinesController < ApplicationController
  def index
    # This is messy, and can probably be done easier.
    @doctrines = Doctrine.where(id: DoctrinesRole.where(role_id: current_user.roles.pluck(:id)).pluck(:doctrine_id))
  end

  def create
    @doctrine = Doctrine.new(create_doctrine_params)
    if @doctrine.save
      # Batch insert all the roles the doctrine should have into the database
      doctrines_roles = []
      params[:roles].each do |role_id|
        doctrines_roles << {doctrine_id: @doctrine.id, role_id: role_id}
      end
      DoctrinesRole.create(doctrines_roles)

      redirect_to doctrines_path
    else
      @roles = current_user.less_or_equal_roles
      render 'new'
    end
  end

  def new
    @doctrine = Doctrine.new

    @roles = current_user.less_or_equal_roles
  end

  def edit
    @doctrine = Doctrine.find(params[:id])
    authorize @doctrine
    # Edit should only be available to the doctrine owner? Think on this
  end

  def show
    @doctrine = Doctrine.find(params[:id])
    authorize @doctrine
  end

  def update
    # same as edit?
  end

  def destroy
    # Same as edit? hmmm...
  end

  private
    def create_doctrine_params
      params.permit(:name, :abbreviation, :short_description, :long_description, :access_by_hierarchy)
    end
end
