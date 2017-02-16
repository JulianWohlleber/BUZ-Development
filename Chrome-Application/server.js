var express = require('express');
var http = require('http');
var io = require('socket.io');
var fs = require('fs');
var scenarioFactors = require('./data/ScenarioFactors.json');

//#########################variables##########################################

var votingFramer ={
    "hightech": "-",
    "virtual":"-",
    "regional":"-",
    "fortress":"-"
  };

//#########################Server Setup#########################################
var app = express();
app.use(express.static('./Scenarios.framer'));
//Specifying the public folder of the server to make the html accesible using the static middleware
var server =http.createServer(app).listen(3000);
//Server listens on the port 3000
io = io.listen(server);
/*initializing the websockets communication , server instance has to be sent as the argument */
io.sockets.on("connection",function(socket){
  /*Associating the callback function to be executed when client visits the page and
      websocket connection is made */

      var message_to_client = {
        "message":"Connected with server"
      };
      socket.send(JSON.stringify(message_to_client));
      /*sending data to the client , this triggers a message event at the client side */
    //console.log('Connection established. Find page under http://localhost:3000/');
    socket.on("message",function(data){
        /*This event is triggered at the server side when client sends the data using socket.send() method */
        data = JSON.parse(data);

        if(data.scenario === "hightech"){
        votingFramer.hightech = data.votingAmount;
        }
        if(data.scenario === "virtual"){
        votingFramer.virtual = data.votingAmount;
        }
        if(data.scenario === "liveable"){
        votingFramer.liveable = data.votingAmount;
        }
        if(data.scenario === "fortress"){
        votingFramer.fortress = data.votingAmount;
        }
        if(data.scenario === "null"){
        //calculate averages of all four
          if(votingFramer.hightech !== "-"){
            scenarioFactors.hightech.votingAverage = (votingFramer.hightech + scenarioFactors.hightech.votingAverage * scenarioFactors.hightech.votingAmount)/(scenarioFactors.hightech.votingAmount+1);
            scenarioFactors.hightech.votingAmount++;
            votingFramer.hightech = "-";
            console.log(scenarioFactors.hightech);
        //add votings value
        //reset votings value
          }
        }

        /*Printing the data from client*/
        var back_to_client = {
        "message":"Data Received by server.js!"
      };
      socket.send(JSON.stringify(back_to_client));
        /*Sending the Acknowledgement back to the client , this will trigger "message" event on the clients side*/
    });

});
