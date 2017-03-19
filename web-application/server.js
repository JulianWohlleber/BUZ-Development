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
      "economy": 0,
      "all": 0
    },
    "Umwelt":{
      "society": 0,
      "politics": 0,
      "economy": 0,
      "all": 0
    },
    "Bildung":{
      "society": 0,
      "politics": 0,
      "economy": 0,
      "all": 0
    },
    "sozialG":{
      "society": 0,
      "politics": 0,
      "economy": 0,
      "all": 0
    },
    "Wohnen":{
      "society": 0,
      "politics": 0,
      "economy": 0,
      "all": 0
    }
  },
  "elements": ""
};

//#########################Server Setup#########################################
var app = express();
app.use(express.static('./Scenarios.framer'));
//Specifying the public folder of the server to make the html accesible using the static middleware
var server =http.createServer(app).listen(3333);
//Server listens on the port 3333
io = io.listen(server);
/*initializing the websockets communication , server instance has to be sent as the argument */


//#########################functions#########################################
function calcDiagram(){
  hightechFactor = newScenarioFactors.hightech.votingAverage
  virtualFactor = newScenarioFactors.virtual.votingAverage
  regionalFactor = newScenarioFactors.regional.votingAverage
  fortressFactor = newScenarioFactors.fortress.votingAverage

  //Arbeit
  dataToFramer.diagram.Arbeit.society = (cityDiagram.hightech.Arbeit.society * hightechFactor + cityDiagram.virtual.Arbeit.society * virtualFactor + cityDiagram.regional.Arbeit.society * regionalFactor + cityDiagram.fortress.Arbeit.society * fortressFactor)/2
  dataToFramer.diagram.Arbeit.politics = (cityDiagram.hightech.Arbeit.politics * hightechFactor + cityDiagram.virtual.Arbeit.politics * virtualFactor + cityDiagram.regional.Arbeit.politics * regionalFactor + cityDiagram.fortress.Arbeit.politics * fortressFactor)/2
  dataToFramer.diagram.Arbeit.economy = (cityDiagram.hightech.Arbeit.economy * hightechFactor + cityDiagram.virtual.Arbeit.economy * virtualFactor + cityDiagram.regional.Arbeit.economy * regionalFactor + cityDiagram.fortress.Arbeit.economy * fortressFactor)/2
  dataToFramer.diagram.Arbeit.all = (dataToFramer.diagram.Arbeit.society+dataToFramer.diagram.Arbeit.politics+dataToFramer.diagram.Arbeit.economy)/3
  //Umwelt
  dataToFramer.diagram.Umwelt.society = (cityDiagram.hightech.Umwelt.society * hightechFactor + cityDiagram.virtual.Umwelt.society * virtualFactor + cityDiagram.regional.Umwelt.society * regionalFactor + cityDiagram.fortress.Umwelt.society * fortressFactor)/2
  dataToFramer.diagram.Umwelt.politics = (cityDiagram.hightech.Umwelt.politics * hightechFactor + cityDiagram.virtual.Umwelt.politics * virtualFactor + cityDiagram.regional.Umwelt.politics * regionalFactor + cityDiagram.fortress.Umwelt.politics * fortressFactor)/2
  dataToFramer.diagram.Umwelt.economy = (cityDiagram.hightech.Umwelt.economy * hightechFactor + cityDiagram.virtual.Umwelt.economy * virtualFactor + cityDiagram.regional.Umwelt.economy * regionalFactor + cityDiagram.fortress.Umwelt.economy * fortressFactor)/2
  dataToFramer.diagram.Umwelt.all = (dataToFramer.diagram.Umwelt.society+dataToFramer.diagram.Umwelt.politics+dataToFramer.diagram.Umwelt.economy)/3
  //Bildung
  dataToFramer.diagram.Bildung.society = (cityDiagram.hightech.Bildung.society * hightechFactor + cityDiagram.virtual.Bildung.society * virtualFactor + cityDiagram.regional.Bildung.society * regionalFactor + cityDiagram.fortress.Bildung.society * fortressFactor)/2
  dataToFramer.diagram.Bildung.politics = (cityDiagram.hightech.Bildung.politics * hightechFactor + cityDiagram.virtual.Bildung.politics * virtualFactor + cityDiagram.regional.Bildung.politics * regionalFactor + cityDiagram.fortress.Bildung.politics * fortressFactor)/2
  dataToFramer.diagram.Bildung.economy = (cityDiagram.hightech.Bildung.economy * hightechFactor + cityDiagram.virtual.Bildung.economy * virtualFactor + cityDiagram.regional.Bildung.economy * regionalFactor + cityDiagram.fortress.Bildung.economy * fortressFactor)/2
  dataToFramer.diagram.Bildung.all = (dataToFramer.diagram.Bildung.society+dataToFramer.diagram.Bildung.politics+dataToFramer.diagram.Bildung.economy)/3
  //sozialG
  dataToFramer.diagram.sozialG.society = (cityDiagram.hightech.sozialG.society * hightechFactor + cityDiagram.virtual.sozialG.society * virtualFactor + cityDiagram.regional.sozialG.society * regionalFactor + cityDiagram.fortress.sozialG.society * fortressFactor)/2
  dataToFramer.diagram.sozialG.politics = (cityDiagram.hightech.sozialG.politics * hightechFactor + cityDiagram.virtual.sozialG.politics * virtualFactor + cityDiagram.regional.sozialG.politics * regionalFactor + cityDiagram.fortress.sozialG.politics * fortressFactor)/2
  dataToFramer.diagram.sozialG.economy = (cityDiagram.hightech.sozialG.economy * hightechFactor + cityDiagram.virtual.sozialG.economy * virtualFactor + cityDiagram.regional.sozialG.economy * regionalFactor + cityDiagram.fortress.sozialG.economy * fortressFactor)/2
  dataToFramer.diagram.sozialG.all = (dataToFramer.diagram.sozialG.society+dataToFramer.diagram.sozialG.politics+dataToFramer.diagram.sozialG.economy)/3
  //Wohnen
  dataToFramer.diagram.Wohnen.society = (cityDiagram.hightech.Wohnen.society * hightechFactor + cityDiagram.virtual.Wohnen.society * virtualFactor + cityDiagram.regional.Wohnen.society * regionalFactor + cityDiagram.fortress.Wohnen.society * fortressFactor)/2
  dataToFramer.diagram.Wohnen.politics = (cityDiagram.hightech.Wohnen.politics * hightechFactor + cityDiagram.virtual.Wohnen.politics * virtualFactor + cityDiagram.regional.Wohnen.politics * regionalFactor + cityDiagram.fortress.Wohnen.politics * fortressFactor)/2
  dataToFramer.diagram.Wohnen.economy = (cityDiagram.hightech.Wohnen.economy * hightechFactor + cityDiagram.virtual.Wohnen.economy * virtualFactor + cityDiagram.regional.Wohnen.economy * regionalFactor + cityDiagram.fortress.Wohnen.economy * fortressFactor)/2
  dataToFramer.diagram.Wohnen.all = (dataToFramer.diagram.Wohnen.society+dataToFramer.diagram.Wohnen.politics+dataToFramer.diagram.Wohnen.economy)/3

console.log(dataToFramer)
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
    console.log('Connection established. Find page under http://localhost:3333/');
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

        calcDiagram()



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
