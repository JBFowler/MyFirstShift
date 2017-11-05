$(function() {
  var ctx = $("#activeTeamMembersChart");

  var activeTeamMembersChart = new Chart(ctx, {
    type: 'bar',
    data: {
      labels: ["June", "July", "August", "September", "October", "November"],
      datasets: [{
        label: 'Active Team Members',
        data: [3, 5, 6, 9, 9, 10],
        backgroundColor: [
          'rgba(54, 162, 235, 0.2)',
          'rgba(54, 162, 235, 0.2)',
          'rgba(54, 162, 235, 0.2)',
          'rgba(54, 162, 235, 0.2)',
          'rgba(54, 162, 235, 0.2)',
          'rgba(54, 162, 235, 0.2)'
        ],
        borderColor: [
          'rgba(54, 162, 235, 1)',
          'rgba(54, 162, 235, 1)',
          'rgba(54, 162, 235, 1)',
          'rgba(54, 162, 235, 1)',
          'rgba(54, 162, 235, 1)',
          'rgba(54, 162, 235, 1)'
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
});
