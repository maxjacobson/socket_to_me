$(document).ready(function() {

  var connection = new WebSocket('ws://localhost:8081', ['soap', 'xmpp']);
  // var connection = new WebSocket('ws://4p2h.localtunnel.com', ['soap', 'xmpp']);

  // When the connection is open, send some data to the server
  connection.onopen = function () {
    connection.send('Ping'); // Send the message 'Ping' to the server
  };

  // Log errors
  connection.onerror = function (error) {
    console.log('WebSocket Error ' + error);
  };

  // Log messages from the server
  connection.onmessage = function (response) {
    console.log('Server: ' + response.data);
    if($(".sms_list li:first").text() === response.data) {
      console.log("already seen it");
    } else {
      $("<li>" + response.data + "</li>").prependTo(".sms_list");
    }
    
  };

  // ping the server every 5 seconds
  // with the hope that it will respond
  // with something fresh
  setInterval(function() {
    console.log("Pinging server...");
    connection.send("New text?");
  }, 5000);

});