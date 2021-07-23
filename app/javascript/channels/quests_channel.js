import consumer from "./consumer"

consumer.subscriptions.create({ channel: "QuestsChannel" }, {
  received(data) {
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