class ResultsJob < ApplicationJob
  #include CableReady::Broadcaster
  queue_as :default

  def perform(card_id, translate, result)
    ActionCable.server.broadcast('results', { card_id: card_id, translate_text: translate, result: result  })
  end
end