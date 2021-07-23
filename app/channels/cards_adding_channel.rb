class CardsAddingChannel < ApplicationCable::Channel
  def subscribed
    stream_from "cards_adding"
  end
end