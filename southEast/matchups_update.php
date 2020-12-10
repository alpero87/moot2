<?php
    include 'common.php';
    $whom = false; $pass = false; $userCode = false;    
    $userCode = verifySignIn();
    if (($userCode === false) || ($userCode < 2)) exit;
    
    if(isset($_GET['id'])) {
        $side = array("NOT-SET","Petitioner","Respondent","FLIP");
        $matchup = get_matchup($_GET['id']);
        $teams = get_teams_data();
    } else {
        if(isset($_POST['team'])) {
            update_matchup($_POST);   
        }
        header("Location:".$fullPath."/matchups.php?view=teams");
        exit();
    }

    function get_teams_data() {
        global $tourneyID;
        $dbLink = openConn();
        $teams = array();
        $sql = "select 
            teams.tourney as tournament_id, 
            teams.team_id as team_id, 
            teams.school_id as team_school_id,
            registration.school as team_school_name, 
            CONCAT(
        (select participants.name from participants where participants.student_id = teams.student_ID1),
        '<br />',
        (select participants.name from participants where participants.student_id = teams.student_ID2)
            ) as team_name
        from teams 
        inner join registration on
            teams.school_id = registration.id
        where
            teams.tourney = " . $tourneyID;
        $result = mysql_query($sql, $dbLink);
        while($rec = mysql_fetch_assoc($result)) {
            array_push($teams, array(
                'team_id'     => $rec['team_id'],
                'team_name'   => $rec['team_name'],
                'school_id'   => $rec['team_school'],
                'school_name' => $rec['team_school_name'],
            ));
        }
        closeConn($dbLink);
        return $teams;
    }
    
    function get_matchup($id) {
        $dbLink = openConn();
        $sql = "SELECT * FROM matchups WHERE team = ".$id;
        $records = mysql_query($sql, $dbLink);
        closeConn($dbLink);
        return mysql_fetch_assoc($records);
    }
    
    function update_matchup($matchup) {
        global $tourneyID;
        $newMatchup = "UPDATE `matchups` SET 
            oneTeam = '".$matchup['oneTeam']."', 
            oneTeamName = '".$matchup['oneTeamName']."',
            oneSchool = '".$matchup['oneSchool']."',
            oneSchoolName = '".$matchup['oneSchoolName']."',
            oneSide = '".$matchup['oneSide']."',
            oneMatch = '".$matchup['oneMatch']."',
            twoTeam = '".$matchup['twoTeam']."',
            twoTeamName = '".$matchup['twoTeamName']."',
            twoSchool = '".$matchup['twoSchool']."',
            twoSchoolName = '".$matchup['twoSchoolName']."',
            twoSide = '".$matchup['twoSide']."',
            twoMatch = '".$matchup['twoMatch']."',
            threeTeam = '".$matchup['threeTeam']."',
            threeTeamName = '".$matchup['threeTeamName']."',
            threeSchool = '".$matchup['threeSchool']."',
            threeSchoolName = '".$matchup['threeSchoolName']."',
            threeSide = '".$matchup['threeSide']."',
            threeMatch = '".$matchup['threeMatch']."'
        WHERE team = ".$matchup['team'];
        if($matchup['oneSide'] == 1) {
            $teamOneSide = 2;
        } else {
            $teamOneSide = 1;
        }
        $teamOne = "UPDATE `matchups` SET 
            oneTeam         = '".$matchup['team']."',
            oneTeamName     = '".$matchup['teamName']."',
            oneSchool       = '".$matchup['school']."',
            oneSchoolName   = '".$matchup['schoolName']."',
            oneSide         = '".$teamOneSide."',
            oneMatch        = '".$matchup['oneMatch']."'
        WHERE team = ".$matchup['oneTeam'];
        if($matchup['twoSide'] == 1) {
            $teamTwoSide = 2;
        } else {
            $teamTwoSide = 1;
        }
        $teamTwo = "UPDATE `matchups` SET 
            twoTeam         = '".$matchup['team']."',
            twoTeamName     = '".$matchup['teamName']."',
            twoSchool       = '".$matchup['school']."',
            twoSchoolName   = '".$matchup['schoolName']."',
            twoSide         = '".$teamTwoSide."',
            twoMatch        = '".$matchup['twoMatch']."'
        WHERE team = ".$matchup['twoTeam'];
        if($matchup['threeSide'] == 1) {
            $teamThreeSide = 1;
        } else {
            $teamThreeSide = 2;
        }
        $teamThree = "UPDATE `matchups` SET 
            threeTeam         = '".$matchup['team']."',
            threeTeamName     = '".$matchup['teamName']."',
            threeSchool       = '".$matchup['school']."',
            threeSchoolName   = '".$matchup['schoolName']."',
            threeSide         = '".$teamThreeSide."',
            threeMatch        = '".$matchup['threeMatch']."'
        WHERE team = ".$matchup['threeTeam'];
        $dbLink = openConn();
        print_r($roundsTable);
        mysql_query($newMatchup,  $dbLink);
        mysql_query($teamOne,     $dbLink);
        mysql_query($teamTwo,     $dbLink);
        mysql_query($teamThree,   $dbLink);
        closeConn($dbLink);
    }
    
    function teams_dropdown($round) {
        global $teams;
        global $matchup;
        $match = $round."Match";
        foreach($teams as $team) {
            if($team['team_id'] != $matchup['team']) {
                echo '<option value='.$team['team_id'];
                if($team['team_id'] == $matchup[$round.'Team']) {
                    echo " selected";
                }
                $str = str_replace('<br />',' && ',$team['team_name']);
                $str = $team['team_id'] . ': ' . $str;
                echo '>'.$str.'</option>';
            }
        }
    }
    
    function side_dropdown($round) {
        global $matchup;
        global $side;
        $match = $round."Side";
        for($i=0;$i<4;$i++) {
            if($matchup[$match] == $i) {
                $selected = " selected";
            } else {
                $selected = "";
            }
            echo '<option value="'.$i.'"'.$selected.'>'.$side[$i].'</option>';
        }
    }

?>

<html>
<head>
    <style>
        label {
            display: inline-block; 
            width: 100px;
        }
        div {
            margin-top: 5px;
        }
        select, input {
            width: 180px;
        }
        .hidden {
            display: none !important;
        }
    </style>
    <script>
        var data = <?php print_r(json_encode($teams)); ?>;
        var teams = {};
        data.forEach(t => {
            teams[t.team_id] = t;
        });
        function update_opponent(round) {
            console.log(round);
            var select = document.getElementById("select_"+round);
            var teamID = select.options[select.selectedIndex].value;
            console.log(teamID);
            document.getElementsByName(round+"Team"      )[0].value = teams[teamID]["team_id"    ];
            document.getElementsByName(round+"TeamName"  )[0].value = teams[teamID]["team_name"  ];
            document.getElementsByName(round+"School"    )[0].value = teams[teamID]["school_id"  ];
            document.getElementsByName(round+"SchoolName")[0].value = teams[teamID]["school_name"];
        }
        
    </script>
</head>
<body>
    <div style="margin-bottom:1em;margin-top:2em;">
        <span style="font-family:arial,helvetica,verdana,sans-serif;font-weight:bold;font-size:10px;color:rgb(0,0,0);">
            <a href="<?php echo $fullPathSA; ?>">Back to the admin page</a>
        </span>
    </div>
    <table border="0" width="840" cellpadding="0" cellspacing="0" style="margin-top:25px;">
        <col width="6" /><col width="200" /><col width="217" /><col width="417" />
        <tr>
            <td width="6" style="width:6px;background-color:rgb(100,0,0);">
            </td>
            <td width="834" style="width:834px;" colspan="3">
                <div style="margin-left:10px;">
                    <span class="redtext14"><?php echo $matchup['teamName']; ?></span>
                </div>
            </td> 
        </tr>
        <tr>
            <td width="840" height="1" style="height:1px;width:840px;background-color:rgb(100,0,0);" colspan="4">
            </td>
        </tr>
    </table>
    <form style="margin-left:5px;" action="<?php echo $fullPath."/matchups_update.php"; ?>" method="post">
        <div class="hidden">
            <label>Team ID</label>
            <input type="text" name="team" value="<?php echo $matchup['team']; ?>">
        </div>
        <div  class="hidden">
            <label>Team Name</label>
            <input type="text" name="teamName" value="<?php echo $matchup['teamName']; ?>" readonly>
        </div>
        <div class="hidden">
            <label>School ID</label>
            <input type="text" name="school" value="<?php echo $matchup['school']; ?>">
        </div>
        <div class="hidden">
            <label>School Name</label>
            <input type="text" name="schoolName" value="<?php echo $matchup['schoolName']; ?>">
        </div>
        <div>
            <b>Match One</b>
        </div>
        <div>
            <label>Match Number</label>
            <input type="text" name="oneMatch" value="<?php echo $matchup['oneMatch']; ?>">
        </div>
        <div>
            <label>Team's Side</label>
            <select name="oneSide">
                <?php side_dropdown('one'); ?>
            </select>
        </div>
        <div>
            <label>Opponent</label>
            <select onchange="update_opponent('one');" id="select_one">
                <?php teams_dropdown('one'); ?>
            </select>
        </div>
        <div class="hidden">
            <label>Team ID</label>
            <input type="text" name="oneTeam" value="<?php echo $matchup['oneTeam']; ?>">
        </div>
        <div class="hidden">
            <label>Team Name</label>
            <input type="text" name="oneTeamName" value="<?php echo $matchup['oneTeamName']; ?>">
        </div>
        <div class="hidden">
            <label>School ID</label>
            <input type="text" name="oneSchool" value="<?php echo $matchup['oneSchool']; ?>">
        </div>
        <div class="hidden">
            <label>School Name</label>
            <input type="text" name="oneSchoolName" value="<?php echo $matchup['oneSchoolName']; ?>">
        </div>
        <div>
            <b>Match Two</b>
        </div>
        <div>
            <label>Match Number</label>
            <input type="text" name="twoMatch" value="<?php echo $matchup['twoMatch']; ?>">
        </div>
        <div>
            <label>Team's Side</label>
            <select name="twoSide">
                <?php side_dropdown('two'); ?>
            </select>
        </div>
        <div>
            <label>Opponent</label>
            <select onchange="update_opponent('two');" id="select_two">
                <?php teams_dropdown('two'); ?>
            </select>
        </div>
        <div class="hidden">
            <label class="hidden">Team ID</label>
            <input type="text" name="twoTeam" value="<?php echo $matchup['twoTeam']; ?>">
        </div>
        <div class="hidden">
            <label>Team Name</label>
            <input type="text" name="twoTeamName" value="<?php echo $matchup['twoTeamName']; ?>">
        </div>
        <div class="hidden">
            <label>School ID</label>
            <input type="text" name="twoSchool" value="<?php echo $matchup['twoSchool']; ?>">
        </div>
        <div class="hidden">
            <label>School Name</label>
            <input type="text" name="twoSchoolName" value="<?php echo $matchup['twoSchoolName']; ?>">
        </div>
        <div>
            <b>Match Three</b>
        </div>
        <div>
            <label>Match Number</label>
            <input type="text" name="threeMatch" value="<?php echo $matchup['threeMatch']; ?>">
        </div>
        <div>
            <label>Team's Side</label>
            <select name="threeSide">
                <?php side_dropdown('three'); ?>
            </select>
        </div>
        <div>
            <label>Opponent</label>
            <select onchange="update_opponent('three');" id="select_three">
                <?php teams_dropdown('three'); ?>
            </select>
        </div>
        <div class="hidden">
            <label>Team ID</label>
            <input type="text" name="threeTeam" value="<?php echo $matchup['threeTeam']; ?>">
        </div>
        <div class="hidden">
            <label>Team Name</label>
            <input type="text" name="threeTeamName" value="<?php echo $matchup['threeTeamName']; ?>">
        </div>
        <div class="hidden">
            <label>School ID</label>
            <input type="text" name="threeSchool" value="<?php echo $matchup['threeSchool']; ?>">
        </div>
        <div class="hidden">
            <label>School Name</label>
            <input type="text" name="threeSchoolName" value="<?php echo $matchup['threeSchoolName']; ?>">
        </div>
        <button style="margin-top:10px;" type="submit" value="Submit">Save Team Matchup</button>
    </form> 
</body>
</html>

