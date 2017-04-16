//#########################imports##########################################
var express = require('express');
var http = require('http');
var io = require('socket.io');
var fs = require('fs');


//#########################variables##########################################
var scenarioFactors = JSON.parse(fs.readFileSync('./data/ScenarioFactors.json', 'utf8'));
var dataToFramer = JSON.parse(fs.readFileSync('./data/Diagrams.json', 'utf8'));
var newScenarioFactors = JSON.parse(JSON.stringify(scenarioFactors));

var collectiveImages = JSON.parse(fs.readFileSync('./data/collectiveImages.json', 'utf8'));

//Serversettings
var port = 9470

//Voting
var minVotingValue = -2
var maxVotingValue = 2
var maxVotingProportion = 20; //votingamount on which above persentage is used (1/minVotingAmount)

//CollectiveImageRendering
var lowElements = 6 //amount of low height Elements in scenario
var mediumElements = 6 //amount of medium height Elements in scenario
var bigElements = 4 //amount of big height Elements in scenario
var totalSlotAmount = lowElements + mediumElements + bigElements

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
var server = http.createServer(app).listen(port);
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
  dataToFramer.collective.Arbeit.Gesellschaft = (dataToFramer.hightech.Arbeit.Gesellschaft * hightechFactor + dataToFramer.virtual.Arbeit.Gesellschaft * virtualFactor + dataToFramer.regional.Arbeit.Gesellschaft * regionalFactor + dataToFramer.fortress.Arbeit.Gesellschaft * fortressFactor)/factorSum;
  dataToFramer.collective.Arbeit.Politik = (dataToFramer.hightech.Arbeit.Politik * hightechFactor + dataToFramer.virtual.Arbeit.Politik * virtualFactor + dataToFramer.regional.Arbeit.Politik * regionalFactor + dataToFramer.fortress.Arbeit.Politik * fortressFactor)/factorSum;
  dataToFramer.collective.Arbeit.Wirtschaft = (dataToFramer.hightech.Arbeit.Wirtschaft * hightechFactor + dataToFramer.virtual.Arbeit.Wirtschaft * virtualFactor + dataToFramer.regional.Arbeit.Wirtschaft * regionalFactor + dataToFramer.fortress.Arbeit.Wirtschaft * fortressFactor)/factorSum;
  dataToFramer.collective.Arbeit.all = (dataToFramer.collective.Arbeit.Gesellschaft+dataToFramer.collective.Arbeit.Politik+dataToFramer.collective.Arbeit.Wirtschaft)/3;

  //Umwelt
  dataToFramer.collective.Umwelt.Gesellschaft = (dataToFramer.hightech.Umwelt.Gesellschaft * hightechFactor + dataToFramer.virtual.Umwelt.Gesellschaft * virtualFactor + dataToFramer.regional.Umwelt.Gesellschaft * regionalFactor + dataToFramer.fortress.Umwelt.Gesellschaft * fortressFactor)/factorSum;
  dataToFramer.collective.Umwelt.Politik = (dataToFramer.hightech.Umwelt.Politik * hightechFactor + dataToFramer.virtual.Umwelt.Politik * virtualFactor + dataToFramer.regional.Umwelt.Politik * regionalFactor + dataToFramer.fortress.Umwelt.Politik * fortressFactor)/factorSum;
  dataToFramer.collective.Umwelt.Wirtschaft = (dataToFramer.hightech.Umwelt.Wirtschaft * hightechFactor + dataToFramer.virtual.Umwelt.Wirtschaft * virtualFactor + dataToFramer.regional.Umwelt.Wirtschaft * regionalFactor + dataToFramer.fortress.Umwelt.Wirtschaft * fortressFactor)/factorSum;
  dataToFramer.collective.Umwelt.all = (dataToFramer.collective.Umwelt.Gesellschaft+dataToFramer.collective.Umwelt.Politik+dataToFramer.collective.Umwelt.Wirtschaft)/3;

  //Bildung
  dataToFramer.collective.Bildung.Gesellschaft = (dataToFramer.hightech.Bildung.Gesellschaft * hightechFactor + dataToFramer.virtual.Bildung.Gesellschaft * virtualFactor + dataToFramer.regional.Bildung.Gesellschaft * regionalFactor + dataToFramer.fortress.Bildung.Gesellschaft * fortressFactor)/factorSum;
  dataToFramer.collective.Bildung.Politik = (dataToFramer.hightech.Bildung.Politik * hightechFactor + dataToFramer.virtual.Bildung.Politik * virtualFactor + dataToFramer.regional.Bildung.Politik * regionalFactor + dataToFramer.fortress.Bildung.Politik * fortressFactor)/factorSum;
  dataToFramer.collective.Bildung.Wirtschaft = (dataToFramer.hightech.Bildung.Wirtschaft * hightechFactor + dataToFramer.virtual.Bildung.Wirtschaft * virtualFactor + dataToFramer.regional.Bildung.Wirtschaft * regionalFactor + dataToFramer.fortress.Bildung.Wirtschaft * fortressFactor)/factorSum;
  dataToFramer.collective.Bildung.all = (dataToFramer.collective.Bildung.Gesellschaft + dataToFramer.collective.Bildung.Politik+dataToFramer.collective.Bildung.Wirtschaft)/3;

  //sozialG
  dataToFramer.collective.sozialG.Gesellschaft = (dataToFramer.hightech.sozialG.Gesellschaft * hightechFactor + dataToFramer.virtual.sozialG.Gesellschaft * virtualFactor + dataToFramer.regional.sozialG.Gesellschaft * regionalFactor + dataToFramer.fortress.sozialG.Gesellschaft * fortressFactor)/factorSum;
  dataToFramer.collective.sozialG.Politik = (dataToFramer.hightech.sozialG.Politik * hightechFactor + dataToFramer.virtual.sozialG.Politik * virtualFactor + dataToFramer.regional.sozialG.Politik * regionalFactor + dataToFramer.fortress.sozialG.Politik * fortressFactor)/factorSum;
  dataToFramer.collective.sozialG.Wirtschaft = (dataToFramer.hightech.sozialG.Wirtschaft * hightechFactor + dataToFramer.virtual.sozialG.Wirtschaft * virtualFactor + dataToFramer.regional.sozialG.Wirtschaft * regionalFactor + dataToFramer.fortress.sozialG.Wirtschaft * fortressFactor)/factorSum;
  dataToFramer.collective.sozialG.all = (dataToFramer.collective.sozialG.Gesellschaft+dataToFramer.collective.sozialG.Politik+dataToFramer.collective.sozialG.Wirtschaft)/3;

  //Wohnen
  dataToFramer.collective.Wohnen.Gesellschaft = (dataToFramer.hightech.Wohnen.Gesellschaft * hightechFactor + dataToFramer.virtual.Wohnen.Gesellschaft * virtualFactor + dataToFramer.regional.Wohnen.Gesellschaft * regionalFactor + dataToFramer.fortress.Wohnen.Gesellschaft * fortressFactor)/factorSum;
  dataToFramer.collective.Wohnen.Politik = (dataToFramer.hightech.Wohnen.Politik * hightechFactor + dataToFramer.virtual.Wohnen.Politik * virtualFactor + dataToFramer.regional.Wohnen.Politik * regionalFactor + dataToFramer.fortress.Wohnen.Politik * fortressFactor)/factorSum;
  dataToFramer.collective.Wohnen.Wirtschaft = (dataToFramer.hightech.Wohnen.Wirtschaft * hightechFactor + dataToFramer.virtual.Wohnen.Wirtschaft * virtualFactor + dataToFramer.regional.Wohnen.Wirtschaft * regionalFactor + dataToFramer.fortress.Wohnen.Wirtschaft * fortressFactor)/factorSum;
  dataToFramer.collective.Wohnen.all = (dataToFramer.collective.Wohnen.Gesellschaft+dataToFramer.collective.Wohnen.Politik+dataToFramer.collective.Wohnen.Wirtschaft)/3;
}

//mapFunction
function map_range(value, low1, high1, low2, high2) {
    return low2 + (high2 - low2) * (value - low1) / (high1 - low1);
}

function calccomponentAmounts(totalSlotAmount){
  //map the values
  var regionalValue = map_range(scenarioFactors.regional.votingAverage, minVotingValue, maxVotingValue, 0, 1)
  var hightechValue = map_range(scenarioFactors.hightech.votingAverage, minVotingValue, maxVotingValue, 0, 1)
  var fortressValue = map_range(scenarioFactors.fortress.votingAverage, minVotingValue, maxVotingValue, 0, 1)
  var virtualValue = map_range(scenarioFactors.virtual.votingAverage, minVotingValue, maxVotingValue, 0, 1)
  var sumValues = regionalValue + hightechValue + fortressValue + virtualValue
  var componentAmounts = {}

  //amount of slots/Scenario
  componentAmounts.Regional = Math.round(map_range(regionalValue, 0, sumValues, 0, totalSlotAmount))
  componentAmounts.Hightech = Math.round(map_range(hightechValue, 0, sumValues, 0, totalSlotAmount))
  componentAmounts.Fortress = Math.round(map_range(fortressValue, 0, sumValues, 0, totalSlotAmount))
  componentAmounts.Virtual = Math.round(map_range(virtualValue, 0, sumValues, 0, totalSlotAmount))
  return componentAmounts
}

function fillSlots(componentAmounts){
  var slotArray = []
  var nextImageFolder = {}
  var nextScenarioFolder = {}
  var activeScenarioIndex = 1
  var activeScenarioAmounts = {}

  for (var i = 1; i <= totalSlotAmount; i++) { //i == slot
//height of Elements
    var slotHeight = collectiveImages.slotHeight [i]
    if(collectiveImages.slotHeight[i-1] === "LOW"){
      nextImageFolder = collectiveImages.low
    }else if(collectiveImages.slotHeight[i-1] === "MEDIUM"){
      nextImageFolder = collectiveImages.medium
    }else if(collectiveImages.slotHeight[i-1] === "HIGH"){
      nextImageFolder = collectiveImages.big
    }

//Scenario of Elements
    activeScenarioIndex = Math.floor((Math.random() * 4) + 1) //this Random Value defines the Element of the leftover Elements
    activeVariante = Math.floor((Math.random() * 2) + 1) //this Random Value defines the variant of the selected Element

    if (activeScenarioIndex === 1){
      if(componentAmounts.Hightech > 0){
        nextScenarioFolder = nextImageFolder.hightech
        if (activeVariante === 1){
          slotArray.push(nextScenarioFolder.A)
        }else if(activeVariante === 2){
          slotArray.push(nextScenarioFolder.B)
        }
        componentAmounts.Hightech--
      }else{
        i--
      }
    }else if (activeScenarioIndex === 2){
      if(componentAmounts.Regional > 0){
        nextScenarioFolder = nextImageFolder.regional
        if (activeVariante === 1){
          slotArray.push(nextScenarioFolder.A)
        }else if(activeVariante === 2){
          slotArray.push(nextScenarioFolder.B)
        }
        componentAmounts.Regional--
      }else{
        i--
      }
    }else if (activeScenarioIndex === 3){
      if(componentAmounts.Virtual > 0){
        nextScenarioFolder = nextImageFolder.virtual
        if (activeVariante === 1){
          slotArray.push(nextScenarioFolder.A)
        }else if(activeVariante === 2){
          slotArray.push(nextScenarioFolder.B)
        }
        componentAmounts.Virtual--
      }else{
        i--
      }
    }else if (activeScenarioIndex === 4){
      if(componentAmounts.Fortress > 0){
        nextScenarioFolder = nextImageFolder.fortress
        if (activeVariante === 1){
          slotArray.push(nextScenarioFolder.A)
        }else if(activeVariante === 2){
          slotArray.push(nextScenarioFolder.B)
        }
        componentAmounts.Fortress--
      }else{
        i--
      }
    }
  }
  return slotArray
}
dataToFramer.slotsCollective = fillSlots(calccomponentAmounts(totalSlotAmount))

//#########################socketServer#########################################
io.sockets.on("connection",function(socket){
  /*Associating the callback function to be executed when client visits the page and
  websocket connection is made */

  // var message_to_client = {
  //   "message":"Connected with server"
  // };
  // socket.send(JSON.stringify(message_to_client));
  /*sending data to the client , this triggers a message event at the client side */
  console.log('Connection established. Find page under http://localhost:' + port + '/');
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
    dataToFramer.slotsCollective = fillSlots(calccomponentAmounts(totalSlotAmount))


    //Things done when Kollektives Stadtbild is selected
    if(data.scenario === "collective" || data.scenario === ""){
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
      //preventing votingAmount To be bigger then defined maxVotingProportion
      if(scenarioFactors.hightech.votingAmount >= maxVotingProportion){
        scenarioFactors.hightech.votingAmount = maxVotingProportion;
      }
      if(scenarioFactors.virtual.votingAmount >= maxVotingProportion){
        scenarioFactors.virtual.votingAmount = maxVotingProportion;
      }
      if(scenarioFactors.regional.votingAmount >= maxVotingProportion){
        scenarioFactors.regional.votingAmount = maxVotingProportion;
      }
      if(scenarioFactors.fortress.votingAmount >= maxVotingProportion){
        scenarioFactors.fortress.votingAmount = maxVotingProportion;
      }

      //save the updates scenarioFactors to json
      fs.writeFile('./data/ScenarioFactors.json', JSON.stringify(scenarioFactors), (err) => {
        if (err) throw err;
        console.log('It\'s saved!');
      });
      fs.writeFile('./data/Diagrams.json', JSON.stringify(dataToFramer), (err) => {
        if (err) throw err;
        console.log('It\'s saved!');
      });

    }
    socket.send(JSON.stringify(dataToFramer));
    console.log("dataToFramer")
    /*Sending the Acknowledgement back to the client , this will trigger "message" event on the clients side*/
  });
  //still necessary then?
  socket.send(JSON.stringify(dataToFramer));
  console.log("dataToFramer")

});
