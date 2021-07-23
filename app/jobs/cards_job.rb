class CardsJob < ApplicationJob
  queue_as :default

  def perform(action, card = nil)
    if action == "add"
      add_card_row(card)
    end

    if action == "destroy"
      remove_card_row(card)
    end

    if action == "show_card_by_time"
      add_card_row(card)
    end
  end

  def remove_card_row(card_id)
    ActionCable.server.broadcast "cards_removing", { card_id: card_id }
  end

  def add_card_row(card)
    ActionCable.server.broadcast "cards_adding", { card: render_card(card) }
  end

  private

  def render_card(card)
    CardsController.render(partial: 'card', locals: { card: card })
  end
end
