class ParkingActionsService
    attr_accessor :slot, :reservation, :params

    def initialize(slot, reservation, params)
        @slot = slot
        @reservation = reservation
        @params = params
    end

    def checkin
        if slot.status == "booked"
            error("Slot is not available")
        else
            parking_log = slot.parking_logs.new(
                                    checkin_time: Time.now,
                                    plate_number: params[:plate_number],
                                    reservation: reservation,
                                    ref_token: ref_token)   

            if parking_log.save
                success(parking_log: parking_log, message: 'Checked In successfully')
            else
                error(message: parking_log.errors.full_messages.join(''))
            end
        end      
    end

    def checkout(parking_log)
        return error("You already checked out.") if parking_log.checkout_time.present?
        if parking_log.update(
                duration: duration(parking_log), 
                price: reservation.total_amount, 
                checkout_time: Time.now)

            parking_log.slot.update(status: 'available')
            success(parking_log: parking_log, message: 'Checked Out successfully')
        else
            error(message: parking_log.errors.full_messages.join(''))
        end
    end

    private
    def ref_token
        SecureRandom.hex(3)
    end
      
    def duration(log)
        Time.now.to_i - log.checkin_time.to_i
    end

    def success(parking_log:, message:)
        { success: true, message: , parking_log: }
    end
  
    def error(message)
        { success: false, message: }
    end
end