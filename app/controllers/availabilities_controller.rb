class AvailabilitiesController < ApplicationController
  before_action :require_authentication

  def show
    @grid = AvailabilitySlot.grid_for(Current.user)
    @days = AvailabilitySlot::DAYS
    @hours = AvailabilitySlot::HOURS
  end

  def toggle
    slot = AvailabilitySlot.find_or_initialize_by(
      user:        Current.user,
      day_of_week: slot_params[:day_of_week].to_i,
      hour:        slot_params[:hour].to_i
    )

    new_status = next_status(slot)

    if new_status.nil?
      slot.destroy
    else
      slot.status = new_status
      slot.save!
    end

    render turbo_stream: turbo_stream.replace(
      cell_id(slot_params[:day_of_week], slot_params[:hour]),
      partial: "availabilities/cell",
      locals: { day: slot_params[:day_of_week].to_i,
                hour: slot_params[:hour].to_i,
                status: new_status }
    )
  end

  private

  def slot_params
    params.permit(:day_of_week, :hour)
  end

  def next_status(slot)
    return "available" unless slot.persisted?
    return "flexible" if slot.available?
    nil
  end

  def cell_id(day, hour)
    "slot-#{day}-#{hour}"
  end
end
