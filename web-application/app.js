//#########################imports##########################################
var express = require('express');
var http = require('http');
var io = require('socket.io');
var fs = require('fs');


//#########################variables##########################################
var scenarioFactors = JSON.parse(fs.readFileSync('./data/ScenarioFactors.json', 'utf8'));
var cityDiagram = JSON.parse(fs.readFileSync('./data/Diagrams.json', 'utf8'));
var newScenarioFactors = scenarioFactors;

var votingFramer ={
    "hightech": "-",
    "virtual":"-",
    "regional":"-",
    "fortress":"-"
  };

var dataToFramer ={
  "diagram":{
    "Arbeit":{
      "society": 0,
      "politics": 0,
      "economy": 0
    },
    "Umwelt":{
      "society": 0,
      "politics": 0,
      "economy": 0
    },
    "Bildung":{
      "society": 0,
      "politics": 0,
      "economy": 0
    },
    "sozialG":{
      "society": 0,
      "politics": 0,
      "economy": 0
    },
    "Wohnen":{
      "society": 0,
      "politics": 0,
      "economy": 0
    }
  },
  "elements": ""
};

//#########################Server Setup#########################################
var app = express();
app.use(express.static('./Scenarios.framer'));
//Specifying the public folder of the server to make the html accesible using the static middleware
var server =http.createServer(app).listen(3000);
//Server listens on the port 3000
io = io.listen(server);
/*initializing the websockets communication , server instance has to be sent as the argument */


//#########################functions#########################################
// function calcDiagram(){
//   dataToFramer.diagram.Arbeit = CityDiagram.fortress.Arbeit * scenarioFactors.fortress.votingAverage +
// }



//#########################socketServer#########################################
io.sockets.on("connection",function(socket){
  /*Associating the callback function to be executed when client visits the page and
      websocket connection is made */

      var message_to_client = {
        "message":"Connected with server"
      };
      socket.send(JSON.stringify(message_to_client));
      /*sending data to the client , this triggers a message event at the client side */
    console.log('Connection established. Find page under http://localhost:3000/');
    socket.on("message",function(data){
        /*This event is triggered at the server side when client sends the data using socket.send() method */
        data = JSON.parse(data);

        //calculates the newScenarioFactors
        if(data.scenario === "hightech"){
        votingFramer.hightech = data.votingAmount;
        if(votingFramer.hightech !== "-"){
          newScenarioFactors.hightech.votingAverage = (votingFramer.hightech + scenarioFactors.hightech.votingAverage * scenarioFactors.hightech.votingAmount)/(scenarioFactors.hightech.votingAmount+1);
          }
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
        //scenario Kollektiv (updates the file)
        if(data.scenario === "null"){
        //checking for changes in objects and updates Scenariofactors
          if(votingFramer.hightech !== "-"){
            scenarioFactors.hightech.votingAverage = newScenarioFactors.hightech.votingAverage;
            scenarioFactors.hightech.votingAmount++;
            votingFramer.hightech = "-";
          }
          if(votingFramer.virtual !== "-"){
            scenarioFactors.virtual.votingAverage = newScenarioFactors.virtual.votingAverage;
            scenarioFactors.virtual.votingAmount++;
            votingFramer.virtual = "-";
          }
          if(votingFramer.regional !== "-"){
            scenarioFactors.regional.votingAverage = newScenarioFactors.regional.votingAverage;
            scenarioFactors.regional.votingAmount++;
            votingFramer.regional = "-";
          }
          if(votingFramer.fortress !== "-"){
            scenarioFactors.fortress.votingAverage = newScenarioFactors.fortress.votingAverage;
            scenarioFactors.fortress.votingAmount++;
            votingFramer.fortress = "-";
          }
          //save the updates scenarioFactors to json
          fs.writeFile('./data/ScenarioFactors.json', JSON.stringify(scenarioFactors), (err) => {
            if (err) throw err;
              console.log('It\'s saved!');
          });

        }

        /*Printing the data from client*/
        var back_to_client = {
        "message":"Data Received by server.js!"
      };
      socket.send(JSON.stringify(back_to_client));
        /*Sending the Acknowledgement back to the client , this will trigger "message" event on the clients side*/
    });

});
