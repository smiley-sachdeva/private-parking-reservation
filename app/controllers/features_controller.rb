class FeaturesController < ApplicationController
  before_action :set_feature, only: %i[ show update destroy ]

  # GET /features or /features.json
  def index
    @features = Feature.all
  end

  # GET /features/1 or /features/1.json
  def show
  end

  # POST /features or /features.json
  def create
    @feature = Feature.new(feature_params)

    respond_to do |format|
      if @feature.save
        format.json { render :show, status: :created, location: @feature }
      else
        format.json { render json: @feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /features/1 or /features/1.json
  def update
    respond_to do |format|
      if @feature.update(feature_params)
        format.json { render :show, status: :ok, location: @feature }
      else
        format.json { render json: @feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /features/1 or /features/1.json
  def destroy
    @feature.destroy!

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feature
      @feature = Feature.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def feature_params
      params.require(:feature).permit(:name)
    end
end
