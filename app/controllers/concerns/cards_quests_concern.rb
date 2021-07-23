module CardsQuestsConcern
  extend ActiveSupport::Concern

  included do
    def results
      @card = Card.find(check_params[:card_id])

      try_word = check_params[:variant]

      result = "#{(try_word == @card.words_pair.translate)}"
      translate_text = @card.words_pair.translate

      ResultsJob.perform_later(@card.id, translate_text, result)
    end

    def quests
      @cards = cards_list
    end

    def apply
      @card = Card.find(apply_params[:card_id])

      result = apply_params[:result_status]

      if result == true
        @card.up
      else
        @card.wrongs_count += 1
        @card.drop

        if @card.wrongs_count == 10
          @card.never
        end
      end

      if !@card.never?
        time_interval = Card.levels[@card.level].scan(/\d{1,2}\w{1,3}/).first

        if !time_interval.blank?
          time = time_interval[0]
          unit = @card.to_time_unit(time_interval[1])
        end

        CardsJob.perform_later('destroy', @card.id)
        CardsJob.set(wait: eval("#{time}.#{unit}")).perform_later('show_card_by_time', @card)
      end

    end

    private

    def cards_list
      @cards = Card.where(level: "always").map do |card|
        card
      end
    end

    def check_params
      params.require(:card).permit(:card_id, :variant)
    end

    def apply_params
      params.require(:card).permit(:card_id, :result_status)
    end
  end

end