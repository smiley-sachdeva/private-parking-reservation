class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show cancel ]

  # GET /reservations or /reservations.json
  def index
    @reservations = current_user.reservations
  end

  # GET /reservations/1 or /reservations/1.json
  def show
  end

  # POST /reservations or /reservations.json
  def create
    slot = Slot.find(reservation_params[:slot_id]) 

    service = ReservationService.new(current_user, slot)
    result = service.reserve_parking_slot(reservation_params[:from], 
                                          reservation_params[:to], 
                                          reservation_params[:plate_number])

                                  
    respond_to do |format|
      if result[:success]
        @reservation =  result[:reservation]
       format.json { render :show, status: :created, location: result[:reservation] }
      else
        format.json { render json: {error: result[:message]}, status: :unprocessable_entity }
      end
    end
  end 

  def cancel
    service = ReservationService.new(current_user, @reservation.slot)
    result = service.cancel_reservation(@reservation)
    if result[:success]
      render json: { message: result[:message], reservation: result[:reservation] }, status: :ok
    else
      render json: { error: result[:message] }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:from, :to, :slot_id, :plate_number)
    end
end
