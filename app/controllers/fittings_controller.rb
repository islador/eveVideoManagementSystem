class FittingsController < ApplicationController
  def index
    @doctrine = Doctrine.find(params[:doctrine_id])
    @fittings = Fitting.where(doctrine_id: params[:doctrine_id])
    authorize @fittings[0]
  end

  def create
    @fitting = Fitting.new(create_fitting_params)
    authorize @fitting
    # Split the EFT String apart line by line
    eft_string = params[:eft_string]
    eft_string_components = eft_string.split("\n")

    # Extract the hull and name data from the first line
    clean_info_bracket = eft_string_components[0].chomp
    info_bracket = clean_info_bracket.slice(1..clean_info_bracket.length-2).split(", ")
    @fitting.hull = info_bracket[0]
    @fitting.name = info_bracket[1]

    if @fitting.save
      doctrine = @fitting.doctrine
      redirect_to doctrine_path(@fitting.doctrine)
    else
      @doctrine = Doctrine.find(params[:doctrine_id])
      render 'new'
    end
  end

  def new
    @doctrine = Doctrine.find(params[:doctrine_id])
    @fitting = Fitting.new(doctrine_id: @doctrine.id)
    authorize @fitting
  end

  def edit
    @fitting = Fitting.find(params[:id])
    authorize @fitting
  end

  def show
    @fitting = Fitting.find(params[:id])
    authorize @fitting
  end

  def update
    @fitting = Fitting.find(params[:id])
    authorize @fitting

    if @fitting.update_attributes(create_fitting_params)
      if @fitting.save
        redirect_to doctrine_fittings_path(@fitting)
      else
        render 'edit'
      end
    else
      render 'edit'
    end
  end

  def destroy
    @fitting = Fitting.find(params[:id])
    authorize @fitting

    @fitting.destroy
    redirect_to doctrine_fittings_path(params[:doctrine_id])
  end

  private
    def create_fitting_params
      params.permit(:name, :hull, :race, :fleet_role, :description, :progression, :progression_position, :eft_string, :doctrine_id)
    end
end
