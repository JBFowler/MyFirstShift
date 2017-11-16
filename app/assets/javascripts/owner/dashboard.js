document.addEventListener("turbolinks:load", function() {
  var ChartCreator = {
    init: function() {
      this.cache();
      this.bind();
    },

    cache: function() {
      this.$newTeamMembersChartDiv = $("#newTeamMembersChart");
      this.$hourlyPayBreakdownChartDiv = $("#hourlyPayBreakdownChart");
      this.$currentMonthNav = $("#current-month-nav");
      this.$pastSixMonthsNav = $("#past-six-months-nav");
      this.$pastTwelveMonthsNav = $("#past-twelve-months-nav");
      this.$defaultMonthBgColor = 'rgba(54, 162, 235, 0.2)';
      this.$currentMonthBgColor = 'rgba(50, 132, 50, 0.2)';
      this.$defaultMonthBorderColor = 'rgba(54, 162, 235, 1)';
      this.$currentMonthBorderColor = 'rgba(50, 132, 50, 1)';
      this.$months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
      this.$date = new Date();
      this.$myChart;
      this.$currentMonthData;
      this.sixMonthData;
      this.$twelveMonthData;
    },

    bind: function() {
      this.setupChartData();
      this.handleChartNavBtnClick();
      this.setupHourlyPayChart();
    },

    drawNewMembersChart: function(data) {
      var _this = this;

      _this.$myChart = new Chart(_this.$newTeamMembersChartDiv, {
        type: 'bar',
        data: data,
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
                beginAtZero: true
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
    },

    setupChartData: function() {
      var _this = this;

      if (_this.$newTeamMembersChartDiv.length > 0) {
        _this.$currentMonthData = {
          labels: [_this.$months[_this.$date.getMonth()]],
          datasets: [{
            label: 'Active Team Members',
            data: _this.$newTeamMembersChartDiv.data('one-month'),
            backgroundColor: [_this.$currentMonthBgColor],
            borderColor: [_this.$currentMonthBorderColor],
            borderWidth: 1
          }]
        };

        _this.$sixMonthData = {
          labels: jQuery.map([5, 4, 3, 2, 1, 0], function(n, i) { return _this.$months[_this.$date.getMonth() - n]}),
          datasets: [{
            label: 'Active Team Members',
            data: _this.$newTeamMembersChartDiv.data('six-months'),
            backgroundColor: [_this.$defaultMonthBgColor, _this.$defaultMonthBgColor, _this.$defaultMonthBgColor, _this.$defaultMonthBgColor, _this.$defaultMonthBgColor, _this.$currentMonthBgColor],
            borderColor: [_this.$defaultMonthBorderColor, _this.$defaultMonthBorderColor, _this.$defaultMonthBorderColor, _this.$defaultMonthBorderColor, _this.$defaultMonthBorderColor, _this.$currentMonthBorderColor],
            borderWidth: 1
          }]
        };

        _this.$twelveMonthData = {
          labels: jQuery.map([12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0], function(n, i) {
            if (n > _this.$date.getMonth()) {
              return _this.$months[n]
            } else {
              return _this.$months[_this.$date.getMonth() - n]
            }
          }),
          datasets: [{
            label: 'Active Team Members',
            data: _this.$newTeamMembersChartDiv.data('twelve-months'),
            backgroundColor: [_this.$defaultMonthBgColor, _this.$defaultMonthBgColor, _this.$defaultMonthBgColor, _this.$defaultMonthBgColor, _this.$defaultMonthBgColor, _this.$defaultMonthBgColor, _this.$defaultMonthBgColor, _this.$defaultMonthBgColor, _this.$defaultMonthBgColor, _this.$defaultMonthBgColor, _this.$defaultMonthBgColor, _this.$currentMonthBgColor],
            borderColor: [_this.$defaultMonthBorderColor, _this.$defaultMonthBorderColor, _this.$defaultMonthBorderColor, _this.$defaultMonthBorderColor, _this.$defaultMonthBorderColor, _this.$defaultMonthBorderColor, _this.$defaultMonthBorderColor, _this.$defaultMonthBorderColor, _this.$defaultMonthBorderColor, _this.$defaultMonthBorderColor, _this.$defaultMonthBorderColor, _this.$currentMonthBorderColor],
            borderWidth: 1
          }]
        }

        _this.drawNewMembersChart(_this.$sixMonthData);
      }
    },

    handleChartNavBtnClick: function() {
      var _this = this;

      _this.$currentMonthNav.on('click', function() {
        _this.$myChart.destroy();
        _this.drawNewMembersChart(_this.$currentMonthData);
      });

      _this.$pastSixMonthsNav.on('click', function() {
        _this.$myChart.destroy();
        _this.drawNewMembersChart(_this.$sixMonthData);
      });

      _this.$pastTwelveMonthsNav.on('click', function() {
        _this.$myChart.destroy();
        _this.drawNewMembersChart(_this.$twelveMonthData);
      });
    },

    setupHourlyPayChart: function() {
      _this = this;

      if (_this.$hourlyPayBreakdownChartDiv.length > 0) {
        var myPieChart = new Chart(_this.$hourlyPayBreakdownChartDiv, {
          type: 'pie',
          data: {
            labels: ["$8/hr", "$10/hr"],
            datasets: [{
              label: '',
              data: [_this.$hourlyPayBreakdownChartDiv.data('eight-hourly'), _this.$hourlyPayBreakdownChartDiv.data('ten-hourly')],
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
      }
    }
  }

  ChartCreator.init()
});
