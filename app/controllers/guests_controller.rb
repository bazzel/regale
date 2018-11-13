class GuestsController < ApplicationController
  before_action :set_guest, only: [:update]

  # PATCH/PUT /guests/1
  # PATCH/PUT /guests/1.json
  def update
    respond_to do |format|
      if @guest.update(guest_params)
        notice = 'Guest was successfully updated.'
        format.html { redirect_to @guest, notice: notice }
        format.js { flash.now[:notice] = notice }
        format.json { render :show, status: :ok, location: @guest }
      else
        format.html { render :edit }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guest
      @guest = Guest.find(params[:id]).decorate
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guest_params
      params.require(:guest).permit(:accept_status, :soup_id, :appetizer_id, :main_course_id, :dessert_id)
    end
end

