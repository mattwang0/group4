<html>
<title>Drop A Stock</title>

<h1><?php echo "Drop Stock ", $_GET["dropTicker"], "?"; ?></h1>

<?php
  // Initialize the session
  session_start();
  $ticker = $_GET["dropTicker"];
  ?>

<?php
  // IF DROP STOCK IS CLICKED, CONNECT TO DATABASE AND REMOVE DROPTICKER
  if (isset($_POST["drop"])) {
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
    $removeQuery = "DELETE FROM owns WHERE username='$user' AND stock='$ticker'";
    // $removeQuery = "DELETE FROM owns WHERE username='mawang' AND stock='fb'";
    // $result = ;
    try {
      if (mysqli_query($conn, $removeQuery)) {
        // confirmation alert
        echo '<script language="javascript">';
        echo 'alert("Stock successfully dropped from portfolio")';
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
    <form action="/dropStock.php?dropTicker=<?php echo $_GET["dropTicker"]?>" method="post">
      <input type="submit" name="drop" class="btn btn-primary" value="Drop it!">
    </form>
    <form action="/welcome.php" method="post">
      <input type="submit" class="btn btn-primary" value="Nah go back">
    </form>
  </div>

</html>
