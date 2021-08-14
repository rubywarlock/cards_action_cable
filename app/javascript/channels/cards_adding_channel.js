import consumer from "./consumer"

consumer.subscriptions.create({ channel: "CardsAddingChannel" }, {
  received(data) {
    console.log('CardsAddingChannel: ' + data)

    this.appendRow(data)
  },

  appendRow(data) {
    const html = this.createRow(data)
    const element = document.getElementById("card-list")

    element.prepend(html)
  },

  createRow(data) {
    var card_block = document.createElement('div')

    card_block.className = 'card-block'
    card_block.id = 'card-id-' + data['card_id']
    card_block.innerHTML = data['card']

    return card_block
  }
})
