$(document).ready(function() {

  var connection = new WebSocket('ws://localhost:8081', ['soap', 'xmpp']);
  // var connection = new WebSocket('ws://3euu.localtunnel.com', ['soap', 'xmpp']);

  // When the connection is open, send some data to the server
  connection.onopen = function () {
    connection.send('Ping'); // Send the message 'Ping' to the server
  };

  // Log errors
  connection.onerror = function (error) {
    console.log('WebSocket Error ' + error);
  };

  // Log messages from the server
  connection.onmessage = function (e) {
    console.log('Server: ' + e.data);
    $("<p>" + e.data + "</p>").appendTo("body");
  };

  // ping the server every 5 seconds
  // with the hope that it will respond
  // with something fresh
  setInterval(function() {
    console.log("Pinging server...");
    connection.send("New text?");
  }, 5000);

});