$(function() {
  var newTeamMembersChartDiv = $("#newTeamMembersChart");
  var hourlyPayBreakdownChartDiv = $("#hourlyPayBreakdownChart");
  var currentMonthNav = $("#current-month-nav");
  var pastSixMonthsNav = $("#past-six-months-nav");
  var pastTwelveMonthsNav = $("#past-twelve-months-nav");
  var myChart;

  function drawMonthChart() {
    var ctx = newTeamMembersChartDiv;
    myChart = new Chart(newTeamMembersChartDiv, {
      type: 'bar',
      data: {
        labels: ["November"],
        datasets: [{
          label: 'Active Team Members',
          data: newTeamMembersChartDiv.data('one-month'),
          backgroundColor: [
            'rgba(50, 132, 50, 0.2)'
          ],
          borderColor: [
            'rgba(50, 132, 50, 1)'
          ],
          borderWidth: 1
        }]
      },
      options: {
        legend: {
          labels: {
            boxWidth: 0,
            fontSize: 0,
            fontFamily: "'Muli', 'sans-serif'"
          }
        },
        scales: {
          yAxes: [{
            gridLines: {
              display: false
            },
            ticks: {
              beginAtZero:true
            }
          }],
          xAxes: [{
            gridLines: {
              display: false
            }
          }]
        }
      }
    });
  }

  function drawSixMonthChart() {
    var ctx = newTeamMembersChartDiv;
    myChart = new Chart(newTeamMembersChartDiv, {
      type: 'bar',
      data: {
        labels: ["June", "July", "August", "September", "October", "November"],
        datasets: [{
          label: 'Active Team Members',
          data: newTeamMembersChartDiv.data('six-months'),
          backgroundColor: [
            'rgba(54, 162, 235, 0.2)',
            'rgba(54, 162, 235, 0.2)',
            'rgba(54, 162, 235, 0.2)',
            'rgba(54, 162, 235, 0.2)',
            'rgba(54, 162, 235, 0.2)',
            'rgba(50, 132, 50, 0.2)'
          ],
          borderColor: [
            'rgba(54, 162, 235, 1)',
            'rgba(54, 162, 235, 1)',
            'rgba(54, 162, 235, 1)',
            'rgba(54, 162, 235, 1)',
            'rgba(54, 162, 235, 1)',
            'rgba(50, 132, 50, 1)'
          ],
          borderWidth: 1
        }]
      },
      options: {
        legend: {
          labels: {
            boxWidth: 0,
            fontSize: 0,
            fontFamily: "'Muli', 'sans-serif'"
          }
        },
        scales: {
          yAxes: [{
            gridLines: {
              display: false
            },
            ticks: {
              beginAtZero:true
            }
          }],
          xAxes: [{
            gridLines: {
              display: false
            }
          }]
        }
      }
    });
  }

  function drawTwelveMonthChart() {
    var ctx = newTeamMembersChartDiv;
    myChart = new Chart(newTeamMembersChartDiv, {
      type: 'bar',
      data: {
        labels: ["June", "July", "August", "September", "October", "November", "June", "July", "August", "September", "October", "November"],
        datasets: [{
          label: 'Active Team Members',
          data: newTeamMembersChartDiv.data('twelve-months'),
          backgroundColor: [
            'rgba(54, 162, 235, 0.2)',
            'rgba(54, 162, 235, 0.2)',
            'rgba(54, 162, 235, 0.2)',
            'rgba(54, 162, 235, 0.2)',
            'rgba(54, 162, 235, 0.2)',
            'rgba(54, 162, 235, 0.2)',
            'rgba(54, 162, 235, 0.2)',
            'rgba(54, 162, 235, 0.2)',
            'rgba(54, 162, 235, 0.2)',
            'rgba(54, 162, 235, 0.2)',
            'rgba(54, 162, 235, 0.2)',
            'rgba(50, 132, 50, 0.2)'
          ],
          borderColor: [
            'rgba(54, 162, 235, 1)',
            'rgba(54, 162, 235, 1)',
            'rgba(54, 162, 235, 1)',
            'rgba(54, 162, 235, 1)',
            'rgba(54, 162, 235, 1)',
            'rgba(54, 162, 235, 1)',
            'rgba(54, 162, 235, 1)',
            'rgba(54, 162, 235, 1)',
            'rgba(54, 162, 235, 1)',
            'rgba(54, 162, 235, 1)',
            'rgba(54, 162, 235, 1)',
            'rgba(50, 132, 50, 1)'
          ],
          borderWidth: 1
        }]
      },
      options: {
        legend: {
          labels: {
            boxWidth: 0,
            fontSize: 0,
            fontFamily: "'Muli', 'sans-serif'"
          }
        },
        scales: {
          yAxes: [{
            gridLines: {
              display: false
            },
            ticks: {
              beginAtZero:true
            }
          }],
          xAxes: [{
            gridLines: {
              display: false
            }
          }]
        }
      }
    });
  }

  drawMonthChart();

  currentMonthNav.on('click', function() {
    myChart.destroy();
    drawMonthChart();
  });

  pastSixMonthsNav.on('click', function() {
    myChart.destroy();
    drawSixMonthChart();
  });

  pastTwelveMonthsNav.on('click', function() {
    myChart.destroy();
    drawTwelveMonthChart();
  });

  $('.nav-pills').on('click', 'button', function() {
    $('.nav-pills button.active').removeClass('active');
    $(this).addClass('active');
  });

  var myPieChart = new Chart(hourlyPayBreakdownChartDiv, {
    type: 'pie',
    data: {
      labels: ["$10/hr", "$8/hr"],
      datasets: [{
        label: '',
        data: [56, 44],
        backgroundColor: [
          'rgba(50, 132, 50, 0.2)',
          'rgba(54, 162, 235, 0.2)'
        ],
        borderColor: [
          'rgba(50, 132, 50, 1)',
          'rgba(54, 162, 235, 1)'
        ],
        borderWidth: 1
      }]
    },
    options: {
      layout: {
        padding: {
          left: 120
        }
      },
      legend: {
        labels: {
          boxWidth: 50,
          fontSize: 16,
          fontFamily: "'Muli', 'sans-serif'"
        },
        position: 'right'
      },
      tooltips: {
        callbacks: {
          label: function(tooltipItem, data) {
            var dataset = data.datasets[tooltipItem.datasetIndex];
            var total = dataset.data.reduce(function(previousValue, currentValue, currentIndex, array) {
              return previousValue + currentValue;
            });
            var currentValue = dataset.data[tooltipItem.index];
            var precentage = Math.floor(((currentValue/total) * 100)+0.5);
            return precentage + "%";
          }
        }
      }
    }
  });
});
