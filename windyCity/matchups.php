<?php
    include 'common.php';
    $userCode = false;    
    $userCode = verifySignIn();
    if (($userCode === false) || ($userCode < 2)) { 
        header('Location: '. $fullPath . '?v=' . $userCode);
        exit;
    }
?>
<html>
<head>
    <META 
        NAME="Author"
        CONTENT="mootcourt.fsc.edu"
    >
    <META
        NAME="Keywords"
        CONTENT="acma moot court mootcourt simulation court Supreme Court Simulation scholastic moot court court tournaments"
    >
    <META
        NAME="Description"
        CONTENT="infomation about moot courts or mootcourts also known as mock supreme courts or simulation courts"
    >
    <META
        NAME="distribution"
        CONTENT="global"
    >
    <META 
        NAME="resource-type"
        CONTENT="document"
    >
    <META 
        NAME="language"
        CONTENT="en"
    >
    <title>
        American Collegiate Moot Court Association
    </title>
    <style>
        #buttons { 
            display: table; 
        }
        .hidden { 
            display: none; 
        }
        .redtext14 { 
            font-weight: bold;
            font-family: arial, helvetica, verdana, sans-serif;
            font-size: 14px;
            color:rgb(100,0,0);
       }
       .blktext10 { 
            font-family: arial, helvetica, verdana, sans-serif;
            font-weight: bold;
            font-size: 10px;
            color:rgb(0,0,0);
        }
    </style>
    <script 
        type="text/javascript" 
        src="scripts.js"
    ></script>
    <script>
        function getMatchups(method = "GET") {
            var xmlhttp = new XMLHttpRequest();
            var view = "<?php echo $_GET['view']; ?>";
            if (view === "post") {
                method = "POST";
            }
            xmlhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                    if (view === "post") {
                        window.location.href = "matchups.php";
                    } else {
                        document.getElementById("content").innerHTML = this.responseText;
                        if(view === "teams") { 
                            showTeams(); 
                        }
                    }
                }
            };
            xmlhttp.open(method, "matchups_generate.php");
            xmlhttp.send();
        }
        function showRounds() {
            document.getElementById("rounds").classList.remove('hidden');
            document.getElementById("teamsList").classList.add('hidden');
            document.getElementById("showRoundsBTN").classList.add('hidden');
            document.getElementById("showTeamsBTN").classList.remove('hidden');
        }
        function showTeams() {
            document.getElementById("rounds").classList.add('hidden');
            document.getElementById("teamsList").classList.remove('hidden');
            document.getElementById("showRoundsBTN").classList.remove('hidden');
            document.getElementById("showTeamsBTN").classList.add('hidden');
        }
    </script>
</head>
<body onload="getMatchups();">
    <table border="0" width="840" cellpadding="0" cellspacing="0">
        <col width="140" />
        <col width="140" />
        <col width="140" />
        <col width="140" />
        <col width="140" />
        <col width="140" />
        <tr>
            <td width="628" height="137" valign="bottom" colspan="2" style="width:840px;vertical-align:bottom;">
                <img border="0" src="court_1.jpg" width="229" height="161" alt="Court house image" style="margin-right:20px;">
            </td>
            <td width="628" height="137" valign="bottom" colspan="4" style="width:840px;vertical-align:bottom;">
                <div style="margin-bottom:10px;">
                    <span style="font-family:arial;font-weight:bold;font-size:36px;color:rgb(100,0,0);">
                        American Collegiate<br />
                        Moot Court Association
                    </span>
                </div>
            </td>
        </tr>
        <tr>
            <td width="140" height="14" valign="bottom" style="background-color:rgb(100,0,0);color:white;width:140px;vertical-align:middle;">
                <div style="margin-top:5px;margin-bottom:5px;text-align:center;width:140px;">
                    <span style="font-family:arial;font-weight:bold;font-size:12px;">
                        <a style="color:white;" target="_self" href="http://honors.uta.edu/mootcourt/" title="Go to the American Collegiate Moot Court Association home page">
                            ACMA Home
                        </a>
                    </span>
                </div>
            </td>
            <td width="700" height="14" valign="bottom" style="background-color:rgb(100,0,0);color:white;width:700px;vertical-align:middle;" colspan="3">
                <div style="margin-top:5px;margin-bottom:5px;text-align:center;width:700px;"></div>
            </td>
        </tr>
    </table>
    <div style="margin-bottom:1em;margin-top:2em;">
        <span class="blktext10">
            <a href="<?php echo $fullPathSA; ?>">
                Back to the admin page
            </a>
        </span>
    </div>
    <!--
    <div id="buttons">
        <button id="showRoundsBTN" class="hidden" onclick="showRounds();">
            Show Rounds
        </button>
        <button id="showTeamsBTN" onclick="showTeams();">
            Show Teams List
        </button>
        <div style="display:inline-block; width: 400px">
        </div>
        <button onclick="getMatchups('POST');">
            New Matchups
        </button>
    </div>
    -->
    <div id="content">
    </div>
</body>
</html>

