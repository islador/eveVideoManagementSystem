class OperationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @operations = Operation.all
  end

  def create
    # Needs error pathway
    # Ships && Specialty Roles accept CSV and turns them into arrays
    params[:operation][:ships] = params[:operation][:ships].split(",")
    params[:operation][:specialty_roles] = params[:operation][:specialty_roles].split(",")

    op_date = Date.new(params[:operation]["op_date(1i)"].to_i, params[:operation]["op_date(2i)"].to_i, params[:operation]["op_date(3i)"].to_i)
    year = Year.find_by(name: "#{op_date.year}")

    unless year.nil?
      # If year is found, check for month
      month = year.month.find_by(name: "#{op_date.strftime("%B")}")
      unless month.nil?
        # If month is found, create the operation
        @operation = month.operations.create(create_operations_params)
      else
        # otherwise, create the month, then the operation
        month = year.months.create(name: "#{op_date.strftime("%B")}")
        @operation = month.operations.create(create_operations_params)
      end
    else
      # If year is not found, create the year, month & then operation
      year = Year.create(name: "#{op_date.year}")
      month = year.months.create(name: "#{op_date.strftime("%B")}")
      @operation = month.operations.create(create_operations_params)
    end

    redirect_to operation_path(@operation)
  end

  def new
    @dst = Time.now.dst?
    @operation = Operation.new()
  end

  def edit
  end

  def show
    @operation = Operation.find(params[:id])

    date_ordinal = @operation.op_date.strftime("%-d").to_i.ordinal
    @formatted_op_date = "#{@operation.op_date.strftime("%A the #{@operation.op_date.strftime("%-d")}#{date_ordinal} of %B")}"

    @videos = @operation.videos
  end

  def update
  end

  def destroy
  end

  private
    def create_operations_params
      params.require(:operation).permit(:name, :op_date, :op_prep_start, :op_departure, :op_completion, :doctrine, :eve_time, :voice_coms_server, :voice_coms_server_channel, :rally_point, :fleet_commander, {specialty_roles: []}, {ships: []})
    end
end
