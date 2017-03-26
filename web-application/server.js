//#########################imports##########################################
var express = require('express');
var http = require('http');
var io = require('socket.io');
var fs = require('fs');


//#########################variables##########################################
var scenarioFactors = JSON.parse(fs.readFileSync('./data/ScenarioFactors.json', 'utf8'));
var cityDiagram = JSON.parse(fs.readFileSync('./data/Diagrams.json', 'utf8'));
var newScenarioFactors = JSON.parse(JSON.stringify(scenarioFactors));

var votingFramer ={
    "hightech": "-",
    "virtual":"-",
    "regional":"-",
    "fortress":"-"
  };

var dataToFramer ={
  "diagram":{
    "Arbeit":{
      "Gesellschaft": 0,
      "Politik": 0,
      "Wirtschaft": 0,
      "all": 0
    },
    "Umwelt":{
      "Gesellschaft": 0,
      "Politik": 0,
      "Wirtschaft": 0,
      "all": 0
    },
    "Bildung":{
      "Gesellschaft": 0,
      "Politik": 0,
      "Wirtschaft": 0,
      "all": 0
    },
    "sozialG":{
      "Gesellschaft": 0,
      "Politik": 0,
      "Wirtschaft": 0,
      "all": 0
    },
    "Wohnen":{
      "Gesellschaft": 0,
      "Politik": 0,
      "Wirtschaft": 0,
      "all": 0
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
function calcDiagram(){
  hightechFactor = newScenarioFactors.hightech.votingAverage;
  virtualFactor = newScenarioFactors.virtual.votingAverage;
  regionalFactor = newScenarioFactors.regional.votingAverage;
  fortressFactor = newScenarioFactors.fortress.votingAverage;
  factorSum = hightechFactor + virtualFactor+regionalFactor+fortressFactor;
  if(factorSum === 0){
    factorSum = 1;
  }
  //Arbeit
  dataToFramer.diagram.Arbeit.Gesellschaft = (cityDiagram.hightech.Arbeit.Gesellschaft * hightechFactor + cityDiagram.virtual.Arbeit.Gesellschaft * virtualFactor + cityDiagram.regional.Arbeit.Gesellschaft * regionalFactor + cityDiagram.fortress.Arbeit.Gesellschaft * fortressFactor)/factorSum;
  dataToFramer.diagram.Arbeit.Politik = (cityDiagram.hightech.Arbeit.Politik * hightechFactor + cityDiagram.virtual.Arbeit.Politik * virtualFactor + cityDiagram.regional.Arbeit.Politik * regionalFactor + cityDiagram.fortress.Arbeit.Politik * fortressFactor)/factorSum;
  dataToFramer.diagram.Arbeit.Wirtschaft = (cityDiagram.hightech.Arbeit.Wirtschaft * hightechFactor + cityDiagram.virtual.Arbeit.Wirtschaft * virtualFactor + cityDiagram.regional.Arbeit.Wirtschaft * regionalFactor + cityDiagram.fortress.Arbeit.Wirtschaft * fortressFactor)/factorSum;
  dataToFramer.diagram.Arbeit.all = (dataToFramer.diagram.Arbeit.Gesellschaft+dataToFramer.diagram.Arbeit.Politik+dataToFramer.diagram.Arbeit.Wirtschaft)/3;
  //Umwelt
  dataToFramer.diagram.Umwelt.Gesellschaft = (cityDiagram.hightech.Umwelt.Gesellschaft * hightechFactor + cityDiagram.virtual.Umwelt.Gesellschaft * virtualFactor + cityDiagram.regional.Umwelt.Gesellschaft * regionalFactor + cityDiagram.fortress.Umwelt.Gesellschaft * fortressFactor)/factorSum;
  dataToFramer.diagram.Umwelt.Politik = (cityDiagram.hightech.Umwelt.Politik * hightechFactor + cityDiagram.virtual.Umwelt.Politik * virtualFactor + cityDiagram.regional.Umwelt.Politik * regionalFactor + cityDiagram.fortress.Umwelt.Politik * fortressFactor)/factorSum;
  dataToFramer.diagram.Umwelt.Wirtschaft = (cityDiagram.hightech.Umwelt.Wirtschaft * hightechFactor + cityDiagram.virtual.Umwelt.Wirtschaft * virtualFactor + cityDiagram.regional.Umwelt.Wirtschaft * regionalFactor + cityDiagram.fortress.Umwelt.Wirtschaft * fortressFactor)/factorSum;
  dataToFramer.diagram.Umwelt.all = (dataToFramer.diagram.Umwelt.Gesellschaft+dataToFramer.diagram.Umwelt.Politik+dataToFramer.diagram.Umwelt.Wirtschaft)/3;
  //Bildung
  dataToFramer.diagram.Bildung.Gesellschaft = (cityDiagram.hightech.Bildung.Gesellschaft * hightechFactor + cityDiagram.virtual.Bildung.Gesellschaft * virtualFactor + cityDiagram.regional.Bildung.Gesellschaft * regionalFactor + cityDiagram.fortress.Bildung.Gesellschaft * fortressFactor)/factorSum;
  dataToFramer.diagram.Bildung.Politik = (cityDiagram.hightech.Bildung.Politik * hightechFactor + cityDiagram.virtual.Bildung.Politik * virtualFactor + cityDiagram.regional.Bildung.Politik * regionalFactor + cityDiagram.fortress.Bildung.Politik * fortressFactor)/factorSum;
  dataToFramer.diagram.Bildung.Wirtschaft = (cityDiagram.hightech.Bildung.Wirtschaft * hightechFactor + cityDiagram.virtual.Bildung.Wirtschaft * virtualFactor + cityDiagram.regional.Bildung.Wirtschaft * regionalFactor + cityDiagram.fortress.Bildung.Wirtschaft * fortressFactor)/factorSum;
  dataToFramer.diagram.Bildung.all = (dataToFramer.diagram.Bildung.Gesellschaft+dataToFramer.diagram.Bildung.Politik+dataToFramer.diagram.Bildung.Wirtschaft)/3;
  //sozialG
  dataToFramer.diagram.sozialG.Gesellschaft = (cityDiagram.hightech.sozialG.Gesellschaft * hightechFactor + cityDiagram.virtual.sozialG.Gesellschaft * virtualFactor + cityDiagram.regional.sozialG.Gesellschaft * regionalFactor + cityDiagram.fortress.sozialG.Gesellschaft * fortressFactor)/factorSum;
  dataToFramer.diagram.sozialG.Politik = (cityDiagram.hightech.sozialG.Politik * hightechFactor + cityDiagram.virtual.sozialG.Politik * virtualFactor + cityDiagram.regional.sozialG.Politik * regionalFactor + cityDiagram.fortress.sozialG.Politik * fortressFactor)/factorSum;
  dataToFramer.diagram.sozialG.Wirtschaft = (cityDiagram.hightech.sozialG.Wirtschaft * hightechFactor + cityDiagram.virtual.sozialG.Wirtschaft * virtualFactor + cityDiagram.regional.sozialG.Wirtschaft * regionalFactor + cityDiagram.fortress.sozialG.Wirtschaft * fortressFactor)/factorSum;
  dataToFramer.diagram.sozialG.all = (dataToFramer.diagram.sozialG.Gesellschaft+dataToFramer.diagram.sozialG.Politik+dataToFramer.diagram.sozialG.Wirtschaft)/3;
  //Wohnen
  dataToFramer.diagram.Wohnen.Gesellschaft = (cityDiagram.hightech.Wohnen.Gesellschaft * hightechFactor + cityDiagram.virtual.Wohnen.Gesellschaft * virtualFactor + cityDiagram.regional.Wohnen.Gesellschaft * regionalFactor + cityDiagram.fortress.Wohnen.Gesellschaft * fortressFactor)/factorSum;
  dataToFramer.diagram.Wohnen.Politik = (cityDiagram.hightech.Wohnen.Politik * hightechFactor + cityDiagram.virtual.Wohnen.Politik * virtualFactor + cityDiagram.regional.Wohnen.Politik * regionalFactor + cityDiagram.fortress.Wohnen.Politik * fortressFactor)/factorSum;
  dataToFramer.diagram.Wohnen.Wirtschaft = (cityDiagram.hightech.Wohnen.Wirtschaft * hightechFactor + cityDiagram.virtual.Wohnen.Wirtschaft * virtualFactor + cityDiagram.regional.Wohnen.Wirtschaft * regionalFactor + cityDiagram.fortress.Wohnen.Wirtschaft * fortressFactor)/factorSum;
  dataToFramer.diagram.Wohnen.all = (dataToFramer.diagram.Wohnen.Gesellschaft+dataToFramer.diagram.Wohnen.Politik+dataToFramer.diagram.Wohnen.Wirtschaft)/3;

console.log(factorSum);
}


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
        if(votingFramer.virtual !== "-"){
          newScenarioFactors.virtual.votingAverage = (votingFramer.virtual + scenarioFactors.virtual.votingAverage * scenarioFactors.virtual.votingAmount)/(scenarioFactors.virtual.votingAmount+1);
          }
        }

        if(data.scenario === "regional"){
        votingFramer.regional = data.votingAmount;
        if(votingFramer.regional !== "-"){
          newScenarioFactors.regional.votingAverage = (votingFramer.regional + scenarioFactors.regional.votingAverage * scenarioFactors.regional.votingAmount)/(scenarioFactors.regional.votingAmount+1);
          }
        }

        if(data.scenario === "fortress"){
        votingFramer.fortress = data.votingAmount;
        if(votingFramer.fortress !== "-"){
          newScenarioFactors.fortress.votingAverage = (votingFramer.fortress + scenarioFactors.fortress.votingAverage * scenarioFactors.fortress.votingAmount)/(scenarioFactors.fortress.votingAmount+1);
          }
        }

        calcDiagram();



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
      socket.send(JSON.stringify(dataToFramer));
        /*Sending the Acknowledgement back to the client , this will trigger "message" event on the clients side*/
    });

});
