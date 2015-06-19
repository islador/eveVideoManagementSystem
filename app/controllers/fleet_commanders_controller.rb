class FleetCommandersController < ApplicationController
  def index
  end

  def show
    @fleet_commander = FleetCommander.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
    begin
      fleet_commander = FleetCommander.find(params[:id])

      fleet_commander.destroy
      flash[:notice] = "Fleet Commander #{fleet_commander.name} has been removed."
    rescue ActiveRecord::RecordNotFound => e
      flash[:alert] = "Fleet Commander not found."
    end

    redirect_to fleet_commanders_path
  end
end
