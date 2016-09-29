import {Socket} from "phoenix"
// import $ from "jquery"

let Conversation = {
  channel: null,
  init(channel_name){
    let socket = new Socket("/elph/socket", {params: {token: window.userToken}})
    socket.connect()

    let ch = socket.channel(channel_name, {})
    ch.join()
      // .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) })
    
    ch.on("compute_xpath_response", (resp) => {
      $("#output").text(resp["output"])
    })

    this.channel = ch
    return this
  }
}

export default Conversation
