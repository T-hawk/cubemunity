document.addEventListener("turbolinks:load", function() {
  if (document.getElementById("scramble")) {
    documentLoaded();
  }
});

function documentLoaded() {
  let timerStarted = true;
  let stopWatch;
  let personalBest = $('.personal_best').data('personalBest');
  const FACES = {"F": ["F", "F2"], 
              "B": ["B", "B2"], 
              "U": ["U", "U2"], 
              "D": ["D", "D2"], 
              "R": ["R", "R2"], 
              "L": ["L", "L2"]}
  const SCRAMBLE_LENGTH = 20;
  let centiseconds = 0;
  let timeTable = [];
  let previousTime;
  let scramble = scrambleGenerator([], 0)
  document.getElementById('manual_personal_best').onclick = function manualPersonalBest() {
    let hours;
    let minutes;
    let seconds;

    while (!hours || hours % 1 != 0) {
      hours = prompt("How many hours? (must be a whole number)");
    }
    while (!minutes || minutes >= 60) {
      minutes = prompt("How many minutes? (must be a whole number less than 60)");
    }
    while (!seconds || minutes >= 60) {
      seconds = prompt("How many seconds? (must be a less than 60; Can be up to the hundreths place)");
      seconds = parseFloat(seconds);
      seconds = seconds.toFixed(2);
    }
    let time = hours + ":" + minutes + ":" + seconds;
    newPersonalBest(time);
  }

  document.addEventListener("turbolinks:load", function() {
    if (!document.getElementById("scramble")) {
      clearInterval(stopWatch);
    } 
  });

  document.getElementById("scramble").innerHTML = scramble.toString()
  document.body.onkeyup = function(e) {
    if (e.keyCode === 32) {
      document.getElementById("timer").style.color = "black"
      if (timerStarted) {

        // Timer Starts

        tickTimer()
        stopWatch = setInterval(tickTimer, 10)
        timerStarted = !timerStarted

      } else {

        timerStarted = !timerStarted
        scramble = scrambleGenerator([], 0)
        document.getElementById("scramble").innerHTML = scramble.toString()

        if (previousTime.centiseconds < convertToCentiSeconds(personalBest)) {
          newPersonalBest(previousTime.getString());
        } else if (!personalBest) {
          newPersonalBest(previousTime.getString());
        }

      }
    }
  }

  document.body.onkeydown = function(e) {
    if (e.keyCode === 32) {
      e.preventDefault();
      document.getElementById("timer").style.color = "red"
    }

    if (e.keyCode === 32 && !timerStarted && !e.repeat) {
      clearInterval(stopWatch)
      timeTable.push(centiseconds);

      let timeString = calculateTime(false);
      let timeData = document.createElement("p")
      let node = document.createTextNode(timeString)

      timeData.appendChild(node)

      const div = document.getElementById("timeData")
      div.appendChild(timeData)

      let averages = calculateTime(true)
      document.getElementById("averageOfTimes").innerHTML = averages[0]
      document.getElementById("averageOfFive").innerHTML = averages[1]

      previousTime = new Time(centiseconds);

      centiseconds = 0
    }
  }

  function tickTimer() {
    centiseconds += 1
    updateTimerDisplay()
  }

  function updateTimerDisplay() {
    let timer = document.getElementById("timer")
    timer.innerHTML = calculateTime(false);
  }

  function currentTimeString(seconds, minutes, hours) {
    return String(hours) + ":" + String(minutes) + ":" + String(seconds.toFixed(2));
  }

  function calculateTime(isAverage) {
    if (isAverage) {

      let averageTime, averageOfFive

      if (timeTable.length > 2) {
        averageTime = new Time(calculateAverage(timeTable))
      } else {
        averageTime = new Time((timeTable[0] + timeTable[1]) / 2 || timeTable[0])
      }

      if (timeTable.length >= 5) {
        let averageOfFiveTimeTable = [...timeTable]
        averageOfFiveTimeTable.splice(0, averageOfFiveTimeTable.length - 5)
        averageOfFive = new Time(calculateAverage(averageOfFiveTimeTable))
      } else {
        averageOfFive = new Time(0)
      }

      return [averageTime.getString(), averageOfFive.getString()]
    } else {

      let time = new Time(centiseconds)

      return time.getString()
    }
  }

  function scrambleGenerator(scramble, length) {
    if (length < SCRAMBLE_LENGTH) {

      let face;

      do {
        let faceKeys = Object.keys(FACES)
        face = faceKeys[Math.floor(Math.random() * faceKeys.length)]
      } while (face == (scramble[length - 1] || "")[0]) 

      let move = FACES[face][Math.floor(Math.random() * 2)]

      scramble.push(" " + move)
      scrambleGenerator(scramble, length + 1)
    }
    return scramble;
  }

  function calculateAverage(times) {
    times = setupAverage(times)
    total = 0

    times.forEach(time => {
      total += time
    });

    return total / times.length
  }

  function setupAverage(times) {
    let tempTimes = [...times]
    tempTimes.sort(function(a, b) {return a - b})

    tempTimes.shift()
    tempTimes.pop()

    return tempTimes

  }

  function newPersonalBest(time) {
    let valid = confirm("Congratulations! It looks like you got a new personal best of " + time + "\n"
    + "Is this valid?")
    if (valid) {
      Rails.ajax({
        url: "timer/pb",
        type: "POST",
        data: "personal_best=" + time
      });
    }
  }

  function convertToCentiSeconds(time) {
    let timeArray = time.split(":")
    let centiseconds = 0;
    centiseconds += timeArray[2] * 100;
    let minutes = timeArray[1] * 60;
    let hours = timeArray[0] * 60;
    minutes += hours * 60;
    centiseconds += minutes * 60 * 100;
    // console.log(centiseconds)
    return Math.round(centiseconds);
  }

  class Time {

    constructor(centiseconds) {
      this.centiseconds = centiseconds;

      this.seconds = (this.centiseconds / 100) % 60;
      this.minutes = Math.floor(this.centiseconds / 6000) % 60;
      this.hours = Math.floor(this.centiseconds / 360000);

    }

    getString() {
      return currentTimeString(this.seconds, this.minutes, this.hours);
    }
  }
}