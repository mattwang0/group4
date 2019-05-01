<?php
// Initialize the session
session_start();
 
// Check if the user is logged in, if not then redirect him to login page
if(!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true){
    header("location: login.php");
    exit;
}
?>
 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Welcome</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.css">
    <style type="text/css">
        body{ font: 14px sans-serif; text-align: center; }
    </style>
</head>
<body>
    <div class="page-header">
        <h1>Hi, <b><?php echo htmlspecialchars($_SESSION["username"]); ?></b>. Welcome to Your Fantasy League.</h1>
    </div>
    <p>
        <a href="reset-password.php" class="btn btn-warning">Reset Your Password</a>
        <a href="logout.php" class="btn btn-danger">Sign Out of Your Account</a>
    </p>
    <form action="/stockSearch.php" method="GET">
      <fieldset>
        <legend>Search For a Stock</legend>
        Stock Ticker:<br>
        <input type="text" name="ticker" id = "ticker">
        <br>
        <input type="submit" value="Submit">
      </fieldset>
    </form>

    <script type="text/javascript">
        var request = new XMLHttpRequest();
        
        var url = 'https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=' //+ ticker + '&interval=5min&outputsize=full&apikey=demo';
        request.open('GET', 'https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=MSFT&interval=5min&outputsize=full&apikey=demo', true);

        request.onload = function() {
        // Begin accessing JSON data here
        var data = JSON.parse(this.response);
        console.log(data);
        }

        request.send();
    </script>
</body>
</html>