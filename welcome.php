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

    <head>
    <style>
    table, th, td {
      border: 1px solid black;
    }
    </style>
    </head>
    
    <table align="center">
      <caption><?php echo $_SESSION["username"];?> Portfolio</caption>
      <tr>
        <th>Stock</th>
        <th>Purchase Price</th>
        <!--<th>Current Price</th>
        <th>Margin</th>-->
      </tr>
      <tr>



        <?php
            $servername = "localhost";
            $username = "root";
            $password = "PKswims83";
            $dbname = "stockSchema";

            mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

            $conn = new mysqli($servername, $username, $password);

            mysqli_select_db($conn, $dbname) or die("Could not open the '$dbname'");

            $user = $_SESSION["username"];

            $query = "SELECT * FROM owns WHERE username = '$user'";
            $result = mysqli_query($conn, $query);


            while($row = mysqli_fetch_array($result)) {
                echo 
                    "<tr>
                        <td> $row[1]</td><td> $row[2]</td>
                    </tr>";

            }

        ?>
    </table>
</body>
</html>