module Policies
  class CancelPolicy
    attr_reader :reservation
  
    def initialize(reservation)
      @reservation = reservation
    end
  
    def allow_cancel?
      # Check if cancellation is allowed based on your policy
      # For example, you might allow cancellation up to 24 hours before the start time
      @reservation.from > Time.now + 24.hours
    end
  
    def cancellation_charge
      # Determine the cancellation charge based on the elapsed time since reservation creation
      elapsed_time = Time.now - @reservation.created_at
      case
      when elapsed_time <= 1.hour
        0 # No charge within first hour
      when elapsed_time <= 6.hours
        50 # Charge AED 50 if less than or equal to 6 hours
      when elapsed_time <= 12.hours
        100 # Charge AED 100 if less than or equal to 12 hours
      else
        400 # Charge AED 400 for any other time
      end
    end
  end
end
