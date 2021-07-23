import consumer from "./consumer"

consumer.subscriptions.create({ channel: "ResultsChannel" }, {
  received(data) {
    console.log(data)

    const element = document.getElementById('translate-text-id-' + data['card_id'])
    const check_box = document.getElementById('card_result_status')

    element.textContent = data['translate_text']

    if(data['result'] == "false") {
      check_box.checked == false
    } else {
      check_box.checked == true
    }

  }
})