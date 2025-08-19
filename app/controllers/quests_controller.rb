class QuestsController < ApplicationController
  before_action :set_quest, only: %i[ update destroy toggle ]

  def index
    @quests = Quest.all.order(created_at: :desc)
    @quest = Quest.new
  end

  def create
    @quest = Quest.new(quest_params)

    respond_to do |format|
      if @quest.save
        format.turbo_stream
        format.html { redirect_to quests_url, notice: "Quest was successfully created." }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@quest, partial: "quests/form", locals: { quest: @quest }), status: :unprocessable_content }
        format.html { render :index, status: :unprocessable_content }
      end
    end
  end

  def update
    respond_to do |format|
      if @quest.update(quest_params)
        format.turbo_stream
        format.html { redirect_to quests_url, notice: "Quest was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @quest.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@quest) }
      format.html { redirect_to quests_url, notice: "Quest was successfully destroyed." }
    end
  end

  def toggle
    @quest.update(status: !@quest.status)

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace(@quest) }
      format.html { redirect_to quests_url }
    end
  end

  private

  def set_quest
    @quest = Quest.find(params[:id])
  end

  def quest_params
    params.require(:quest).permit(:name, :status)
  end
end
