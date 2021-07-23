class CardsRemovingChannel < ApplicationCable::Channel
  def subscribed
    stream_from "cards_removing"
  end
end