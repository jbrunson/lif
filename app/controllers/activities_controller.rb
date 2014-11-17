class ActivitiesController < ActionController::Base
  include UserHelpers
  layout "application"
  before_filter :authenticate_user!

  def index
    @activities = current_user.activities
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = current_user.activities.build activity_params

    if @activity.save
      flash[:notice] = "Trip added"
      redirect_to activities_path
    else
      render :action => 'new'
    end
  end

  def edit
    @activity = find_activity
  end

  def update
    @activity = find_activity
    if @activity.update_attributes activity_params
      redirect_to activities_path
    else
      render :action => :edit
    end
  end

  def destroy
    @activity = find_activity
    @activity.destroy
    redirect_to activities_path
  end

  def show
    @activity = find_activity

    users = User.excluding_user(current_user).select do |user|
      user.activities.any? do |act|
        act.overlaps?(@activity) 
      end
    end

    @possible_matches = users
    @nearby_users = nearby_users_from_location(current_activity).limit(20)
    @possible_matches = @possible_matches.concat(@nearby_users)
  end

  def current_activity
    @activity ||= find_activity
  end

  def friendly_date_format(date)
    date.strftime("%b %d, %Y")
  end

  private

  def activity_params
    params.require(:activity).permit(:arrival_date, :departure_date, :location)
  end

  def find_activity
    Activity.find params[:id]
  end
end