class AwardsController < ApplicationController
  before_action :set_award, only: [:edit, :update, :destroy]
  before_action  :set_giver_and_given_id, only: [:confirm, :create]
  # GET /awards
  # GET /awards.json
  def index
    @users = User.all
  end

  # GET /awards/1
  # GET /awards/1.json
  def show
    @award = Award.find(params[:id])
  end

  # GET /awards/new
  def new
    @award = Award.new
    @award.given_id = params[:given_id]
    #binding.pry
  end

  def confirm
    @award = Award.new(award_params)
    @award.make_award_img(@giver_id, @given_id)
    render :new if @award.invalid?
  end

  # GET /awards/1/edit
  def edit
  end

  # POST /awards
  # POST /awards.json
  def create
    begin
      @award = Award.new(award_params)
      respond_to do |format|
        if params[:back]
          format.html { render :new }
        else
          @award.create_with_upload!(@giver_id, @given_id)
          format.html { redirect_to @award, notice: 'Award was successfully created.' }
          format.json { render :show, status: :created, location: @award }
        end
      end
    rescue Aws::S3::MultipartUploadError => e
      flash.now[:notice] = '社外システムとの連携に失敗しました。時間を置いてもう一度お試しください。'
      render :new
    end
  end
  # PATCH/PUT /awards/1
  # PATCH/PUT /awards/1.json
  def update
    respond_to do |format|
      if @award.update(award_params)
        format.html { redirect_to @award, notice: 'Award was successfully updated.' }
        format.json { render :show, status: :ok, location: @award }
      else
        format.html { render :edit }
        format.json { render json: @award.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /awards/1
  # DELETE /awards/1.json
  def destroy
    @award.destroy
    respond_to do |format|
      format.html { redirect_to awards_url, notice: 'Award was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_award
      @award = Award.find(params[:id])
    end

    def set_giver_and_given_id
      @giver_id = params[:award][:giver_id]
      @given_id = params[:award][:given_id]
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def award_params
      params.require(:award).permit(:contents, :day, :giver_id, :given_id)
    end
end
