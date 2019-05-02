<html>
<title>Find A Stock</title>

<h1><?php echo "Search For ", $_GET["ticker"]; ?></h1>

  <?php
  // Initialize the session
  session_start();
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
  // IF ADD STOCK IS CLICKED, CONNECT TO DATABASE AND ADD CURRENT TICKER AND PRICE TO DATABASE
  if (isset($_POST["addStock"])) {
    $user = $_SESSION['username']; //retrieve username from last page
    $servername = "localhost";
    $username = "root";
    $password = "123456";
    $dbname = "stockSchema";
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
  
    $conn = new mysqli($servername, $username, $password);
  
    mysqli_select_db($conn, $dbname) or die("Could not open the '$dbname'");
    $user = mysqli_real_escape_string($conn, $user);
    $ticker = mysqli_real_escape_string($conn, $ticker);
    $insertQuery = "INSERT INTO owns (username, stock, price) VALUES ('$user', '$ticker', '$currentPrice')";
    // $insertQuery = "INSERT INTO owns (username, stock, price) VALUES ('mawang', '', 123.45)";
    // $result = ;
    try {
      if (mysqli_query($conn, $insertQuery)) {
        // confirmation alert
        echo '<script language="javascript">';
        echo 'alert("Stock successfully added to portfolio")';
        echo '</script>';
      } else {
        // bad alert
        echo '<script language="javascript">';
        echo 'alert("Something went wrong!")';
        echo '</script>';
      }
    }
    catch (Exception $e) {
      // bad alert
      echo 'Caught exception: ',  $e->getMessage(), "\n";
    }
  }
  ?>


  <div class="form-group">
    <form action="/stockSearch.php?ticker=<?php echo $ticker?>" method="post">
      <input type="submit" name="addStock" class="btn btn-primary" value="Add to portfolio">
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