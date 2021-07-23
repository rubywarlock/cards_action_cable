class QuestsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "quests"
  end
end