import consumer from "./consumer"

consumer.subscriptions.create({ channel: "CardsRemovingChannel" }, {
  received(data) {
    console.log('CardsRemovingChannel: ' + data['card_id'])


    this.removeRow(data)
  },

  removeRow(data) {
    const element = document.getElementById('card-id-' + data['card_id'])
    element.remove()
  }
})