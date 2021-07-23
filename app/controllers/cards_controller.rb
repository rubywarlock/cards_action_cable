class CardsController < ApplicationController
  before_action :set_card, only: %i[ show edit update destroy ]

  include CardsQuestsConcern

  def index
    @cards = Card.all
  end

  def show
  end

  def new
    @card = Card.new
    @words_pair = @card.build_words_pair
  end

  def edit
    @words_pair = @card.words_pair
  end

  def create
    @card = Card.new(card_params)

    @card.wrongs_count = 0
    @card.level = Card.levels.first[0]

    respond_to do |format|
      if @card.save
        format.html { redirect_to @card, notice: "Card was successfully created." }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to @card, notice: "Card was successfully updated." }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    CardsJob.perform_later('destroy', @card.id)

    @card.destroy

    respond_to do |format|
      format.html { redirect_to cards_url, notice: "Card was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(words_pair_attributes: [:original_text, :translate])
  end
end
