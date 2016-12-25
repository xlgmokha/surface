class Api::WorkoutsController < Api::Controller
  def index
    @workouts = current_user.workouts.recent.includes(:exercise_sets).limit(12)
  end

  def new
    @workout = current_user.next_workout_for(current_user.next_routine)
  end
end
