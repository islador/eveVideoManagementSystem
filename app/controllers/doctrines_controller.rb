class DoctrinesController < ApplicationController
  def index
    # Index should only display accessible doctrines, explore pundit and scoping for this
  end

  def create
    @doctrine = Doctrine.new(create_doctrine_params)
    if @doctrine.save
      redirect_to doctrines_path
    else
      render 'new'
    end
  end

  def new
    @doctrine = Doctrine.new
  end

  def edit
    # Edit should only be available to the doctrine owner? Think on this
  end

  def show
    # Show should be restricted by pundit based on whether it would show up in the index or not
  end

  def update
    # same as edit?
  end

  def destroy
    # Same as edit? hmmm...
  end

  private
    def create_doctrine_params
      params.require(:doctrine).permit(:name, :abbreviation, :short_description, :long_description, :access_by_hierarchy)
    end
end
