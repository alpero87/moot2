<?php
    include 'common.php';
    $whom = false; $pass = false; $userCode = false;    
    $userCode = verifySignIn();
    if (($userCode === false) || ($userCode < 2)) exit;
    /*****************************************************************/
    $method = $_SERVER['REQUEST_METHOD'];
    $side   = array("NOT-SET","Petitioner","Respondent","FLIP");
    $emptyTeams = array();
    $teams  = array();
    if($method == "GET") {
        $teams = get_matchups();
        $save = false;
        if(empty($teams)) {
            build_teams_array();
            $teamcount = count($teams);
            compute_rounds();
            save_matchups();
        } else {
            $teamcount = count($teams);
        }
    }
    if($method == "POST") {
        build_teams_array();
        $teamcount = count($teams);
        compute_rounds();
        save_matchups();
    }
    display_rounds();
    /*****************************************************************/
    
    function save_matchups() {
        global $tourneyID;
        global $teams;
        $dbLink = openConn();
        $oneDone = array();
        $twoDone = array();
        $threeDone = array();
        $matches = array();
        mysql_query('DELETE FROM matchups WHERE tourney = "' . $tourneyID . '";', $dbLink);
        foreach($teams as $team) {
            mysql_query(
                "INSERT INTO matchups (
                    `tourney`,
                    `team`,
                    `teamName`,
                    `school`,
                    `schoolName`,
                    `oneTeam`,
                    `oneTeamName`,
                    `oneSchool`,
                    `oneSchoolName`,
                    `oneSide`,
                    `oneMatch`,
                    `twoTeam`,
                    `twoTeamName`,
                    `twoSchool`,
                    `twoSchoolName`,
                    `twoSide`,
                    `twoMatch`,
                    `threeTeam`,
                    `threeTeamName`,
                    `threeSchool`,
                    `threeSchoolName`,
                    `threeSide`,
                    `threeMatch`
                ) VALUES (
                    '".$tourneyID               ."',
                    '".mysql_real_escape_string($team['team'])            ."',
                    '".mysql_real_escape_string($team['teamName'])        ."',
                    '".mysql_real_escape_string($team['school'])          ."',
                    '".mysql_real_escape_string($team['schoolName'])      ."',
                    '".mysql_real_escape_string($team['oneTeam'])         ."',
                    '".mysql_real_escape_string($team['oneTeamName'])     ."',
                    '".mysql_real_escape_string($team['oneSchool'])       ."',
                    '".mysql_real_escape_string($team['oneSchoolName'])   ."',
                    '".mysql_real_escape_string($team['oneSide'])         ."',
                    '".mysql_real_escape_string($team['oneMatch'])        ."',
                    '".mysql_real_escape_string($team['twoTeam'])         ."',
                    '".mysql_real_escape_string($team['twoTeamName'])     ."',
                    '".mysql_real_escape_string($team['twoSchool'])       ."',
                    '".mysql_real_escape_string($team['twoSchoolName'])   ."',
                    '".mysql_real_escape_string($team['twoSide'])         ."',
                    '".mysql_real_escape_string($team['twoMatch'])        ."',
                    '".mysql_real_escape_string($team['threeTeam'])       ."',
                    '".mysql_real_escape_string($team['threeTeamName'])   ."',
                    '".mysql_real_escape_string($team['threeSchool'])     ."',
                    '".mysql_real_escape_string($team['threeSchoolName']) ."',
                    '".mysql_real_escape_string($team['threeSide'])       ."',
                    '".mysql_real_escape_string($team['threeMatch'])      ."'
                ) ON DUPLICATE KEY UPDATE
                        `tourney`         = '".$tourneyID
                    ."',`team`            = '".mysql_real_escape_string($team['team'])
                    ."',`teamName`        = '".mysql_real_escape_string($team['teamName'])
                    ."',`school`          = '".mysql_real_escape_string($team['school'])
                    ."',`schoolName`      = '".mysql_real_escape_string($team['schoolName'])
                    ."',`oneTeam`         = '".mysql_real_escape_string($team['oneTeam'])
                    ."',`oneTeamName`     = '".mysql_real_escape_string($team['oneTeamName'])
                    ."',`oneSchool`       = '".mysql_real_escape_string($team['oneSchool'])
                    ."',`oneSchoolName`   = '".mysql_real_escape_string($team['oneSchoolName'])
                    ."',`oneSide`         = '".mysql_real_escape_string($team['oneSide'])
                    ."',`oneMatch`        = '".mysql_real_escape_string($team['oneMatch'])
                    ."',`twoTeam`         = '".mysql_real_escape_string($team['twoTeam'])
                    ."',`twoTeamName`     = '".mysql_real_escape_string($team['twoTeamName'])
                    ."',`twoSchool`       = '".mysql_real_escape_string($team['twoSchool'])
                    ."',`twoSchoolName`   = '".mysql_real_escape_string($team['twoSchoolName'])
                    ."',`twoSide`         = '".mysql_real_escape_string($team['twoSide'])
                    ."',`twoMatch`        = '".mysql_real_escape_string($team['twoMatch'])
                    ."',`threeTeam`       = '".mysql_real_escape_string($team['threeTeam'])
                    ."',`threeTeamName`   = '".mysql_real_escape_string($team['threeTeamName'])
                    ."',`threeSchool`     = '".mysql_real_escape_string($team['threeSchool'])
                    ."',`threeSchoolName` = '".mysql_real_escape_string($team['threeSchoolName'])
                    ."',`threeSide`       = '".mysql_real_escape_string($team['threeSide'])
                    ."',`threeMatch`      = '".mysql_real_escape_string($team['threeMatch'])
                    ."'"
            , $dbLink);
            if(
                !(
                    in_array($team['team'], $oneDone) || 
                    in_array($team['oneTeam'], $oneDone)
                ) && $team['oneSide'] == 1
            ) {
                array_push($oneDone, $team['team'], $team['oneTeam']);
                array_push(
                    $matches,
                    array("m"=>-1,"a"=>$team['team'],"b"=>$team['oneTeam'])
                );
            }
            if(
                !(
                    in_array($team['team'], $twoDone) || 
                    in_array($team['twoTeam'], $twoDone)
                ) && $team['twoSide'] == 1
            ) {
                array_push($twoDone, $team['team'], $team['twoTeam']);
                array_push(
                    $matches,
                    array("m"=>-2,"a"=>$team['team'],"b"=>$team['twoTeam'])
                );
            }
            if(
                !(
                    in_array($team['team'], $threeDone) || 
                    in_array($team['threeTeam'], $threeDone)
                )
            ) {
                array_push($threeDone, $team['team'], $team['threeTeam']);
                array_push(
                    $matches,
                    array("m"=>-3,"a"=>$team['team'],"b"=>$team['threeTeam'])
                );
            }
        }
        mysql_query('DELETE FROM rounds WHERE tourney = "' . $tourneyID . '";', $dbLink);
        foreach($matches as $match) {
            mysql_query(
                "INSERT INTO rounds (`tourney`, `round`, `team1`, `team2`) VALUES (".$tourneyID.",".$match['m'].",".$match['a'].",".$match['b'].")"
                , $dbLink
            );
        }
        closeConn($dbLink);
    }
    
    function get_matchups() {
        global $tourneyID;
        global $teams;
        $dbLink = openConn();
        $matchups = array();
        $sql = "SELECT * FROM matchups WHERE tourney = ".$tourneyID;
        $records = mysql_query($sql, $dbLink);
        while($row = mysql_fetch_assoc($records)) {
            array_push($matchups, $row);
        }
        closeConn($dbLink);
        return $matchups;
    }
    
    function get_teams_data() {
        global $tourneyID;
        $dbLink = openConn();
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
        closeConn($dbLink);
        return $result;
    }
    
    function build_teams_array() {
        global $teams;
        $teams = array();
        $records = get_teams_data();
        while($row = mysql_fetch_assoc($records)) { 
            array_push($teams, array(
                "tournament"      => intval($row['tournament_id']),
                "team"            => intval($row['team_id']), 
                "teamName"        => $row['team_name'],
                "school"          => intval($row['team_school_id']),
                "schoolName"      => $row['team_school_name'],
                "oneTeam"         => 0,
                "oneTeamName"     => "No Opponent",
                "oneSchool"       => 0,
                "oneSchoolName"   => "No Opponent",
                "oneSide"         => 0,
                "twoTeam"         => 0,
                "twoTeamName"     => "No Opponent",
                "twoSchool"       => 0,
                "twoSchoolName"   => "No Opponent",
                "twoSide"         => 0,
                "threeTeam"       => 0,
                "threeTeamName"   => "No Opponent",
                "threeSchool"     => 0,
                "threeSchoolName" => "No Opponent",
                "threeSide"       => 0
            ));
        }
    }

    function compute_rounds() {
        global $teams;
        $teamcount = count($teams);
        $retries = 99;
        $cont = true;
        shuffle($teams);
        round_one_processing();
        shuffle($teams);
        round_two_processing();
        while($cont) {
            shuffle($teams);
            $valid = round_three_processing();
            if($valid || $retries < 0) {
                $cont = false;
            }
            --$retries;
        }
    }
    
    function round_one_processing() {
        global $teams;
        global $teamcount;
        $ids = array();
        $poss = array();
        for($a=0; $a < $teamcount/2; $a++) {
            array_push($ids,$teams[$a]['team']);
            $poss[$teams[$a]['team']] = array();
        }
        for($i=0; $i < $teamcount; $i++) {
            if(in_array($teams[$i]['team'],$ids)) {
                for($j=0; $j < $teamcount; $j++) {
                    if (
                        $teams[$i]['team']       != $teams[$j]['team']       && // team cannot play themselves
                        $teams[$i]['schoolName'] != $teams[$j]['schoolName'] && // team cannot play same school
                        !in_array($teams[$j]['team'],$ids)
                    ) {
                        array_push($poss[$teams[$i]['team']],$teams[$j]['team']);
                    }
                }
            }
        }
        $state = array();
        foreach($poss as $p) {
            array_push($state,$p);
        }
        $counter = 0;
        $matchNumber = 0;
        $decisions = compute_state_v3($state);
        $teamsDecided = array();
        foreach($decisions as $decision) {
            $i = find_team_index_by_id($ids[$counter]);
            $j = find_team_index_by_id($decision[0]);
            $counter++;
            if(!(in_array($i,$teamsDecided) && in_array($j,$teamsDecided))) {
                $matchNumber++;
                array_push($teamsDecided,$i,$j);
                $teams[$i]['oneTeam']       = $teams[$j]['team'];
                $teams[$j]['oneTeam']       = $teams[$i]['team'];
                $teams[$i]['oneSchool']     = $teams[$j]['school'];
                $teams[$j]['oneSchool']     = $teams[$i]['school'];
                $teams[$i]['oneTeamName']   = $teams[$j]['teamName'];
                $teams[$j]['oneTeamName']   = $teams[$i]['teamName'];
                $teams[$i]['oneSchoolName'] = $teams[$j]['schoolName'];
                $teams[$j]['oneSchoolName'] = $teams[$i]['schoolName'];
                $teams[$i]['oneMatch']      = $matchNumber;
                $teams[$j]['oneMatch']      = $matchNumber;
                $teams[$i]['oneSide']       = 2;
                $teams[$j]['oneSide']       = 1;
            }
        }
    }

    function round_two_processing() {
        global $teams;
        global $teamcount;
        $ids = array();
        $possibilities = array();
        for($a=0; $a < $teamcount; $a++) {
            if($teams[$a]['oneSide'] == 1) {
                array_push($ids,$teams[$a]['team']);
                $possibilities[$teams[$a]['team']] = array();
            }
        }
        for($i=0; $i < $teamcount; $i++) {
            for($j=0; $j < $teamcount; $j++) {
                if (
                    $teams[$i]['team']       != $teams[$j]['team']       && // team cannot play themselves
                    $teams[$i]['schoolName'] != $teams[$j]['schoolName'] && // team cannot play same school
                    $teams[$i]['oneTeam']    != $teams[$j]['team']       && // cannot play the same team twice
                    $teams[$i]['oneSide']    == 1                        && // teams must switch sides
                    $teams[$j]['oneSide']    == 2
                ) {
                    array_push($possibilities[$teams[$i]['team']],$teams[$j]['team']);
                }
            }
        }
        $state = array();
        foreach($possibilities as $possibility) {
            array_push($state,$possibility);
        }
        $counter = 0;
        $decisions = compute_state_v3($state);
        foreach($decisions as $decision) {
            $i = find_team_index_by_id($ids[$counter]);
            $j = find_team_index_by_id($decision[0]);
            $counter++;
            $teams[$i]['twoTeam']       = $teams[$j]['team'];
            $teams[$j]['twoTeam']       = $teams[$i]['team'];
            $teams[$i]['twoSchool']     = $teams[$j]['school'];
            $teams[$j]['twoSchool']     = $teams[$i]['school'];
            $teams[$i]['twoTeamName']   = $teams[$j]['teamName'];
            $teams[$j]['twoTeamName']   = $teams[$i]['teamName'];
            $teams[$i]['twoSchoolName'] = $teams[$j]['schoolName'];
            $teams[$j]['twoSchoolName'] = $teams[$i]['schoolName'];
            $teams[$i]['twoMatch']      = $counter;
            $teams[$j]['twoMatch']      = $counter;
            $teams[$i]['twoSide']       = 2;
            $teams[$j]['twoSide']       = 1;
        }
    }

    function round_three_processing() {
        global $teams;
        global $teamcount;
        $counter = 0;
        $decided = array();
        for($i=0;$i<$teamcount;$i++) {
            for($j=0;$j<$teamcount;$j++) {
                if(
                    $teams[$i]['team']       != $teams[$j]['team']       && // team cannot play themselves
                    $teams[$i]['schoolName'] != $teams[$j]['schoolName'] && // team cannot play same school
                    $teams[$i]['oneTeam']    != $teams[$j]['team']       && // cannot play the same team twice
                    $teams[$i]['twoTeam']    != $teams[$j]['team']       && // cannot play the same team twice
                    !in_array($teams[$i]['team'],$decided) && !in_array($teams[$j]['team'], $decided)
                ) {
                    array_push($decided, $teams[$i]['team'], $teams[$j]['team']);
                    $counter = $counter + 1;
                    $teams[$i]['threeTeam']       = $teams[$j]['team'];
                    $teams[$j]['threeTeam']       = $teams[$i]['team'];
                    $teams[$i]['threeSchool']     = $teams[$j]['school'];
                    $teams[$j]['threeSchool']     = $teams[$i]['school'];
                    $teams[$i]['threeTeamName']   = $teams[$j]['teamName'];
                    $teams[$j]['threeTeamName']   = $teams[$i]['teamName'];
                    $teams[$i]['threeSchoolName'] = $teams[$j]['schoolName'];
                    $teams[$j]['threeSchoolName'] = $teams[$i]['schoolName'];
                    $teams[$i]['threeMatch']      = $matchNumber;
                    $teams[$j]['threeMatch']      = $matchNumber;
                    $teams[$i]['threeSide']       = 3;
                    $teams[$j]['threeSide']       = 3;
                    $teams[$i]['threeMatch']      = $counter;
                    $teams[$j]['threeMatch']      = $counter;
                }
            }
        }
        if(count($decided) != $teamcount) {
            return false;
        } else {
            return true;
        }
    }
    
    function compute_state_v3($state, $decisions = array(), $x = 0, $y = 0) {
        if($x < 0 || $x > count($state)) {
            echo "{'error':'no valid matches'}";
            exit();
        } else {
            $decisions[$x] = $state[$x][$y];
            $testState = compute_new_state_v3($state, $decisions);
            if(is_state_valid_v2($testState)) {
                if(is_state_finished($testState)) {
                    return $testState;
                } else {
                    return compute_state_v3($state, $decisions, ++$x);
                }
            } else {
                $count = count($state[$x]);
                if($y >= $count) {
                    $nx = --$x;
                    $ny = array_search($state[$nx+1],$decisions[$nx+1])+1;
                    while($ny >= $count) {
                        $ny = array_search($state[$nx+1],$decisions[$nx+1])+1;
                        $nx = $nx - 1;
                        if($nx < 0) {
                            echo "{'error':'no valid matches'}";
                            exit();
                        }
                    }
                    return compute_state_v3($state, $decisions, $nx, $ny);
                } else {
                    return compute_state_v3($state, $decisions, $x, ++$y);
                }
            }
        }
    }
    
    function compute_new_state_v3($state, $decisions) {
        $newState = $state;
        for($x=0; $x<count($decisions); $x++) {
            for($y=0; $y<count($newState); $y++) {
                if(in_array($decisions[$x],$newState[$y])) {
                    unset($newState[$y][array_search($decisions[$x],$newState[$y])]);
                }
            }
        }
        for($x=0; $x<count($decisions); $x++) {
            if($decisions[$x]) {
                $newState[$x] = array($decisions[$x]);
            }
        }
        for($x=0; $x<count($newState); $x++) {
            $newState[$x] = array_values($newState[$x]);
        }
        return $newState;
    }
    
    function compute_state_v2($state, $decisions = array(), $x = 0, $y = 0) {
        if($x < 0) {
            echo "{'error':'no valid matches'}";
            exit();
        }
        if($x > count($decisions)) {
            unset($decisions[$x]);
        }
        $new_decisions = $decisions;
        $new_state = build_new_state($state, $new_decisions, $x, $y);
        array_push($new_decisions, $new_state[$x][$y]);
        $new_state = build_new_state($state, $new_decisions, $x, $y);
        if(is_state_valid_v2($new_state)) {
            if(is_state_finished($new_state)) {
                return $new_state;
            } else {
                // if($x >= count($state))
                // unreachable condition
                return compute_state_v2($state, $new_decisions, ++$x, $y);
            }
        } else {
            if($y >= count($state[0])) {
                return compute_state_v2($state, $decisions, --$x);
            } else {
                return compute_state_v2($state, $decisions, $x, ++$y);
            }
        }
    }
    
    function compute_state($state, $decisions = array(), $x = 0, $y = 0) {
        if($x < 0) {
            echo "{'error':'no valid matches'}";
            exit();
        }
        if($x > count($decisions)) {
            unset($decisions[$x]);
        }
        $new_decisions = $decisions;
        $new_state = build_new_state($state, $new_decisions, $x, $y);
        array_push($new_decisions, $new_state[$x][$y]);
        $new_state = build_new_state($state, $new_decisions, $x, $y);
        if(is_state_valid($new_state)) {
            if(is_state_finished($new_state)) {
                return $new_state;
            } else {
                // if($x >= count($state))
                // unreachable condition
                return compute_state($state, $new_decisions, ++$x, $y);
            }
        } else {
            if($y >= count($state[0])) {
                return compute_state($state, $decisions, --$x);
            } else {
                return compute_state($state, $decisions, $x, ++$y);
            }
        }
    }

    function find_team_index_by_id($id) {
        global $teams;
        global $teamcount;
        for($i=0; $i<$teamcount; $i++) {
            if($teams[$i]['team'] == $id) {
                return $i;
            }
        }
        return false;
    }
    
    function find_team_by_id($id) {
        global $teams;
        global $teamcount;
        for($i=0; $i<$teamcount; $i++) {
            if($teams[$i]['team'] == $id) {
                return $teams[$i];
            }
        }
        return false;
    }

    function build_ids() {
        global $teams;
        global $teamcount;
        $ids = array();
        for($i=0; $i<$teamcount; $i++) {
            array_push($ids, $teams[$i]['team']);
        }
        return $ids;
    }

    function build_initial_state($ids) {
        global $teams;
        global $teamcount;
        $state = array();
        for($i=0; $i<$teamcount; $i++) {
            $team = $ids;
            unset($team[$i]);
            unset($team[array_search($teams[$i]['oneTeam'], $ids)]);
            unset($team[array_search($teams[$i]['twoTeam'], $ids)]);
            array_push($state, array_values($team));
        }
        return $state;
    }

    function build_new_state($state, $decisions, $x, $y) {
        $new_state = $state;
        for($d=0; $d<count($decisions); $d++) {
            $new_state[$d] = array(0=>$decisions[$d]);
            for($s=0; $s<count($new_state); $s++) {
                if($s != $d) {
                    for($v=0; $v<count($new_state[$s]); $v++) {
                        if($new_state[$s][$v] == $decisions[$d]) {
                            unset($new_state[$s][$v]);
                        }
                        $new_state[$s] = array_values($new_state[$s]);
                    }
                }
            }
        }
        return $new_state;
    }

    function is_state_finished($state) {
        for($i=0; $i<count($state); $i++) {
            if(count($state[$i]) > 1) {
                return false;
            }
        }
        return true;
    }
 
     function is_state_valid_v2($state) {
        $valid = true;
        $final = array();
        for($i=0; $i<count($state); $i++) {
            if(count($state[$i]) == 0) {
                $valid = false;
                break;
            }
            if(count($state[$i]) == 1) {
                array_push($final, $state[$i][0]);
            }
        }
        if($valid && (count($final) == count(array_unique($final)))) {
            return true;
        } else {
            return false;
        }
    }
 
    function is_state_valid($state) {
        global $teamcount;
        $valid = true;
        $final = array();
        for($i=0; $i<$teamcount; $i++) {
            if(count($state[$i]) == 0) {
                $valid = false;
                break;
            }
            if(count($state[$i]) == 1) {
                array_push($final, $state[$i][0]);
            }
        }
        if($valid && (count($final) == count(array_unique($final)))) {
            return true;
        } else {
            return false;
        }
    }

    function sort_teams_by_round($round) {
        global $teams;
        global $teamcount;
        $counter = 0;
        $match = $round.'Match';
        $side = $round.'Side';
        $mathups = array();
        for($i=0; $i < $teamcount; $i++) {
            if($teams[$i][$side] == 1) {
                $matchups[$teams[$i][$match]] = $teams[$i];
            }
        }
        return $matchups;
    }

    function sort_teams_round_three() {
        global $teams;
        global $teamcount;
        $numbers = array();
        $matchups = array();
        for($i=0; $i<$teamcount; $i++) {
            $key = $teams[$i]["threeMatch"];
            if(!in_array($key,$numbers)) {
                array_push($numbers,$key);
                $matchups[$key] = $teams[$i];
            }
        }
        return $matchups;
    }

    function sort_teams_by_name() {
        global $teams;
        global $teamcount;
        $matchups = array();
        for($i=0; $i<$teamcount; $i++) {
            $matchups[$teams[$i]['teamName']] = $teams[$i];
        }
        ksort($matchups,SORT_STRING | SORT_FLAG_CASE);
        return $matchups;
    }

    function display_rounds() {
        global $teams;
        global $side;
        $teamcount = count($teams);
        $tableHeader = '<tr><th>Match</th><th>'.$side[1].'</th><th>School</th><th>'.$side[2].'</th><th>School</th></tr>';
        echo "<div id='rounds' style='margin: 0 auto !important;'>";
        red_header("Round 1");
        echo "<br/><table>".$tableHeader;
        $sortedTeams = sort_teams_by_round('one');
        for($i=1; $i<=count($sortedTeams); $i++) {
            echo '<tr style="outline: thin solid">
                <td style="padding-left:5px; padding-right:5px;">'
                    .$sortedTeams[$i]['oneMatch'].
                '</td>
                <td style="border-left:2px solid black; padding-left:5px; padding-right:5px;">'
                    .$sortedTeams[$i]['teamName'].
                '</td>
                <td style="border-left:2px solid black; padding-left:5px; padding-right:5px;">'
                    .$sortedTeams[$i]['schoolName'].
                '</td>
                <td style="border-left:2px solid black; padding-left:5px; padding-right:5px;">'
                    .$sortedTeams[$i]['oneTeamName'].
                '</td>
                <td style="border-left:2px solid black; padding-left:5px; padding-right:5px;">'.
                    $sortedTeams[$i]['oneSchoolName'].
                '</td>
            </tr>';
        }
        echo "</table><br />";
        red_header("Round 2");
        echo "<br/><table>".$tableHeader;
        $sortedTeams = sort_teams_by_round('two');
        for($i=1; $i<=count($sortedTeams); $i++) {
            echo '<tr style="outline: thin solid">
                <td style="padding-left:5px; padding-right:5px;">'
                    .$sortedTeams[$i]['twoMatch'].
                '</td>
                <td style="border-left:2px solid black; padding-left:5px; padding-right:5px;">'
                    .$sortedTeams[$i]['teamName'].
                '</td>
                <td style="border-left:2px solid black; padding-left:5px; padding-right:5px;">'
                    .$sortedTeams[$i]['schoolName'].
                '</td>
                <td style="border-left:2px solid black; padding-left:5px; padding-right:5px;">'
                    .$sortedTeams[$i]['twoTeamName'].
                '</td>
                <td style="border-left:2px solid black; padding-left:5px; padding-right:5px;">'
                    .$sortedTeams[$i]['twoSchoolName'].
                '</td>
            </tr>';
        }
        echo '</table><br />';
        red_header("Round 3");
        echo '<br/><table><tr><th>Match</th><th>'.$side[3].'</th><th>School</th><th>'.$side[3].'</th><th>School</th></tr>';
        $sortedTeams = sort_teams_round_three();
        for($i=1; $i <= count($sortedTeams); $i++) {
            echo '<tr style="outline: thin solid">
                <td style="padding-left:5px; padding-right:5px;">'
                    .$sortedTeams[$i]['threeMatch'].
                '</td>
                <td style="border-left:2px solid black; padding-left:5px; padding-right:5px;">'
                    .$sortedTeams[$i]['teamName'].
                '</td>
                <td style="border-left:2px solid black; padding-left:5px; padding-right:5px;">'
                .$sortedTeams[$i]['schoolName'].
                '</td>
                <td style="border-left:2px solid black; padding-left:5px; padding-right:5px;">'
                    .$sortedTeams[$i]['threeTeamName'].
                '</td>
                <td style="border-left:2px solid black; padding-left:5px; padding-right:5px;">'
                    .$sortedTeams[$i]['threeSchoolName'].
                '</td>
            </tr>';
        }
        echo "</table><br /></div><div id='teamsList' class='hidden'>";
        red_header("Teams Table");
        echo "<br/><table>";
        echo '<tr><th>Team Name</th><th>School</th><th>Round 1</th><th>Round 2</th><th>Round 3</th><th></th></tr>';
        $sortedTeams = sort_teams_by_name();
        foreach($sortedTeams as $team) {
            // line 514 needs to use $fullPathSA;
            echo '<tr style="outline: thin solid">
                <td style="padding-left:5px; padding-right:5px;">'
                    .$team['teamName'].
                '</td>
                <td style="border-left:2px solid black; padding-left:5px; padding-right:5px;">'
                    .$team['schoolName'].
                '</td>
                <td style="border-left:2px solid black; padding-left:5px; padding-right:5px;">
                    Match #'.$team['oneMatch'].' AS '.$side[intval($team['oneSide'])].
                '</td>
                <td style="border-left:2px solid black; padding-left:5px; padding-right:5px;">
                    Match #'.$team['twoMatch'].' AS '.$side[intval($team['twoSide'])].
                '</td>
                <td style="border-left:2px solid black; padding-left:5px; padding-right:5px;">
                    Match #'.$team['threeMatch'].
                '</td>
                <td style="border-left:2px solid black; padding-left:5px; padding-right:5px;">
                    <a href="matchups_update.php?id='.$team['team'].'">edit</span>
                </td>
            </tr>';
        }
        echo "</table><br /></div>";
    }
    
    function red_header($text) {
        echo '<table border="0" width="840" cellpadding="0" cellspacing="0" style="margin-top:25px;">
            <col width="6" /><col width="200" /><col width="217" /><col width="417" />
            <tr>
                <td width="6" style="width:6px;background-color:rgb(100,0,0);">
                </td>
                <td width="834" style="width:834px;" colspan="3">
                    <div style="margin-left:10px;">
                        <span class="redtext14">'.$text.'</span>
                    </div>
                </td> 
            </tr>
            <tr>
                <td width="840" height="1" style="height:1px;width:840px;background-color:rgb(100,0,0);" colspan="4">
                </td>
            </tr>
        </table>';
    }

?>
