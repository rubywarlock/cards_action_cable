import consumer from "./consumer"

consumer.subscriptions.create({ channel: "CardsAddingChannel" }, {
  received(data) {
    console.log('CardsAddingChannel: ' + data)

    this.appendRow(data)
  },

  appendRow(data) {
    const html = this.createRow(data['card'])
    const element = document.getElementById("card-list")

    element.prepend(html)
  },

  createRow(data) {
    var dom = document.createElement('div')

    dom.innerHTML = data

    return dom
  }
})
