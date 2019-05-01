<html>
<title>Find A Stock</title>

<h1><?php echo "Search For ", $_GET["ticker"]; ?></h1>

  <?php


    $ticker = $_GET["ticker"];
    $urlFirst = 'https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=';
    $urlSecond = '&interval=5min&outputsize=full&apikey=E1TND8XYQA8S7DLQ';
    $url = $urlFirst . $ticker . $urlSecond;
  

    $data = file_get_contents($url);
    echo $data;

    $row = explode("\n",$data);
    $day = explode(",",$row[1]);

    
  ?>

  <script>
    var request = new XMLHttpRequest();
    var ticker = '<?php echo $ticker?>';
    var url = 'https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=' + ticker + '&interval=5min&outputsize=full&apikey=E1TND8XYQA8S7DLQ';
    request.open('GET', url, true);

    request.onload = function() {
      // Begin accessing JSON data here
      var data = JSON.parse(this.response)
      console.log(data);
    }

    request.send()
  </script>


</html>