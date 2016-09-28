import "phoenix_html"
// jquery is defined globally in brunch-config.js
// import $ from "jquery"
import Conversation from "./conversation"
import { throttle } from "./throttle"
import uuid from "node-uuid"

let my_uuid = uuid.v1()
var conversation

$.get("/create_channel", {my_uuid: my_uuid})
  .done((data) => {
    let channel_id = data["channel_id"]
    conversation = Conversation.init(channel_id)
  })
  .fail(() => {
    show_error("Can't connect to the server.")
  })

function show_error(e) {
  $("#output").text(e)
}

$('input[type=text]').on('keydown', (e) => {
  if (e.which == 13) {
    e.preventDefault()
    compute_xpath()    
  }
})

$('input[type=text]').keyup(throttle( () => {
  compute_xpath()
}, 800))

$('#run').on("click", compute_xpath)

function compute_xpath() {
  $("#output").show()
  conversation.channel.push("compute_xpath", 
  {
    xpath: $("#xpath").val(), 
    xpath_modifiers: $("#xpath_modifiers").val(),
    xml: $("#xml").val()
  })
    .receive("error", e => show_error("Can't connect to the server: #{e}") )
    // .receive("ok", resp => { console.log("Got response", resp) })
}

$("#example").on("click", fill_in_example)

$('#output').hide()

function fill_in_example() {
  $("#xml").val(`<?xml version="1.0" encoding="UTF-8"?>

<bookstore>

<book>
  <title lang="en">Harry Potter</title>
  <price>29.99</price>
</book>

<book>
  <title lang="en">Learning XML</title>
  <price>39.95</price>
</book>

</bookstore>`)

  $("#xpath").val("/bookstore/book/title/text()")
  $("#xpath_modifiers").val("l")
  $("#welcome").hide()
  compute_xpath()
}

// $('#xpath').focus()

