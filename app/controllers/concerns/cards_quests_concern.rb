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

      CardsJob.perform_later('destroy', @card.id)

      result = apply_params[:result_status] == "1" ? true : false

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

        time_duration = @card.to_time_duration

        if !time_duration.blank?
          next_time = DateTime.current + time_duration

          @card.next_time = next_time
          @card.save

          CardsJob.set(wait: time_duration).perform_later('show_card_by_time', @card)
        end
      end

    end

    private

    def cards_list
      @cards = Card.where("(level = ? OR next_time <= ?) AND level <> ?", "always", DateTime.current, "never").map do |card|
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