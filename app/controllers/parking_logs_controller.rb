class ParkingLogsController < ApplicationController
  before_action :set_reservation, only: %i[ create ]
  before_action :set_slot, only: %i[ index create show checkout ]
  before_action :set_parking_log_by_id, only: %i[ show ]
  before_action :set_parking_log_by_token, only: %i[ checkout ]

  # GET /parking_logs or /parking_logs.json
  def index
    @parking_logs = @slot.parking_logs
  end

  # GET /parking_logs/1 or /parking_logs/1.json
  def show
  end
  
  # POST /parking_logs or /parking_logs.json
  def create
    service = ParkingActionsService.new(@slot, @reservation, parking_log_params)
    result = service.checkin
  
    respond_to do |format|
      if result[:success]
        @parking_log =  result[:parking_log]
       format.json { render :show, status: :created }
      else
        format.json { render json: {error: result[:message]}, status: :unprocessable_entity }
      end
    end
  end

  def checkout
    service = ParkingActionsService.new(@slot, @parking_log.reservation, parking_log_params)
    result = service.checkout(@parking_log)

    respond_to do |format|
      if result[:success]
        @parking_log =  result[:parking_log]
       format.json { render :show, status: :created }
      else
        format.json { render json: {error: result[:message]}, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_reservation
      @reservation = Reservation.find(parking_log_params[:reservation_id])
    end

    def set_slot
      @slot = Slot.find(params[:slot_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_parking_log_by_id
      @parking_log = ParkingLog.find(params[:id])
    end

    def set_parking_log_by_token
      @parking_log = ParkingLog.find_by(ref_token: parking_log_params[:ref_token])
    end

    # Only allow a list of trusted parameters through.
    def parking_log_params
      params.require(:parking_log).permit(:checkin_time, :checkout_time, :duration, :price, :plate_number, :ref_token, :reservation_id)
    end
end
