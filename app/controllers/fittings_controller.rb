class FittingsController < ApplicationController
  def index
    @fittings = Fittings.where(doctrine_id: params[:doctrine_id])
    authorize @fittings[0]
  end

  def create
    @fitting = Fitting.new(create_fitting_params, doctrine_id: params[:doctrine_id])
    authorize @fitting
    if @fitting.save
      redirect_to doctrine_fittings_path(@fitting)
    else
      render 'new'
    end
  end

  def new
    @fitting = Fitting.new(doctrine_id: params[:doctrine_id])
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
  end

  private
    def create_fitting_params
      params.permit(:name, :hull, :race, :fleet_role, :description, :progression, :progression_position, :eft_string)
    end
end
