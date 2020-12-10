<?php



function xlsBOF()
{ 
    echo pack("ssssss", 0x809, 0x8, 0x0, 0x10, 0x0, 0x0);  
    return; 
} 

function xlsEOF()
{ 
    echo pack("ss", 0x0A, 0x00); 
    return; 
} 

function xlsWriteNumber($Row, $Col, $Value)
{ 
    echo pack("sssss", 0x203, 14, $Row, $Col, 0x0); 
    echo pack("d", $Value); 
    return; 
} 

function xlsWriteLabel($Row, $Col, $Value )
{ 
    $L = strlen($Value); 
    echo pack("ssssss", 0x204, 8 + $L, $Row, $Col, 0x0, $L); 
    echo $Value; 
return; 
}



//         echo 'here we are!';



    include_once('../EwD3P7q2bRr7srwA/common.php');
    

    $dbLink = openConn();





        
//        if ($_SERVER['SERVER_PORT'] != 443) { header('Location: https://' . $hostName . $_SERVER['REQUEST_URI']); exit(); }
        

        
        header('Cache-control: no-cache;'); header('Pragma: no-cache;');
        


        $tourney = 48;
        if (array_key_exists('id', $_GET)) { $tourney = intval($_GET['id']); }
        

        
//		if (!array_key_exists('UTAhpAPSIadmin', $_COOKIE))	{ header('Location: https://' . $hostName . '/apsi/admin/?err=UNAUTHORIZED'); exit;  }
//		$whom = trim($_COOKIE['UTAhpAPSIadmin']);


// exit($theWeek);


    $result = mysql_query('select judge from scores where tourney = "' . $tourney .'" order by judge desc limit 1;', $dbLink);
    $data = mysql_fetch_row($result); $maxJudges = $data[0]; unset($data); @mysql_free_result($result);

    $result = mysql_query('select ABS(round) FROM rounds where tourney="' . $tourney .'" order by round  limit 1;', $dbLink);
    $data = mysql_fetch_row($result); $maxRounds = $data[0]; unset($data); @mysql_free_result($result);


    $result = mysql_query('select id, school from registration where tourney = "' . $tourney .'";', $dbLink);
    for ($indx = 0; $indx < mysql_num_rows($result); $indx++)
    {
    	@mysql_data_seek($result, $indx); $data = mysql_fetch_assoc($result);
    	$schools[$data['id']] = stripslashes($data['school']); unset($data);
    }
    @mysql_free_result($result);
//	$schools[school_ID]


    $result = mysql_query('select school_ID, student_ID, name from participants where tourney = "' . $tourney .'";', $dbLink);
    for ($indx = 0; $indx < mysql_num_rows($result); $indx++)
    {
    	@mysql_data_seek($result, $indx); $data = mysql_fetch_assoc($result);
    	$people[$data['school_ID']][$data['student_ID']] = stripslashes($data['name']); unset($data);
    }
    @mysql_free_result($result);
//	$people[school_ID][student_ID]


    $result = mysql_query('select round, student_ID, judge, knowledge, forensics, response, demeanor, total from scores where tourney = "' . $tourney .'";', $dbLink);
    for ($indx = 0; $indx < mysql_num_rows($result); $indx++)
    {
    	@mysql_data_seek($result, $indx); $data = mysql_fetch_assoc($result);
    	$scores[$data['student_ID']][abs($data['round'])][$data['judge']]['k'] = stripslashes($data['knowledge']);
    	$scores[$data['student_ID']][abs($data['round'])][$data['judge']]['r'] = stripslashes($data['response']);
    	$scores[$data['student_ID']][abs($data['round'])][$data['judge']]['d'] = stripslashes($data['demeanor']);
    	$scores[$data['student_ID']][abs($data['round'])][$data['judge']]['f'] = stripslashes($data['forensics']);
    	$scores[$data['student_ID']][abs($data['round'])][$data['judge']]['total'] = stripslashes($data['total']);
    	unset($data);
    }
    @mysql_free_result($result);
    
//    print_r($scores); exit;
//	$scores[student_ID][round][judge][{K,R,D,F,total}]

/*
	$extraBits = '';
	if ($maxRounds > 0) { $extraBit .= ' t.pre1, t.pd1,'; }
	if ($maxRounds > 1) { $extraBit .= ' t.pre2, t.pd2,'; }
	if ($maxRounds > 2) { $extraBit .= ' t.pre3, t.pd3,'; }
	if ($maxRounds > 3) { $extraBit .= ' t.pre4, t.pd4,'; }
	if ($maxRounds > 4) { $extraBit .= ' t.pre5, t.pd5,'; }


    $result = mysql_query('select t.school_ID, t.student_ID1, t.student_ID2, t.win, t.tie, t.loss, t.strength, t.prelimBallots,' . $extraBits . ' t.team_ID FROM teams order by t.school_ID, t.team_ID;', $dbLink);
    for ($indx = 0; $indx < mysql_num_rows($result); $indx++)
    {
    	@mysql_data_seek($result, $indx); $data = mysql_fetch_assoc($result);
    	$scores[$data['student_ID']][$data['round']][$data['judge']]['k'] = stripslashes($data['knowledge']);
    	$scores[$data['student_ID']][$data['round']][$data['judge']]['r'] = stripslashes($data['response']);
    	$scores[$data['student_ID']][$data['round']][$data['judge']]['d'] = stripslashes($data['demeanor']);
    	$scores[$data['student_ID']][$data['round']][$data['judge']]['f'] = stripslashes($data['forensics']);
    	$scores[$data['student_ID']][$data['round']][$data['judge']]['total'] = stripslashes($data['total']);
    	unset($data);
    }
    @mysql_free_result($result);
//	team_ID, student_ID, pre1, pd1, pre2, pd2, pre3, pd3, pre4, pd4, pre5, pd5, prelimBallots, strength, win, loss, tie


	


*/


    $result = mysql_query('select round, team1, team2 from rounds where tourney = "' . $tourney .'";', $dbLink);
    for ($indx = 0; $indx < mysql_num_rows($result); $indx++)
    {
    	@mysql_data_seek($result, $indx); $data = mysql_fetch_assoc($result);
    	$rounds[$data['round']]['P'] = stripslashes($data['team1']);
    	$rounds[$data['round']]['R'] = stripslashes($data['team2']);
    	$rounds[$data['team1']]['round']['job'] = 'P';  $rounds[$data['team1']]['round']['opponent'] = $data['team2'];
    	$rounds[$data['team2']]['round']['job'] = 'R';  $rounds[$data['team2']]['round']['opponent'] = $data['team1'];
    	unset($data);
    }
    @mysql_free_result($result);
//	$rounds[student_ID][round][judge][{K,R,D,F,total}]






	$blocks = mysql_query('SELECT rg.school, rg.id, p.student_ID, p.name, t.team_ID FROM participants AS p, teams AS t, registration AS rg WHERE p.tourney = "' . $tourney .'" AND p.school_ID = rg.id AND rg.tourney = "' . $tourney .'" AND t.school_ID = rg.id AND (t.student_ID1 = p.student_ID OR t.student_ID2 = p.student_ID) ORDER BY rg.school, t.team_ID, p.name;', $dbLink);




	if (mysql_num_rows($blocks) > 0)
	{

    // Send Header


    header("Pragma: public");
    header("Expires: 0");
    header("Cache-Control: must-revalidate, post-check=0, pre-check=0"); 
    header("Content-Type: application/force-download");
    header("Content-Type: application/octet-stream");
    header("Content-Type: application/download");;
    header('Content-Disposition: attachment;filename=scores.xls');
    header("Content-Transfer-Encoding: binary ");



    // XLS Data Cell

				$headerRow = 0; $columnStart = 0;
				$headerColumn = $columnStart; $lastSchool = '';

                xlsBOF();
                

				xlsWriteLabel($headerRow, 0, 'INDIVIDUAL SCORES'); $headerRow ++;



/*
************************************************
*
*
*	Individual scores by school
*
*
************************************************
*/




                $headerColumn += 3;
                
				for ($indx3 = 1; $indx3 <= $maxRounds; $indx3++)
				{
					for ($indx2 = 0; $indx2 < $maxJudges; $indx2++)
					{
	                	$headerColumn += 1;
	    	            xlsWriteLabel($headerRow, $headerColumn++, "Round " . intval($indx3));
    	    	        xlsWriteLabel($headerRow, $headerColumn++, "Round " . intval($indx3));
        	    	    xlsWriteLabel($headerRow, $headerColumn++, "Round " . intval($indx3));
            	    	xlsWriteLabel($headerRow, $headerColumn++, "Round " . intval($indx3));
            	    	$headerColumn++;
                	}
                }

				$headerRow++; $headerColumn = 0;
                
                $headerColumn += 3;
                
				for ($indx3 = 1; $indx3 <= $maxRounds; $indx3++)
				{
					for ($indx2 = 0; $indx2 < $maxJudges; $indx2++)
					{
	                	$headerColumn += 1;
	    	            xlsWriteLabel($headerRow, $headerColumn++, "Judge " . intval($indx2 + 1));
    	    	        xlsWriteLabel($headerRow, $headerColumn++, "Judge " . intval($indx2 + 1));
        	    	    xlsWriteLabel($headerRow, $headerColumn++, "Judge " . intval($indx2 + 1));
            	    	xlsWriteLabel($headerRow, $headerColumn++, "Judge " . intval($indx2 + 1));
            	    	$headerColumn++;
                	}
                }

				$headerRow++; $headerColumn = 0;
                
                xlsWriteLabel($headerRow, $headerColumn++, "school");
                xlsWriteLabel($headerRow, $headerColumn++, "team ID");
                xlsWriteLabel($headerRow, $headerColumn++, "name");
                
				for ($indx3 = 1; $indx3 <= $maxRounds; $indx3++)
				{
					for ($indx2 = 0; $indx2 < $maxJudges; $indx2++)
					{
		                $headerColumn += 1;
    		            xlsWriteLabel($headerRow, $headerColumn++, "Knowledge");
        		        xlsWriteLabel($headerRow, $headerColumn++, "Response");
            		    xlsWriteLabel($headerRow, $headerColumn++, "Forensics");
                		xlsWriteLabel($headerRow, $headerColumn++, "Demeanor");
                		xlsWriteLabel($headerRow, $headerColumn++, "Total");
                	}
                }

				$headerRow++;
                for ($indx = 0; $indx < mysql_num_rows($blocks); $indx++)
                {
                	$headerColumn = $columnStart;
                	@mysql_data_seek($blocks, $indx); $data = mysql_fetch_assoc($blocks);
                	if ($lastSchool != stripslashes($data['school'])) { $headerRow++; }
					xlsWriteLabel($headerRow, $headerColumn++, stripslashes($data['school'])); $lastSchool = stripslashes($data['school']);
                    xlsWriteNumber($headerRow, $headerColumn++, intval($data['team_ID']));
                    xlsWriteLabel($headerRow, $headerColumn++, stripslashes($data['name']));

					for ($indx3 = 1; $indx3 <= $maxRounds; $indx3++)
					{
		                for ($indx2 = 1; $indx2 <= $maxJudges; $indx2++)
    		            {
	    	            	$headerColumn += 1;
	    	            	if (intval($scores[$data['student_ID']][$indx3][$indx2]['total']) != 0)
	    	            	{
	    		    	        xlsWriteNumber($headerRow, $headerColumn++, intval($scores[$data['student_ID']][$indx3][$indx2]['k']));
    	    		    	    xlsWriteNumber($headerRow, $headerColumn++, intval($scores[$data['student_ID']][$indx3][$indx2]['r']));
        	    		    	xlsWriteNumber($headerRow, $headerColumn++, intval($scores[$data['student_ID']][$indx3][$indx2]['f']));
	        	        		xlsWriteNumber($headerRow, $headerColumn++, intval($scores[$data['student_ID']][$indx3][$indx2]['d']));
	            	    		xlsWriteNumber($headerRow, $headerColumn++, intval($scores[$data['student_ID']][$indx3][$indx2]['total']));
	            	    	}
	            	    	else
	            	    	{	$headerColumn += 5;	}
	                	}
    	            }

                    $headerRow++; unset($data);
                 }

			@mysql_free_result($blocks);


/*
************************************************
*
*
*	Team results
*
*
************************************************
*/


				$headerRow += 5; $headerColumn = 0;
				xlsWriteLabel($headerRow, 0, 'TEAM RANKINGS'); $headerRow ++;
				$prelimCount = $maxRounds;


    $result = mysql_query('SELECT team_ID, prelimBallots FROM teams WHERE tourney = "' . $tourney . '" AND present = "1" ORDER BY team_ID;', $dbLink);
    for($indx = 0; $indx < mysql_num_rows($result); $indx++)
    { @mysql_data_seek($result, $indx); $data = mysql_fetch_row($result); $ballots[$data[0]] = $data[1]; unset($data); }
    @mysql_free_result($result);


    $rTeams = mysql_query('SELECT teams.team_ID, teams.student_ID1, teams.student_ID2, registration.school FROM teams, registration WHERE (teams.tourney="' . $tourney . '" AND teams.present="1") AND (registration.tourney="' . $tourney . '" AND registration.id=teams.school_ID) ORDER BY teams.team_ID;', $dbLink);
    for ($indx = 0; $indx < mysql_num_rows($rTeams); $indx++)
    {
        @mysql_data_seek($rTeams, $indx); $data = mysql_fetch_row($rTeams);
        $result2 = mysql_query('SELECT name FROM participants WHERE student_ID = "' . $data[1] . '" AND tourney = "' . $tourney . '";', $dbLink);
        $result3 = mysql_query('SELECT name FROM participants WHERE student_ID = "' . $data[2] . '" AND tourney = "' . $tourney . '";', $dbLink);
        $stu1 = mysql_fetch_row($result2); $stu2 = mysql_fetch_row($result3); $teams[$data[0]][0] = $stu1[0]; $teams[$data[0]][1] = $stu2[0]; $teams[$data[0]][2] = $data[3];
        @mysql_free_result($result2); @mysql_free_result($result3); unset($data); unset($stu1); unset($stu2);
    }
    @mysql_free_result($rTeams);

    $rank = 0;
    $result = mysql_query('SELECT corpus FROM texts WHERE tourney = "' . $tourney . '" AND id = "5' . $prelimCount . '";', $dbLink);
    $data = mysql_fetch_row($result); @mysql_free_result($result); $datum = $data[0]; unset($data); $selectors = explode(';', $datum);
    switch ($prelimCount)
    {
        case 1: { $partA = 'pd1,'; $partB = 'pd1'; $indxA = 6; break; }
        case 2: { $partA = 'pd1, pd2,'; $partB = 'pd1 + pd2'; $indxA = 7; break;  }
        case 3: { $partA = 'pd1, pd2, pd3,'; $partB = 'pd1 + pd2 + pd3'; $indxA = 8; break;  }
        case 4: { $partA = 'pd1, pd2, pd3, pd4,'; $partB = 'pd1 + pd2 + pd3 + pd4'; $indxA = 9; break;  }
        case 5: { $partA = 'pd1, pd2, pd3, pd4, pd5,'; $partB = 'pd1 + pd2 + pd3 + pd4 + pd5'; $indxA = 10; break;  }
    }



			xlsWriteLabel($headerRow, $headerColumn++, 'Rank');
			xlsWriteLabel($headerRow, $headerColumn++, 'Team');
			xlsWriteLabel($headerRow, $headerColumn++, 'Members');
			xlsWriteLabel($headerRow, $headerColumn++, 'School');
			xlsWriteLabel($headerRow, $headerColumn++, 'Ballots');
			xlsWriteLabel($headerRow, $headerColumn++, 'Combined Strength');
			xlsWriteLabel($headerRow, $headerColumn++, 'Point Differential');
			xlsWriteLabel($headerRow, $headerColumn++, 'Win');
			xlsWriteLabel($headerRow, $headerColumn++, 'Loss');
			xlsWriteLabel($headerRow, $headerColumn++, 'Tie');
			
			$headerRow++;

    $data = $selectors[$loop]; $subs = explode(',',$data);

    $job = 'SELECT team_ID, win, tie, loss, prelimBallots, (SUM( ' . $partB . ' ) / ' . $prelimCount . ') AS total, strength FROM teams WHERE tourney = "' . $tourney . '" GROUP BY team_ID ORDER BY prelimBallots DESC, strength DESC, total DESC ;';
    
    $result = mysql_query($job, $dbLink); unset($subs); $wasData = false;
    if (mysql_num_rows($result) > 0)
    {
        $wasData = true; $rank = 1;
        for($indx = 0; $indx < mysql_num_rows($result); $indx++)
        {
            @mysql_data_seek($result, $indx); $data = mysql_fetch_assoc($result);

            $result2 = mysql_query('SELECT team1, team2 FROM rounds WHERE tourney = "' . $tourney . '" AND (team1 = "' . $data['team_ID'] . '" OR team2 = "' . $data['team_ID'] . '");', $dbLink); $strength = 0;
            for ($indux = 0; $indux < mysql_num_rows($result2); $indux++)
            {
                @mysql_data_seek($result2, $indux); $data2 = mysql_fetch_row($result2);
                if ($data2[0] != $data['team_ID']) { $strength .+ $ballots[$data2[0]]; }
                if ($data2[1] != $data['team_ID']) { $strength .+ $ballots[$data2[1]]; }
                unset($data2);
            }
            @mysql_free_result($result2);

			$headerColumn = 0;
			xlsWriteNumber($headerRow, $headerColumn++, $rank++);
			xlsWriteLabel($headerRow, $headerColumn++, stripslashes($data['team_ID']));
			xlsWriteLabel($headerRow, $headerColumn++, stripslashes($teams[$data['team_ID']][0] . ' / ' . $teams[$data['team_ID']][1]));
			xlsWriteLabel($headerRow, $headerColumn++, stripslashes($teams[$data['team_ID']][2]));

			xlsWriteNumber($headerRow, $headerColumn++, sprintf('%01.4f', $data['prelimBallots']));
			xlsWriteNumber($headerRow, $headerColumn++, sprintf('%01.4f', $data['strength']));
			xlsWriteNumber($headerRow, $headerColumn++, sprintf('%01.3f', $data['total']));
			xlsWriteNumber($headerRow, $headerColumn++, $data['win']);
			xlsWriteNumber($headerRow, $headerColumn++, $data['loss']);
			xlsWriteNumber($headerRow++, $headerColumn++, $data['tie']);


        }

    }


/*
************************************************
*
*
*	Orator Rankings
*
*
************************************************
*/


			$headerRow += 5; $headerColumn = 0;
			xlsWriteLabel($headerRow++, 0, 'ORATOR RANKINGS');

			xlsWriteLabel($headerRow, $headerColumn++, 'Rank');
			xlsWriteLabel($headerRow, $headerColumn++, 'Average Score');
			xlsWriteLabel($headerRow, $headerColumn++, 'Participant');
			xlsWriteLabel($headerRow++, $headerColumn++, 'School');

    $result = mysql_query('SELECT AVG(s.total) AS avg, p.name, r.school FROM scores AS s, participants AS p, registration AS r, teams AS t WHERE (p.student_ID=s.student_ID AND r.id=p.school_ID) AND (s.tourney = "' . $tourney . '" AND r.tourney = "' . $tourney . '" AND p.tourney = "' . $tourney . '") AND (t.isSquib = "0" AND t.team_ID = s.team_ID) GROUP BY s.student_ID ORDER BY avg DESC;', $dbLink);

    if (mysql_num_rows($result) > 0)
    {

        for($indx = 0; $indx < mysql_num_rows($result); $indx++)
        {
            @mysql_data_seek($result, $indx); $data = mysql_fetch_row($result);

			$headerColumn = 0;
			xlsWriteNumber($headerRow, $headerColumn++, intval($indx + 1));
			xlsWriteNumber($headerRow, $headerColumn++, sprintf('%01.3f', $data[0]));
			xlsWriteLabel($headerRow, $headerColumn++, stripslashes($data[1]));
			xlsWriteLabel($headerRow++, $headerColumn++, stripslashes($data[2]));
        }
        @mysql_free_result($result);
    }




/*
************************************************
*
*
*	Match Results
*
*
************************************************
*/


			$headerRow += 5; $headerColumn = 0;
			xlsWriteLabel($headerRow++, 0, 'TEAM RESULTS');

			xlsWriteLabel($headerRow, $headerColumn++, 'School');
			xlsWriteLabel($headerRow, $headerColumn++, 'Team ID');
			xlsWriteLabel($headerRow, $headerColumn++, 'Participants');



                $headerColumn++;
                
				for ($indx3 = 1; $indx3 <= $maxRounds; $indx3++)
				{
					$headerColumn += 1;
					xlsWriteLabel($headerRow, $headerColumn++, "Round " . intval($indx3));
	    	           
					for ($indx5 = 0; $indx5 < $maxJudges; $indx5++)
					{
						xlsWriteLabel($headerRow, $headerColumn++, "Judge " . intval($indx5 + 1));
					}

					xlsWriteLabel($headerRow, $headerColumn++, 'Ballots');
				}

			$headerRow += 1; $headerColumn = 0;



    $rTeams = mysql_query('SELECT teams.team_ID, teams.student_ID1, teams.student_ID2, registration.school, teams.school_ID FROM teams, registration WHERE (teams.tourney="' . $tourney . '" AND teams.present="1") AND (registration.tourney="' . $tourney . '" AND registration.id=teams.school_ID) ORDER BY registration.school, team_ID;', $dbLink);
    for ($indx = 0; $indx < mysql_num_rows($rTeams); $indx++)
    {
        @mysql_data_seek($rTeams, $indx); $data = mysql_fetch_assoc($rTeams); unset($teams[$data['school']]);
        $result2 = mysql_query('SELECT name FROM participants WHERE student_ID = "' . $data['student_ID1'] . '" AND tourney = "' . $tourney . '";', $dbLink); $punk1 = $data['student_ID1'];
        $result3 = mysql_query('SELECT name FROM participants WHERE student_ID = "' . $data['student_ID2'] . '" AND tourney = "' . $tourney . '";', $dbLink); $punk2 = $data['student_ID2'];
        $stu1 = mysql_fetch_row($result2); $stu2 = mysql_fetch_row($result3);
        $teams[$data['team_ID']][0] = $stu1[0]; $teams[$data['team_ID']][1] = $stu2[0]; $teams[$data['team_ID']][2] = $data['school']; $teams[$data['team_ID']]['id1'] = $punk1; $teams[$data['team_ID']]['id2'] = $punk2;
        @mysql_free_result($result2); @mysql_free_result($result3); unset($data); unset($stu1); unset($stu2);
    }

	$result = mysql_query('SELECT * FROM scores WHERE tourney = "' . $tourney . '";', $dbLink);
	for ($indx = 0; $indx < mysql_num_rows($result); $indx++)
	{
		@mysql_data_seek($result, $indx); $data = mysql_fetch_assoc($result);
		$scores[$data['student_ID']][abs($data['round'])][$data['judge']] = $data['total']; unset($data);
	}
	@mysql_free_result($result);


// print_r($scores); exit;
    //  Build the table

	$haveScores = true; $lastSchool = 'AAAAA';
    for($outer = 0; $outer < mysql_num_rows($rTeams); $outer++)
    {
            @mysql_data_seek($rTeams, $outer); $datoi = mysql_fetch_row($rTeams);

				if ($lastSchool != $teams[$datoi[0]][2]) { $headerRow += 1; $lastSchool = $teams[$datoi[0]][2]; }
				$headerColumn = 0;
				xlsWriteLabel($headerRow, $headerColumn++, $teams[$datoi[0]][2]);
				xlsWriteLabel($headerRow, $headerColumn++, 'Team ' . $datoi[0]);
				xlsWriteLabel($headerRow, $headerColumn++, $teams[$datoi[0]][0] . ' / ' . $teams[$datoi[0]][1]);
				$headerColumn++;

				for ($indx3 = 1; $indx3 <= $maxRounds; $indx3++)
				{

	                $result = mysql_query('SELECT round, team1, team2 FROM rounds WHERE tourney = "' . $tourney . '" AND ABS(round) = ' . $indx3 . ' AND (team1 = "' . $datoi[0] . '" OR team2 = "' . $datoi[0] . '") ORDER BY round DESC;', $dbLink);
    	            $roundData = mysql_fetch_assoc($result); @mysql_free_result($result);

					$headerColumn += 1;
					$task = ($datoi[0] == $roundData['team1']) ? 'Petitioner' : 'Respondent' ; $opponent = ($datoi[0] == $roundData['team1']) ? $roundData['team2'] : $roundData['team1'] ;
					$txt = $task . ' v. Team ' . $opponent;
					
					$initials = explode(' ', $teams[$opponent][0] . ' / ' . $teams[$opponent][1] . ' @ ' . $teams[$opponent][2]); $oppoInit = '';
					foreach ($initials as $value) { $oppoInit .= $value{0}; }
					$oppoInit = ' (' . str_replace('@', ' @ ', $oppoInit) . ')';
					
					xlsWriteLabel($headerRow, $headerColumn++, $txt . $oppoInit);

					$ballots = 0; $home = $datoi[0]; $judgesNow = 0;
					for ($indx5 = 1; $indx5 <= $maxJudges; $indx5++)
					{
						if ( array_key_exists($teams[$home]['id1'], $scores) )
						{
							if ( array_key_exists($indx3, $scores[$teams[$home]['id1']]) )
							{
								if ( array_key_exists($indx5, $scores[$teams[$home]['id1']][$indx3]) )
								{
									$homeTotal = intval( $scores[$teams[$home]['id1']][$indx3][$indx5] + $scores[$teams[$home]['id2']][$indx3][$indx5] );
									$visitorTotal = intval( $scores[$teams[$opponent]['id1']][$indx3][$indx5] + $scores[$teams[$opponent]['id2']][$indx3][$indx5] );
									switch (true)
									{
										case ($homeTotal == $visitorTotal): { $ballots += 0.5; $marker = 'T'; break; }
										case ($homeTotal >  $visitorTotal): { $ballots += 1.0; $marker = 'W'; break; }
										case ($homeTotal <  $visitorTotal): { $ballots += 0.0; $marker = 'L'; break; }
									}
									$txt = $homeTotal . ' - ' . $visitorTotal . ' (' . $marker . ')'; $judgesNow += 1;

									xlsWriteLabel($headerRow, $headerColumn++, $txt);
								}
								else
								{
									$headerColumn += 1;
								}
							}
						}
						else
						{
							$txt = 'no scores';
							xlsWriteLabel($headerRow, $headerColumn++, $txt);
						}
					}

					if ($judgesNow != 0)
					{
	    				$ballotsA = sprintf('%01.3f', (2 / $judgesNow) * $ballots);

	    				if ($judgeCount == 3)
    					{
    						if ($wins[0] == 2) {  $ballotsA = 1.3400000;  }

    						if ($wins[0] == 1) {  $ballotsA = 0.6600000;  }
    					}
					}
					else
					{
						$ballotsA = 0;
					}

					xlsWriteNumber($headerRow, $headerColumn++, $ballotsA);
				}


            
            $headerRow++; unset($datoi);
    }
    @mysql_free_result($result);
    
    




























                 xlsEOF();
                 @mysql_free_result($scores);
	}
	@mysql_close($dbLink);
	exit();



?>