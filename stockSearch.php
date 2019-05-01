<html>
<title>Find A Stock</title>

<h1><?php echo "Search For ", $_GET["ticker"]; ?></h1>

  <?php


    $ticker = $_GET["ticker"];
    $urlFirst = 'https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=';
    $urlSecond = '&interval=5min&outputsize=full&apikey=E1TND8XYQA8S7DLQ';
    $url = $urlFirst . $ticker . $urlSecond;
  

    $data = file_get_contents($url);
    $data = substr($data,65);
    $startmark = strpos($data, "open");
    $currentPrice = substr($data,$startmark+8,9);
    $currentPrice = preg_replace('/[^0-9.]/', '', $currentPrice);


    // echo $currentPrice;
    // echo "<br>";
    // echo $data;

    $row = explode("\n",$data);
    $day = explode(",",$row[1]);

    
  ?>

  <p>Price: $<?php echo $currentPrice?></p>


  <?php
  $servername = "localhost";
  $username = "root";
  $password = "123456";
  $dbname = "stockSchema";

  $conn = new mysqli($servername, $username, $password);

  mysqli_select_db($conn, $dbname) or die("Could not open the '$dbname'");
  ?>


  <div class="form-group">
    <form action="" method="post">
      <input type="submit" class="btn btn-primary" value="Add to portfolio">
    </form>
    <form action="/welcome.php" method="post">
      <input type="submit" class="btn btn-primary" value="Go back">
    </form>
  </div>

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