require_relative '../policies/cancel_policy.rb'
class ReservationService
    # include Policies::CancelPolicy

    attr_accessor :customer, :slot

    def initialize(customer, slot)
      @customer = customer
      @slot = slot
    end

    def reserve_parking_slot(from, to, plate_number)
      return error("Slot is already #{slot.status}") unless slot.status == "available"
      
      total_hours = calculate_hours(from, to)
      total_amount = calculate_price(total_hours)

      reservation = customer.reservations.new(reservation_params(
                                                total_amount, 
                                                total_hours,
                                                plate_number, 
                                                from, 
                                                to)
                                              )
      if reservation.save
        slot.update(status: "booked")
        success(reservation: reservation, message: "The parking slot reservation has been successfully completed.")
      else
        error(reservation.errors.full_messages.join(", "))
      end
    end

    def cancel_reservation(reservation)
      cancellation_policy = Policies::CancelPolicy.new(reservation)
      if cancellation_policy.allow_cancel?
        if charge_for_cancellation(reservation, cancellation_policy.cancellation_charge)
          success(reservation: reservation, message: 'Slot reservation has been successfully cancelled')
        else
          error(message: reservation.errors.full_messages.join(''))
        end
      else
       error(message: 'Cancellation is not allowed for this slot.')
      end
    end

    private
    def calculate_hours(from, to)
      (DateTime.parse(to).to_i - DateTime.parse(from).to_i)/1.hour
    end

    def calculate_price(total_hours)
      total_hours * slot.price
    end 

    def charge_for_cancellation(reservation, charge)
      byebug
      reservation.update(cancelled_at: Time.now, cancellation_amount: charge)
    end

    def success(reservation:, message:)
      { success: true, message: , reservation: }
    end

    def error(message)
      { success: false, message: }
    end

    def reservation_params(total_amount, total_hours, plate_number, from, to)
      {
        slot: slot,
        total_amount: total_amount,
        plate_number: plate_number,
        from: from,
        to: to
      }
    end
end
