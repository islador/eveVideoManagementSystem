class VideosController < ApplicationController
  before_action :authenticate_user!

  def show
    # Returns a given video's page
  end

  def index
    # Returns the mentioned table, with years populated
    # Clicking a year should retrieve the months
    # Clicking a month should retrieve the op
  end

  def new
    # Returns the new video upload page
    # Needs to be async upload direct to S3
  end

  def create
    # Creates a video
  end

  def edit
    # Returns the video edit page
    # Video's should have owners, such that owners can edit the video
  end

  def update
    # Does the action of updating the target video
  end

  def destroy
    # Destroys the target
  end
end
