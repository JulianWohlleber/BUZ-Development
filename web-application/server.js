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
var totalSlotAmount = collectiveImages.slotType.length + 1

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
function calcChartvalue(hightech, virtual, regional, fortress){
    value = (hightech * hightechFactor + virtual * virtualFactor + regional * regionalFactor + fortress * fortressFactor)/factorSum
    if (value<0){
      value = 0
    }else if(value>1){
      value = 1
    }
  console.log("active");
  return value
}

function calcDiagram(){
  hightechFactor = newScenarioFactors.hightech.votingAverage;
  virtualFactor = newScenarioFactors.virtual.votingAverage;
  regionalFactor = newScenarioFactors.regional.votingAverage;
  fortressFactor = newScenarioFactors.fortress.votingAverage;
  factorSum = hightechFactor + virtualFactor+regionalFactor+fortressFactor;
  if(factorSum <= 0){
    factorSum = 1;
  }

  //Arbeit
  dataToFramer.collective.Arbeit.Gesellschaft = calcChartvalue(dataToFramer.hightech.Arbeit.Gesellschaft, dataToFramer.virtual.Arbeit.Gesellschaft, dataToFramer.regional.Arbeit.Gesellschaft, dataToFramer.fortress.Arbeit.Gesellschaft)
  dataToFramer.collective.Arbeit.Politik = calcChartvalue(dataToFramer.hightech.Arbeit.Politik, dataToFramer.virtual.Arbeit.Politik, dataToFramer.regional.Arbeit.Politik, dataToFramer.fortress.Arbeit.Politik)
  dataToFramer.collective.Arbeit.Wirtschaft = calcChartvalue(dataToFramer.hightech.Arbeit.Wirtschaft, dataToFramer.virtual.Arbeit.Wirtschaft, dataToFramer.regional.Arbeit.Wirtschaft, dataToFramer.fortress.Arbeit.Wirtschaft)
  // dataToFramer.collective.Arbeit.all = (dataToFramer.collective.Arbeit.Gesellschaft+dataToFramer.collective.Arbeit.Politik+dataToFramer.collective.Arbeit.Wirtschaft)/3;

  //Umwelt
  dataToFramer.collective.Umwelt.Gesellschaft = calcChartvalue(dataToFramer.hightech.Umwelt.Gesellschaft, dataToFramer.virtual.Umwelt.Gesellschaft, dataToFramer.regional.Umwelt.Gesellschaft, dataToFramer.fortress.Umwelt.Gesellschaft)
  dataToFramer.collective.Umwelt.Politik = calcChartvalue(dataToFramer.hightech.Umwelt.Politik, dataToFramer.virtual.Umwelt.Politik, dataToFramer.regional.Umwelt.Politik, dataToFramer.fortress.Umwelt.Politik)
  dataToFramer.collective.Umwelt.Wirtschaft = calcChartvalue(dataToFramer.hightech.Umwelt.Wirtschaft, dataToFramer.virtual.Umwelt.Wirtschaft, dataToFramer.regional.Umwelt.Wirtschaft, dataToFramer.fortress.Umwelt.Wirtschaft)
  // dataToFramer.collective.Umwelt.all = (dataToFramer.collective.Umwelt.Gesellschaft+dataToFramer.collective.Umwelt.Politik+dataToFramer.collective.Umwelt.Wirtschaft)/3;

  //Bildung
  dataToFramer.collective.Bildung.Gesellschaft = calcChartvalue(dataToFramer.hightech.Bildung.Gesellschaft, dataToFramer.virtual.Bildung.Gesellschaft, dataToFramer.regional.Bildung.Gesellschaft, dataToFramer.fortress.Bildung.Gesellschaft)
  dataToFramer.collective.Bildung.Politik = calcChartvalue(dataToFramer.hightech.Bildung.Politik, dataToFramer.virtual.Bildung.Politik, dataToFramer.regional.Bildung.Politik, dataToFramer.fortress.Bildung.Politik)
  dataToFramer.collective.Bildung.Wirtschaft = calcChartvalue(dataToFramer.hightech.Bildung.Wirtschaft, dataToFramer.virtual.Bildung.Wirtschaft, dataToFramer.regional.Bildung.Wirtschaft, dataToFramer.fortress.Bildung.Wirtschaft)
  // dataToFramer.collective.Bildung.all = (dataToFramer.collective.Bildung.Gesellschaft + dataToFramer.collective.Bildung.Politik+dataToFramer.collective.Bildung.Wirtschaft)/3;

  //Wohnen
  dataToFramer.collective.sozialG.Gesellschaft = calcChartvalue(dataToFramer.hightech.sozialG.Gesellschaft, dataToFramer.virtual.sozialG.Gesellschaft, dataToFramer.regional.sozialG.Gesellschaft, dataToFramer.fortress.sozialG.Gesellschaft)
  dataToFramer.collective.sozialG.Politik = calcChartvalue(dataToFramer.hightech.sozialG.Politik, dataToFramer.virtual.sozialG.Politik, dataToFramer.regional.sozialG.Politik, dataToFramer.fortress.sozialG.Politik)
  dataToFramer.collective.sozialG.Wirtschaft = calcChartvalue(dataToFramer.hightech.sozialG.Wirtschaft, dataToFramer.virtual.sozialG.Wirtschaft, dataToFramer.regional.sozialG.Wirtschaft, dataToFramer.fortress.sozialG.Wirtschaft)
  // dataToFramer.collective.sozialG.all = (dataToFramer.collective.sozialG.Gesellschaft+dataToFramer.collective.sozialG.Politik+dataToFramer.collective.sozialG.Wirtschaft)/3;

  //Wohnen
  dataToFramer.collective.Wohnen.Gesellschaft = calcChartvalue(dataToFramer.hightech.Wohnen.Gesellschaft, dataToFramer.virtual.Wohnen.Gesellschaft, dataToFramer.regional.Wohnen.Gesellschaft, dataToFramer.fortress.Wohnen.Gesellschaft)
  dataToFramer.collective.Wohnen.Politik = calcChartvalue(dataToFramer.hightech.Wohnen.Politik, dataToFramer.virtual.Wohnen.Politik, dataToFramer.regional.Wohnen.Politik, dataToFramer.fortress.Wohnen.Politik)
  dataToFramer.collective.Wohnen.Wirtschaft = calcChartvalue(dataToFramer.hightech.Wohnen.Wirtschaft, dataToFramer.virtual.Wohnen.Wirtschaft, dataToFramer.regional.Wohnen.Wirtschaft, dataToFramer.fortress.Wohnen.Wirtschaft)
//   dataToFramer.collective.Wohnen.all = (dataToFramer.collective.Wohnen.Gesellschaft+dataToFramer.collective.Wohnen.Politik+dataToFramer.collective.Wohnen.Wirtschaft)/3;
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

  for (var i = 0; i < totalSlotAmount; i++) { //i == slot

    //type of Elements
    var slotType = collectiveImages.slotType[i]

    if(slotType === "LOW"){
      nextImageFolder = collectiveImages.low
    }else if(slotType === "MEDIUM"){
      nextImageFolder = collectiveImages.medium
    }else if(slotType === "HIGH"){
      nextImageFolder = collectiveImages.big
    }else if(slotType === "OL"){
      nextImageFolder = collectiveImages.ol
    }else if(slotType === "UL"){
      nextImageFolder = collectiveImages.ul
    }else if(slotType === "UR"){
      nextImageFolder = collectiveImages.ur
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
