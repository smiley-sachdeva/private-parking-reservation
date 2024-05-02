class FeaturesController < ApplicationController
  before_action :set_parking, only: %i[ index create ]
  before_action :set_feature, only: %i[ show update destroy ]

  # GET parkings/1/features.json
  def index
    @features = @parking.features
  end

  # GET parkings/1/features/1.json
  def show
  end

  # POST parkings/1/features.json
  def create
    @feature = @parking.features.build(feature_params)

    respond_to do |format|
      if @feature.save
        format.json { render :show, status: :created }
      else
        format.json { render json: @feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT parkings/1/features/1.json
  def update
    respond_to do |format|
      if @feature.update(feature_params)
        format.json { render :show, status: :ok }
      else
        format.json { render json: @feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE parkings/1/features/1.json
  def destroy
    @feature.destroy!

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    def set_parking
      @parking = Parking.find(params[:parking_id])
    end

    def set_feature
      @feature = Feature.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def feature_params
      params.require(:feature).permit(:name)
    end
end
