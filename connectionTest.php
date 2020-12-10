<?php
  $dbLink = mysql_connect("localhost:3306", "root", "mootcourt");
  if($dbLink) {
    echo "SUCCESS";
  } else {
    echo "FAILURE";
  }
?>
