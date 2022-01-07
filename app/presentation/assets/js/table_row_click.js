$(document).ready(function() {
    $(".table-row").click(function() {
      window.document.location = $(this).data("href");
    });

    $(".article_table_row").click(function() {
      window.open($(this).data("href"));
    });
  });

  window.onload = function(){
    var update_time =[]
    var market_price = []
    var long_advice_price = []
    var mid_advice_price = []
    var short_advice_price = []

    var index = 0;
    $("table#history_table tr").each(function() {
        var arrayOfThisRow = [];
        var tableData = $(this).find('td');
        
        if (tableData.length > 0) {
            tableData.each(function() { arrayOfThisRow.push($(this).text()); });
            update_time[index] = arrayOfThisRow[0];
            market_price[index] = arrayOfThisRow[1];
            long_advice_price[index] = arrayOfThisRow[2];
            mid_advice_price[index] = arrayOfThisRow[3];
            short_advice_price[index] = arrayOfThisRow[4];
            index++;
        }
     });

     var ctxL = $(".LineChart")
     var myLineChart = new Chart(ctxL, {
       type: 'line',      
       data: {
         labels: update_time,
         datasets: [{
          data: market_price,
          label: "stock price",
          borderColor: "#c45850",
         },{ 
          data: long_advice_price,
          label: "long term",
          borderColor: "#8e5ea2",
          fill: false
        },{ 
          data: mid_advice_price,
          label: "mid term",
          borderColor: "#3cba9f",
          fill: false
        },{ 
          data: short_advice_price,
          label: "short term",
          borderColor: "#3e95cd",
          fill: false
        }]
       },
       options: {
         responsive: true
       }
     });
     
    }

