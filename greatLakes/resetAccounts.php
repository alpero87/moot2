<?php


//	1 - scorer; 2 - admin/director

    include 'common.php';
    
    $newUa = 'eastern'; $newPa = 'director';
    $newUs = 'scorer'; $newPs = 'eastern';


    $dbLink = openConn();

	@mysql_query('DELETE FROM authentication WHERE tourney = "' . $tourneyID . '";', $dbLink);
	@mysql_query('INSERT INTO authentication SET tourney = "' . $tourneyID . '", name = AES_ENCRYPT("' . $newUa . '", "' . $encryptString . '"), password = AES_ENCRYPT("' . $newPa . '", "' . $encryptString . '"), class = "2";', $dbLink);
	@mysql_query('INSERT INTO authentication SET tourney = "' . $tourneyID . '", name = AES_ENCRYPT("' . $newUs . '", "' . $encryptString . '"), password = AES_ENCRYPT("' . $newPs . '", "' . $encryptString . '");', $dbLink);

	echo 'Done (' . $newUa . ').';

	@closeConn();


?>