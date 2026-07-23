class AvailabilitySlot < ApplicationRecord
  belongs_to :user

  enum :status, { available: 0, flexible: 1 }, validate: true

  DAYS = %w[Sun Mon Tue Wed Thu Fri Sat].freeze
  HOURS = (8..23).to_a.freeze

  validates :day_of_week, inclusion: { in: 0..6 }
  validates :hour,        inclusion: { in: HOURS }
  validates :day_of_week, uniqueness: { scope: [:user_id, :hour] }

  scope :for_user,  ->(user)  { where(user: user) }
  scope :on_day,    ->(day)   { where(day_of_week: day) }
  scope :available,           -> { where(status: :available) }
  scope :flexible,            -> { where(status: :flexible) }

  def self.grid_for(user)
    for_user(user)
      .each_with_object( Hash.new { |h, k| h[k] = {} } ) do |slot, grid|
        grid[slot.day_of_week][slot.hour] = slot.status
      end
  end
end
