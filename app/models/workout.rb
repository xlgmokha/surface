class Workout < ApplicationRecord
  belongs_to :user
  belongs_to :routine
  has_one :program, through: :routine
  has_many :exercises, through: :exercise_sets
  has_many :exercise_sets, dependent: :destroy
  accepts_nested_attributes_for :exercise_sets
  delegate :name, to: :routine
  alias_method :sets, :exercise_sets

  scope :recent, -> { order(occurred_at: :desc) }
  scope :with_exercise, ->(exercise) do
    joins(:exercises).where(exercises: { id: exercise.id })
  end

  def body_weight
    Quantity.new(read_attribute(:body_weight), :lbs)
  end

  def train(exercise, target_weight, repetitions:, set: nil)
    all_sets = sets.for(exercise).to_a
    if set.present? && (exercise_set = all_sets.to_a.at(set)).present?
      exercise_set.update!(actual_repetitions: repetitions, target_weight: target_weight)
      exercise_set
    else
      recommendation = program.recommendation_for(user, exercise)
      exercise_set = sets.build(
        type: WorkSet.name,
        exercise: exercise,
        target_repetitions: recommendation.repetitions
      )
      exercise_set.update!(actual_repetitions: repetitions, target_weight: target_weight)
      exercise_set
    end
  end

  def progress_for(exercise)
    Progress.new(self, exercise)
  end

  def each_exercise
    exercises.order(:created_at).distinct.each do |exercise|
      yield exercise
    end
  end
end
