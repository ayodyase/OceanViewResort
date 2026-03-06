function runCounters() {
  var counters = document.querySelectorAll(".js-counter");
  for (var i = 0; i < counters.length; i += 1) {
    counters[i].textContent = "0";
  }
  setTimeout(function () {
    for (var j = 0; j < counters.length; j += 1) {
      animateCounter(counters[j]);
    }
  }, 250);
}

document.addEventListener("DOMContentLoaded", runCounters);
window.addEventListener("pageshow", runCounters);

function animateCounter(counter) {
  var target = parseInt(counter.getAttribute("data-target"), 10);
  if (isNaN(target) || target < 0) {
    counter.textContent = "0";
    return;
  }

  var durationMs = 1400;
  var stepMs = 20;
  var steps = Math.max(1, Math.ceil(durationMs / stepMs));
  var currentStep = 0;

  var timer = setInterval(function () {
    currentStep += 1;
    var nextValue = Math.round((target * currentStep) / steps);
    counter.textContent = String(nextValue);
    if (currentStep >= steps) {
      counter.textContent = String(target);
      clearInterval(timer);
    }
  }, stepMs);
}
