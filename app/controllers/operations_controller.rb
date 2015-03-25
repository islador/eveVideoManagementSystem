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

    # time_select tags do not properly configure the date aspect of the time object.
    # Create date enabled times to properly support timezones
    op_prep_start = DateTime.new(op_date.year, op_date.month, op_date.day, params[:operation]["op_prep_start(4i)"].to_i, params[:operation]["op_prep_start(5i)"].to_i, 0, "0")
    op_departure = DateTime.new(op_date.year, op_date.month, op_date.day, params[:operation]["op_departure(4i)"].to_i, params[:operation]["op_departure(5i)"].to_i, 0, "0")
    op_completion = DateTime.new(op_date.year, op_date.month, op_date.day, params[:operation]["op_completion(4i)"].to_i, params[:operation]["op_completion(5i)"].to_i, 0, "0")

    year = Year.find_by(name: "#{op_date.year}")

    unless year.nil?
      # If year is found, check for month
      month = year.months.find_by(name: "#{op_date.strftime("%B")}")
      unless month.nil?
        # If month is found, create the operation
        @operation = month.operations.new(create_operations_params)

      else
        # otherwise, create the month, then the operation
        month = year.months.create(name: "#{op_date.strftime("%B")}")
        @operation = month.operations.new(create_operations_params)
      end
    else
      # If year is not found, create the year, month & then operation
      year = Year.create(name: "#{op_date.year}")
      month = year.months.create(name: "#{op_date.strftime("%B")}")
      @operation = month.operations.new(create_operations_params)
    end
    @operation.op_date = op_date
    @operation.op_prep_start = op_prep_start
    @operation.op_departure = op_departure
    @operation.op_completion = op_completion
    @operation.save
    redirect_to operation_path(@operation)
  end

  def new
    # Determine if it's DST in the states
    Time.zone = "Pacific Time (US & Canada)"
    @dst = Time.zone.now.dst?

    # Adjust the displayed time to match the time for each TZ
    time = Time.now
    if @dst
      @pst_hour = (time.hour - 7).to_s
      @cst_hour = (time.hour - 5).to_s
      @est_hour = (time.hour - 4).to_s
    else
      @pst_hour = (time.hour - 8).to_s
      @cst_hour = (time.hour - 6).to_s
      @est_hour = (time.hour - 5).to_s
    end

    # Pad the time by an hour
    if @pst_hour.length == 1
      @pst_hour = "0#{@pst_hour}"
    end
    if @cst_hour.length == 1
      @cst_hour = "0#{@cst_hour}"
    end
    if @est_hour.length == 1
      @est_hour = "0#{@est_hour}"
    end

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
     #params.require(:operation).permit(:name, :op_date, :op_prep_start, :op_departure, :op_completion, :doctrine, :eve_time, :voice_coms_server, :voice_coms_server_channel, :rally_point, :fleet_commander, {specialty_roles: []}, {ships: []})
     params.require(:operation).permit(:name, :doctrine, :eve_time, :voice_coms_server, :voice_coms_server_channel, :rally_point, :fleet_commander, {specialty_roles: []}, {ships: []})
    end
end
