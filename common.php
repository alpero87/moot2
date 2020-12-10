<?php

//  Windows server support is untested and should not be used until officially tested.
    $usingWindows = false;
    $mysqlServer = 'http://mootcourt.fsc.edu:3306'; //   Used only when MySQL database is hosted on a Windows computer. This is the server address and appropriate port. The default port is 3306.


    $mysqlUser = 'root'; //  mysql account name for access
    $mysqlPass = ''; //  mysql account password for access
//    $encryptString = 'Ch33seW1z';  //  String used to encrypt db data and cookies     -   SOUTHWEST
//    $encryptString = 'cH33SEw1Z';  //  String used to encrypt db data and cookies       -   SOUTHEAST
    $encryptString = 'v2rB6Jn26MxMH5Nk';  //  String used to encrypt db data and cookies     -   EASTERN
//    $encryptString = 'dTz7T6ARSKTWFKjW';  //  String used to encrypt db data and cookies     -   MIDWEST
//    $encryptString = 'Km74r6f3Y56e5atH';  //  String used to encrypt db data and cookies     -   UPPER MIDWEST
//    $encryptString = 'k82HV3ztcTwzy6eX';  //  String used to encrypt db data and cookies     -   WESTERN
//    $encryptString= 'doppelgaenger';    //  -   Test 

/*
      Remove the trailing slash from the next two vars.
      Search all the pages and see if the var is used by itself (add the trailing slash) or in conjunction with $_SERVER['REQUEST_URI'] (no slash)
*/
    $serverPath = 'http://mootcourt.fsc.edu/';
    $serverPathS = 'http://mootcourt.fsc.edu/';
    $shortPath = '';
    $shortPathA = '';
    $fullPath = 'http://mootcourt.fsc.edu/eastern/';
    $fullPathS = 'http://mootcourt.fsc.edu/eastern/';
    $fullPathSA = 'http://mootcourt.fsc.edu/eastern/';

//  If using LDAP for authentication, populate the variables below with the correct information.
//  To authenticate against multiple trees, separate them with semicolons (<string1>;<string2>;<string3>
//  In $ldapKey#, the string $NAME$ will be replaced with the provided username
    $ldapServer1 = 'ldap1.server.addr'; $ldapKey1 = 'CN=$NAME$;CN=$NAME$'; $ldapS1String = 'OU=group3,OU=group2,DC=group,DC=top;OU=group4,OU=group2,DC=group,DC=top;';
    $ldapServer2 = 'ldap1.server.addr'; $ldapKey2 = 'CN=$NAME$;CN=$NAME$'; $ldapS2String = 'OU=group3,OU=group2,DC=group,DC=top;OU=group4,OU=group2,DC=group,DC=top;';
    $ldapServer3 = 'ldap1.server.addr'; $ldapKey3 = 'CN=$NAME$;CN=$NAME$'; $ldapS3String = 'OU=group3,OU=group2,DC=group,DC=top;OU=group4,OU=group2,DC=group,DC=top;';
    
    header('Cache-control: no-cache;'); header('Pragma: no-cache;');
    

    if (isset($_COOKIE['acmaTourney'])) { $tourneyID = intval($_COOKIE['acmaTourney']); } else { $tourneyID = 3; }
//  change default value to -1 to force entering the system through a subdirectory that actually sets the cookie.
    
    
    function setCryptoVar()
    {
        $dbLink = openConn();
        $result = mysql_query('SELECT @crypto;', $dbLink); $data = mysql_fetch_row($result); @mysql_free_result($result);
        if (strlen($data[0]) == 0)
        { $result = mysql_query('SET @crypto = "' . mysql_real_escape_string($encryptString) . '";', $dbLink); @mysql_free_result($result); }
        $result = mysql_query('SELECT @crypto;', $dbLink); $data = mysql_fetch_row($result); @mysql_free_result($result);
        return (false || (strlen($data[0]) != 0));
    }



    function ldapSearch($user, $pass, $ldap, $key, $datum)
    {
        $key = str_replace('$NAME$', $user, $key);
        $data = explode(';', $datum); $keys = explode(';', $key); $skipFlag = false;
        for ($indx = 0; $indx < sizeof($passes); $indx++)
        {
            if (!$skipFlag)
            {
                $result = ldap_bind($ldap, $data[$indx] . ',' . $data[$indx], $pass); $result2 = false;
                if ($result === false) { $result2 = ldap_search($ldap, $data[$indx], $keys[$indx]); } else { $skipFlag = true; }
                if ($result2 !== false) { $skipFlag = true; }
            }
        }
        return $skipFlag;
    }



    function useLDAP($user, $pass)  //      Returns TRUE if authentication is successful.
    {
        global $ldapServer1, $ldapKey1, $ldapS1String, $ldapServer2, $ldapKey2, $ldapS2String, $ldapServer3, $ldapKey3, $ldapS3String;
        $sendBack = false; $ldapconn = false; $errLevel = error_reporting(1); // Set error reporting to Fatal only.
        $abortFlag = false; $continueFlag = false;
        if ((strlen($ldapServer1) > 0) && (strlen($ldapS1String) > 0))
        {
            $ldapconn = ldap_connect($ldapServer1);
            if ($ldapconn !== false)
            {
                $resultant = ldapSearch($user, $pass, $ldapconn, $ldapKey1, $ldapString1);
                if ($result !== false) { $continueFlag = true; }
            }
        }
        if ((strlen($ldapServer2) > 0) && (strlen($ldapS2String) > 0) && !$continueFlag)
        {
            $ldapconn = ldap_connect($ldapServer2);
            if ($ldapconn !== false)
            {
                $resultant = ldapSearch($user, $pass, $ldapconn, $ldapKey2, $ldapString2);
                if ($result !== false) { $continueFlag = true; }
            }
        }
        if ((strlen($ldapServer3) > 0) && (strlen($ldapS3String) > 0) && !$continueFlag)
        {
            $ldapconn = ldap_connect($ldapServer3);
            if ($ldapconn !== false)
            {
                $resultant = ldapSearch($user, $pass, $ldapconn, $ldapKey3, $ldapString3);
                if ($result !== false) { $continueFlag = true; }
            }
        }
        @ldap_unbind($ldapconn); @error_reporting($errLevel);
        return $continueFlag; 
    }




    function testMySQL()
    {
        global $usingWindows, $mysqlServer, $mysqlUser, $mysqlPass;
        $settingWas = error_reporting(0);
        if ($usingWindows)
        { $dbLink = mysql_connect( $mysqlServer, $mysqlUser, $mysqlPass ); }
        else
        { $dbLink = mysql_connect( 'localhost', $mysqlUser, $mysqlPass ); }
		@error_reporting($settingWas);
        return $dbLink;
    }




    function openConn()
    {
        global $usingWindows, $mysqlServer, $mysqlUser, $mysqlPass;
        if ($usingWindows)
        { $dbLink = mysql_connect( $mysqlServer, $mysqlUser, $mysqlPass ); }
        else
        { $dbLink = mysql_connect( 'localhost', $mysqlUser, $mysqlPass ); }

        if (mysql_errno() != 0) { exit( mysql_error() . ' (' . mysql_errno() . ') '); }
        $dbSelected = mysql_select_db('mootcourt');
//        $result .= mysql_error() . ' (' . mysql_errno() . ')';
//        echo $result;
        return $dbLink;
    }


    function closeConn($dbConn) { @mysql_close($dbConn); }





    function checkCredentials($user, $pass)
    {   //  Returns 1 if scorer/reviewer, False is not present, 2 if administrator.
        global $dbLink, $encryptString, $tourneyID;
        $result = mysql_query('SELECT AES_ENCRYPT("' . mysql_real_escape_string(trim($user)) . '", "' . $encryptString . '"), AES_ENCRYPT("' . mysql_real_escape_string(trim($pass)) . '", "' . $encryptString . '");', $dbLink);
        $data = mysql_fetch_row($result); @mysql_free_result($result); $continueFlag = false;
        $result = mysql_query('SELECT * FROM authentication WHERE name = "' . mysql_real_escape_string($data[0]) . '" AND password = "' . mysql_real_escape_string($data[1]) . '" AND tourney = "' . $tourneyID . '" AND class > "0";', $dbLink);
        if (mysql_num_rows($result) == 0) { @mysql_free_result($result); $result = mysql_query('SELECT * FROM authentication WHERE name = "' . mysql_real_escape_string($data[0]) . '" AND tourney = "' . $tourneyID . '" AND class > "0";', $dbLink); }
        if (mysql_num_rows($result) == 1)
        {
            $data = mysql_fetch_assoc($result); @mysql_free_result($result);
            if ($data['useLDAP'] == 1)
            { $continueFlag = useLDAP($user, $pass); }
            else
            { $continueFlag = true; }
            if ($continueFlag) { return $data['class']; }
            @mysql_free_result($result);
        }
        else
        { return false; }
    }



    function checkCookies()
    {   //  Returns False if not present, Class property if true.
        global $dbLink, $encryptString, $tourneyID;
        $result = mysql_query('SELECT * FROM authentication WHERE SHA1(AES_ENCRYPT(CONCAT(AES_DECRYPT(name,"' . $encryptString . '"),AES_DECRYPT(password,"' . $encryptString . '")),"' . $encryptString . '")) = "' . $_COOKIE['acmaHash'] . '"  AND tourney = "' . $tourneyID . '" AND class > "0";', $dbLink);
//        echo 'SELECT * FROM authentication WHERE SHA1(AES_ENCRYPT(CONCAT(AES_DECRYPT(name,"' . $encryptString . '"),AES_DECRYPT(password,"' . $encryptString . '")),"' . $encryptString . '")) = "' . $_COOKIE['acmaHash'] . '"  AND tourney = "' . $tourneyID . '" AND class > "0";'; exit;
        if (mysql_num_rows($result) == 1)
        {
            $data = mysql_fetch_assoc($result); @mysql_free_result($result);
            if ($data['useLDAP'] == 1)
            { $continueFlag = useLDAP($data[0], $data[1]); }
            else
            { $continueFlag = true; }
            if ($continueFlag) { return $data['class']; }
            @mysql_free_result($result);
        }
        else
        { return false; }
    }




    function verifySignIn()
    {
        global $dbLink;
        if (isset($_COOKIE['acmaHash']))
        { $dbLink = openConn(); $userCode = checkCookies(); @closeConn($dbLink); return $userCode; }
        else
        {  return false; }
    }









    function encryptString($datum)
    {
        global $dbLink;
        $datum = mysql_escape_string($datum);
        $result = mysql_query('SELECT AES_ENCRYPT("' . $datum . '", "' . $encryptString . '");', $dbLink); unset($data); $data = mysql_fetch_row($result); @mysql_free_result($result);
        return $data[0]; unset($data);
    }





    function decryptString($datum)
    {
        global $dbLink;
        $datum = mysql_escape_string($datum);
        $result = mysql_query('SELECT AES_DECRYPT("' . $datum . '", "' . $encryptString . '");', $dbLink); unset($data); $data = mysql_fetch_row($result); @mysql_free_result($result);
        return $data[0]; unset($data);
    }




?>
