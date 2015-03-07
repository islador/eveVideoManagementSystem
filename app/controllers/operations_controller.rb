class OperationsController < ApplicationController
  def index
  end

  def create
    # Ships && Specialty Roles accept CSV and turns them into arrays
    params[:operation][:ships] = params[:operation][:ships].split(",")
    params[:operation][:specialty_roles] = params[:operation][:specialty_roles].split(",")


    @operation = Operation.create(create_params)

    redirect_to operation_path(@operation)
  end

  def new
    @operation = Operation.new()
  end

  def edit
  end

  def show
    @operation = Operation.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private
    def create_params
      params.require(:operation).permit(:name, :eve_date, :doctrine, :eve_time, :voice_coms_server, :voice_coms_server_channel, :rally_point, {specialty_roles: []}, {ships: []})
    end
end
