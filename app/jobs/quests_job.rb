class QuestsJob < ApplicationJob
  queue_as :default

  def perform(card_id, result)
    ActionCable.server.broadcast 'quests', { body: card_processing(card_id, result) }
  end

  private

  def card_processing(card_id, result)
    card_id
  end

end