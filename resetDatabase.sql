DROP DATABASE IF EXISTS `mootcourt`;
CREATE DATABASE `mootcourt`;
USE `mootcourt`;

CREATE TABLE `matchups` (
  `tourney` int(3) unsigned NOT NULL,
  `team` int(11) NOT NULL,
  `teamName` varchar(256) NOT NULL,
  `school` int(3) UNSIGNED NOT NULL,
  `schoolName` varchar(256) NOT NULL,
  `oneTeam` int(3) UNSIGNED NOT NULL,
  `oneTeamName` varchar(256) NOT NULL,
  `oneSchool` int(3) UNSIGNED NOT NULL,
  `oneSchoolName` varchar(256) NOT NULL,
  `oneSide` int(3) UNSIGNED NOT NULL,
  `oneMatch` int(3) NOT NULL,
  `twoTeam` int(3) UNSIGNED NOT NULL,
  `twoTeamName` varchar(256) NOT NULL,
  `twoSchool` int(3) UNSIGNED NOT NULL,
  `twoSchoolName` varchar(256) NOT NULL,
  `twoSide` int(3) UNSIGNED NOT NULL,
  `twoMatch` int(3) NOT NULL,
  `threeTeam` int(3) UNSIGNED NOT NULL,
  `threeTeamName` varchar(256) NOT NULL,
  `threeSchool` int(3) UNSIGNED NOT NULL,
  `threeSchoolName` varchar(256) NOT NULL,
  `threeSide` int(3) UNSIGNED NOT NULL,
  `threeMatch` int(3) NOT NULL,
  PRIMARY KEY (`tourney`, `team`)
);

CREATE TABLE `authentication` (
  `tourney` int(3) unsigned NOT NULL DEFAULT '0',
  `name` tinyblob NOT NULL,
  `password` tinyblob NOT NULL,
  `class` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `useLDAP` tinyint(3) unsigned NOT NULL DEFAULT '0',
  KEY `tourney` (`tourney`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Password table for scoreres';

CREATE TABLE `buildings` (
  `tourney` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL DEFAULT '',
  `abbr` varchar(5) NOT NULL DEFAULT '',
  `priority` tinyint(3) unsigned NOT NULL DEFAULT '0',
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='table of building names';

CREATE TABLE `geheimnis` (
  `id` int(11) DEFAULT NULL,
  `wichtiger` varchar(64) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `invoices` (
  `tourney` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `schoolID` smallint(6) unsigned NOT NULL DEFAULT '0',
  `teams` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `date` varchar(8) NOT NULL DEFAULT '',
  `number` varchar(20) NOT NULL DEFAULT '',
  `type` tinyint(4) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='List of sent invoices';

CREATE TABLE `participants` (
  `tourney` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `school_ID` smallint(6) NOT NULL DEFAULT '0',
  `student_ID` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(35) NOT NULL DEFAULT '0',
  `street` tinyblob NOT NULL,
  `city` tinyblob NOT NULL,
  `state` char(2) NOT NULL DEFAULT '',
  `zip` varchar(15) NOT NULL DEFAULT '',
  `phone` tinyblob NOT NULL,
  `email` tinyblob NOT NULL,
  `classification` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`student_ID`),
  KEY `tourney` (`tourney`)
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=latin1 COMMENT='Individual participants';

CREATE TABLE `pasttourneys` (
  `baseID` int(11) DEFAULT NULL,
  `current` int(11) DEFAULT NULL,
  `pastIDs` text,
  `label` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `payments` (
  `tourney` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `paymentType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ccNumber` tinyblob NOT NULL,
  `ccType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ccDate` tinyblob NOT NULL,
  `ccName` tinyblob NOT NULL,
  `ccIP_Addr` tinyblob NOT NULL,
  `poNumber` tinyblob NOT NULL,
  `date` varchar(8) NOT NULL DEFAULT '',
  `processed` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `total` smallint(6) NOT NULL DEFAULT '0',
  `school_ID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ccCVV2` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Payments ledger';

CREATE TABLE `preferences` (
  `tourney` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `dataKey` varchar(20) NOT NULL DEFAULT '',
  `data` tinyblob NOT NULL,
  KEY `tourney` (`tourney`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `registration` (
  `tourney` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `school` varchar(50) NOT NULL DEFAULT '',
  `contact` varchar(50) NOT NULL DEFAULT '',
  `address` varchar(50) NOT NULL DEFAULT '',
  `city` varchar(30) NOT NULL DEFAULT '',
  `state` char(2) NOT NULL DEFAULT '',
  `zip` varchar(10) NOT NULL DEFAULT '',
  `phone` varchar(20) NOT NULL DEFAULT '',
  `email` tinyblob NOT NULL,
  `password` tinyblob NOT NULL,
  `passwordAnon` tinyblob NOT NULL,
  `flagAnyAdd` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `flagNotify` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `lockedUntil` varchar(12) NOT NULL DEFAULT '',
  `badCount` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `editor` varchar(64) NOT NULL DEFAULT '',
  `editorEmail` tinyblob NOT NULL,
  `teamsCount` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `flagInvoice` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `flagReceipt` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tourney` (`tourney`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=latin1 COMMENT='Registration - Schools info';

CREATE TABLE `rooms` (
  `tourney` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `building_ID` smallint(6) unsigned NOT NULL DEFAULT '0',
  `roomNumber` varchar(10) NOT NULL DEFAULT '',
  `pre1` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `pre2` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `pre3` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `pre4` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `pre5` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `rnd64` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `rnd32` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `sixteen` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `quarter` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `semi` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `final` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `bye` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `rank` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='table of rooms and available';

CREATE TABLE `rounds` (
  `tourney` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `round` tinyint(4) NOT NULL DEFAULT '0',
  `team1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `team2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `location` smallint(5) unsigned NOT NULL DEFAULT '0',
  `building_ID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `finished` tinyint(3) unsigned NOT NULL DEFAULT '0',
  KEY `tourney` (`tourney`),
  KEY `team1` (`team1`),
  KEY `team2` (`team2`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='table of the assignments each round';

CREATE TABLE `scores` (
  `tourney` int(3) unsigned NOT NULL DEFAULT '0',
  `round` tinyint(4) NOT NULL DEFAULT '0',
  `student_ID` smallint(6) NOT NULL DEFAULT '0',
  `team_ID` smallint(6) NOT NULL DEFAULT '0',
  `judge` tinyint(4) NOT NULL DEFAULT '0',
  `knowledge` tinyint(4) NOT NULL DEFAULT '0',
  `response` tinyint(4) NOT NULL DEFAULT '0',
  `forensics` tinyint(4) NOT NULL DEFAULT '0',
  `demeanor` tinyint(4) NOT NULL DEFAULT '0',
  `total` smallint(6) NOT NULL DEFAULT '0',
  KEY `tourney` (`tourney`),
  KEY `team_ID` (`team_ID`),
  KEY `student_ID` (`student_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Individual scores';

CREATE TABLE `teams` (
  `tourney` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `present` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `team_ID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `student_ID1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `student_ID2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `school_ID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `win` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `loss` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `tie` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `pre1` smallint(4) NOT NULL DEFAULT '0',
  `pd1` float NOT NULL DEFAULT '0',
  `pre2` smallint(4) NOT NULL DEFAULT '0',
  `pd2` float NOT NULL DEFAULT '0',
  `pre3` smallint(4) NOT NULL DEFAULT '0',
  `pd3` float NOT NULL DEFAULT '0',
  `pre4` smallint(4) NOT NULL DEFAULT '0',
  `pd4` float NOT NULL DEFAULT '0',
  `pre5` smallint(4) NOT NULL DEFAULT '0',
  `pd5` float NOT NULL DEFAULT '0',
  `sixteen` smallint(5) unsigned NOT NULL DEFAULT '0',
  `quarter` smallint(5) unsigned NOT NULL DEFAULT '0',
  `semi` smallint(5) unsigned NOT NULL DEFAULT '0',
  `final` smallint(5) unsigned NOT NULL DEFAULT '0',
  `paymentID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `isSquib` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rnd32` smallint(5) unsigned NOT NULL DEFAULT '0',
  `rnd64` smallint(5) unsigned NOT NULL DEFAULT '0',
  `regionalRank` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `prelimBallots` float NOT NULL DEFAULT '0',
  `finalsBallots` float NOT NULL DEFAULT '0',
  `powerProtected` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `strength` float NOT NULL DEFAULT '0',
  KEY `tourney` (`tourney`),
  KEY `team_ID` (`team_ID`),
  KEY `student_ID1` (`student_ID1`),
  KEY `student_ID2` (`student_ID2`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Teams table';

CREATE TABLE `texts` (
  `tourney` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `corpus` text NOT NULL,
  KEY `tourney` (`tourney`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `tmp_teams` (
  `tourney` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `present` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `team_ID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `student_ID1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `student_ID2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `school_ID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `win` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `loss` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `tie` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `pre1` smallint(4) NOT NULL DEFAULT '0',
  `pd1` float NOT NULL DEFAULT '0',
  `pre2` smallint(4) NOT NULL DEFAULT '0',
  `pd2` float NOT NULL DEFAULT '0',
  `pre3` smallint(4) NOT NULL DEFAULT '0',
  `pd3` float NOT NULL DEFAULT '0',
  `pre4` smallint(4) NOT NULL DEFAULT '0',
  `pd4` float NOT NULL DEFAULT '0',
  `pre5` smallint(4) NOT NULL DEFAULT '0',
  `pd5` float NOT NULL DEFAULT '0',
  `sixteen` smallint(5) unsigned NOT NULL DEFAULT '0',
  `quarter` smallint(5) unsigned NOT NULL DEFAULT '0',
  `semi` smallint(5) unsigned NOT NULL DEFAULT '0',
  `final` smallint(5) unsigned NOT NULL DEFAULT '0',
  `paymentID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `isSquib` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rnd32` smallint(5) unsigned NOT NULL DEFAULT '0',
  `rnd64` smallint(5) unsigned NOT NULL DEFAULT '0',
  `regionalRank` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `prelimBallots` float NOT NULL DEFAULT '0',
  `finalsBallots` float NOT NULL DEFAULT '0',
  `powerProtected` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `strength` float NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Teams table';

CREATE TABLE `tournaments` (
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(250) NOT NULL DEFAULT '',
  `where` varchar(80) NOT NULL DEFAULT '',
  `website` varchar(250) NOT NULL DEFAULT '',
  `director` varchar(64) NOT NULL DEFAULT '',
  `dirEmail` varchar(64) NOT NULL DEFAULT '',
  `tourneyCoord` varchar(64) NOT NULL DEFAULT '',
  `coordEmail` varchar(64) NOT NULL DEFAULT '',
  `webAdmin` varchar(64) NOT NULL DEFAULT '',
  `webEmail` varchar(64) NOT NULL DEFAULT '',
  `registerPage` varchar(250) NOT NULL DEFAULT '',
  `tourneyTime` varchar(80) NOT NULL DEFAULT '',
  `isNational` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `year` varchar(4) DEFAULT NULL,
  `path` varchar(64) DEFAULT '',
  KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `unttemp` (
  `round` tinyint(4) NOT NULL DEFAULT '0',
  `student_ID` smallint(6) NOT NULL DEFAULT '0',
  `team_ID` smallint(6) NOT NULL DEFAULT '0',
  `avgScore` smallint(6) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Individual scores';

CREATE TABLE `venues` (
  `id` int(11) NOT NULL,
  `school` varchar(96) DEFAULT NULL,
  `director` varchar(96) DEFAULT NULL,
  `directorEmail` varchar(96) DEFAULT NULL,
  `hashKey` varchar(64) DEFAULT '',
  `link` text,
  `tourneyID` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

INSERT INTO `authentication` VALUES (1, AES_ENCRYPT("midsouth","32CharactersOfRandomFun"), AES_ENCRYPT("AMCA","32CharactersOfRandomFun"), 2, 0);
INSERT INTO `tournaments` VALUES (1, 'ACMA Tournament', '', '', '', '', '', '', '', '', '', '', '0', '', '');
INSERT INTO `preferences` VALUES (1, 'newTeamNotify', 0x79dd9188c47937118222b0eabfe4267d);
INSERT INTO `preferences` VALUES (1, 'prelimRounds', 0x33);
INSERT INTO `preferences` VALUES (1, 'registrationOn', 0x30);
INSERT INTO `preferences` VALUES (1, 'campusMap', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f);
INSERT INTO `preferences` VALUES (1, 'campusMapFile', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f63616d7075736d61702e706466);
INSERT INTO `preferences` VALUES (1, 'administrator', 0x484dc36308eb8317d6d6babbe681b9c6b7ae29d9755962bb254defcb980e09f1);
INSERT INTO `preferences` VALUES (1, 'statusShowScores', 0x30);
INSERT INTO `preferences` VALUES (1, 'statusRefresh', 0x313230);
INSERT INTO `preferences` VALUES (1, 'registrationTeams', 0x31);
INSERT INTO `preferences` VALUES (1, 'registrationPayment', 0x31);
INSERT INTO `preferences` VALUES (1, 'tournamentDates', 0x4a616e75617279203230202d203231);
INSERT INTO `preferences` VALUES (1, 'tournamentLocation', 0x55542041726c696e67746f6e);
INSERT INTO `preferences` VALUES (1, 'refundPolicy', 0x726566756e642e747874);
INSERT INTO `preferences` VALUES (1, 'currentRound', 0x2d33);
INSERT INTO `preferences` VALUES (1, 'finalRounds', 0x35);
INSERT INTO `preferences` VALUES (1, 'cryptoStr', '');
INSERT INTO `preferences` VALUES (1, 'useVerify', 0x31);
INSERT INTO `preferences` VALUES (1, 'pre5Type', 0x30);
INSERT INTO `preferences` VALUES (1, 'pre4Type', 0x30);
INSERT INTO `preferences` VALUES (1, 'pre3Type', 0x33);
INSERT INTO `preferences` VALUES (1, 'pre2Type', 0x32);
INSERT INTO `preferences` VALUES (1, 'pre1Type', 0x31);
INSERT INTO `preferences` VALUES (1, 'showTopOrators', 0x31);
INSERT INTO `preferences` VALUES (1, 'topOratorCount', 0x3130);
INSERT INTO `preferences` VALUES (1, 'teamsListByScore', 0x30);
INSERT INTO `preferences` VALUES (1, 'hideOratorsLastRound', 0x31);
INSERT INTO `preferences` VALUES (1, 'noNewRegistration', 0x30);
INSERT INTO `preferences` VALUES (1, 'maxPrelimRounds', 0x35);
INSERT INTO `preferences` VALUES (1, 'maxFinalRounds', 0x36);
INSERT INTO `preferences` VALUES (1, 'noDoubleJeapordy', 0x31);
INSERT INTO `preferences` VALUES (1, 'generateAllPrelims', 0x31);
INSERT INTO `preferences` VALUES (1, 'keepTeamsInSameBldg', 0x31);
INSERT INTO `preferences` VALUES (1, 'feeAmount', 0x3735);
INSERT INTO `preferences` VALUES (1, 'tournamentOver', 0x3230303630313231313830303030);
INSERT INTO `preferences` VALUES (1, 'registrationCutoff', 0x3230303630313137303030303030);
INSERT INTO `preferences` VALUES (1, 'lateFeeAmount', 0x313030);
INSERT INTO `preferences` VALUES (1, 'lateFeeAfter', 0x3230303531323233);
INSERT INTO `texts` VALUES (1, 2, 'The tournament is concluded. Thank you to all of the judges, schools, participants, coaches and staff for making the tournament a success.');
INSERT INTO `texts` VALUES (1, 53, '3,0,0;2,0,1;2,1,0;1,0,2;1,1,1;1,2,0;0,0,3;0,1,2;0,2,1;0,3,0;2,0,0;1,0,1;0,0,2;0,1,1;0,2,0;1,0,0;0,0,1;0,1,0;0,0,0');
INSERT INTO `texts` VALUES (1, 55, '5,0,0;4,0,1;4,1,0;3,0,2;3,1,1;3,2,0;2,0,3;2,1,2;2,2,1;2,3,0;1,0,4;1,1,3;1,2,2;1,3,1;1,4,0;0,0,5;0,1,4;0,2,3;0,3,2;0,4,1;0,5,0;0,0,0;');
INSERT INTO `texts` VALUES (1, 54, '4,0,0;3,0,1;3,1,0;2,0,2;2,1,1;2,2,0;1,0,3;1,1,2;1,2,1;1,3,0;0,0,4;0,1,3;0,2,2;0,3,1;0,4,0;0,0,0;');
INSERT INTO `texts` VALUES (1, 52, '2,0,0;1,0,1;1,1,0;0,0,2;0,1,1;0,2,0;0,0,0;');
INSERT INTO `texts` VALUES (1, 51, '1,0,0;0,0,1;0,1,0;0,0,0;');
INSERT INTO `texts` VALUES (1, 1, 'Online registration for the 2006 National tournament will be available December 5, 2005, after all of the Regional Tournaments are concluded. Once the number of teams that automatically advance to the National Tournament are known, registration will open for the remaining slots.');
INSERT INTO `texts` VALUES (1, 3, 'No refunds will be given after January 27, 2006. Contact Jim Perry for information regarding the refund procedure.');
INSERT INTO `texts` VALUES (1, 100, '');
INSERT INTO `texts` VALUES (1, 101, '');

INSERT INTO `authentication` VALUES (2, AES_ENCRYPT("rubbercity","32CharactersOfRandomFun"), AES_ENCRYPT("AMCA","32CharactersOfRandomFun"), 2, 0);
INSERT INTO `tournaments` VALUES (2, 'ACMA Tournament', '', '', '', '', '', '', '', '', '', '', '0', '', '');
INSERT INTO `preferences` VALUES (2, 'newTeamNotify', 0x79dd9188c47937118222b0eabfe4267d);
INSERT INTO `preferences` VALUES (2, 'prelimRounds', 0x33);
INSERT INTO `preferences` VALUES (2, 'registrationOn', 0x30);
INSERT INTO `preferences` VALUES (2, 'campusMap', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f);
INSERT INTO `preferences` VALUES (2, 'campusMapFile', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f63616d7075736d61702e706466);
INSERT INTO `preferences` VALUES (2, 'administrator', 0x484dc36308eb8317d6d6babbe681b9c6b7ae29d9755962bb254defcb980e09f1);
INSERT INTO `preferences` VALUES (2, 'statusShowScores', 0x30);
INSERT INTO `preferences` VALUES (2, 'statusRefresh', 0x313230);
INSERT INTO `preferences` VALUES (2, 'registrationTeams', 0x31);
INSERT INTO `preferences` VALUES (2, 'registrationPayment', 0x31);
INSERT INTO `preferences` VALUES (2, 'tournamentDates', 0x4a616e75617279203230202d203231);
INSERT INTO `preferences` VALUES (2, 'tournamentLocation', 0x55542041726c696e67746f6e);
INSERT INTO `preferences` VALUES (2, 'refundPolicy', 0x726566756e642e747874);
INSERT INTO `preferences` VALUES (2, 'currentRound', 0x2d33);
INSERT INTO `preferences` VALUES (2, 'finalRounds', 0x35);
INSERT INTO `preferences` VALUES (2, 'cryptoStr', '');
INSERT INTO `preferences` VALUES (2, 'useVerify', 0x31);
INSERT INTO `preferences` VALUES (2, 'pre5Type', 0x30);
INSERT INTO `preferences` VALUES (2, 'pre4Type', 0x30);
INSERT INTO `preferences` VALUES (2, 'pre3Type', 0x33);
INSERT INTO `preferences` VALUES (2, 'pre2Type', 0x32);
INSERT INTO `preferences` VALUES (2, 'pre1Type', 0x31);
INSERT INTO `preferences` VALUES (2, 'showTopOrators', 0x31);
INSERT INTO `preferences` VALUES (2, 'topOratorCount', 0x3130);
INSERT INTO `preferences` VALUES (2, 'teamsListByScore', 0x30);
INSERT INTO `preferences` VALUES (2, 'hideOratorsLastRound', 0x31);
INSERT INTO `preferences` VALUES (2, 'noNewRegistration', 0x30);
INSERT INTO `preferences` VALUES (2, 'maxPrelimRounds', 0x35);
INSERT INTO `preferences` VALUES (2, 'maxFinalRounds', 0x36);
INSERT INTO `preferences` VALUES (2, 'noDoubleJeapordy', 0x31);
INSERT INTO `preferences` VALUES (2, 'generateAllPrelims', 0x31);
INSERT INTO `preferences` VALUES (2, 'keepTeamsInSameBldg', 0x31);
INSERT INTO `preferences` VALUES (2, 'feeAmount', 0x3735);
INSERT INTO `preferences` VALUES (2, 'tournamentOver', 0x3230303630313231313830303030);
INSERT INTO `preferences` VALUES (2, 'registrationCutoff', 0x3230303630313137303030303030);
INSERT INTO `preferences` VALUES (2, 'lateFeeAmount', 0x313030);
INSERT INTO `preferences` VALUES (2, 'lateFeeAfter', 0x3230303531323233);
INSERT INTO `texts` VALUES (2, 2, 'The tournament is concluded. Thank you to all of the judges, schools, participants, coaches and staff for making the tournament a success.');
INSERT INTO `texts` VALUES (2, 53, '3,0,0;2,0,1;2,1,0;1,0,2;1,1,1;1,2,0;0,0,3;0,1,2;0,2,1;0,3,0;2,0,0;1,0,1;0,0,2;0,1,1;0,2,0;1,0,0;0,0,1;0,1,0;0,0,0');
INSERT INTO `texts` VALUES (2, 55, '5,0,0;4,0,1;4,1,0;3,0,2;3,1,1;3,2,0;2,0,3;2,1,2;2,2,1;2,3,0;1,0,4;1,1,3;1,2,2;1,3,1;1,4,0;0,0,5;0,1,4;0,2,3;0,3,2;0,4,1;0,5,0;0,0,0;');
INSERT INTO `texts` VALUES (2, 54, '4,0,0;3,0,1;3,1,0;2,0,2;2,1,1;2,2,0;1,0,3;1,1,2;1,2,1;1,3,0;0,0,4;0,1,3;0,2,2;0,3,1;0,4,0;0,0,0;');
INSERT INTO `texts` VALUES (2, 52, '2,0,0;1,0,1;1,1,0;0,0,2;0,1,1;0,2,0;0,0,0;');
INSERT INTO `texts` VALUES (2, 51, '1,0,0;0,0,1;0,1,0;0,0,0;');
INSERT INTO `texts` VALUES (2, 1, 'Online registration for the 2006 National tournament will be available December 5, 2005, after all of the Regional Tournaments are concluded. Once the number of teams that automatically advance to the National Tournament are known, registration will open for the remaining slots.');
INSERT INTO `texts` VALUES (2, 3, 'No refunds will be given after January 27, 2006. Contact Jim Perry for information regarding the refund procedure.');
INSERT INTO `texts` VALUES (2, 100, '');
INSERT INTO `texts` VALUES (2, 101, '');

INSERT INTO `authentication` VALUES (3, AES_ENCRYPT("midatlantic","32CharactersOfRandomFun"), AES_ENCRYPT("AMCA","32CharactersOfRandomFun"), 2, 0);
INSERT INTO `tournaments` VALUES (3, 'ACMA Tournament', '', '', '', '', '', '', '', '', '', '', '0', '', '');
INSERT INTO `preferences` VALUES (3, 'newTeamNotify', 0x79dd9188c47937118222b0eabfe4267d);
INSERT INTO `preferences` VALUES (3, 'prelimRounds', 0x33);
INSERT INTO `preferences` VALUES (3, 'registrationOn', 0x30);
INSERT INTO `preferences` VALUES (3, 'campusMap', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f);
INSERT INTO `preferences` VALUES (3, 'campusMapFile', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f63616d7075736d61702e706466);
INSERT INTO `preferences` VALUES (3, 'administrator', 0x484dc36308eb8317d6d6babbe681b9c6b7ae29d9755962bb254defcb980e09f1);
INSERT INTO `preferences` VALUES (3, 'statusShowScores', 0x30);
INSERT INTO `preferences` VALUES (3, 'statusRefresh', 0x313230);
INSERT INTO `preferences` VALUES (3, 'registrationTeams', 0x31);
INSERT INTO `preferences` VALUES (3, 'registrationPayment', 0x31);
INSERT INTO `preferences` VALUES (3, 'tournamentDates', 0x4a616e75617279203230202d203231);
INSERT INTO `preferences` VALUES (3, 'tournamentLocation', 0x55542041726c696e67746f6e);
INSERT INTO `preferences` VALUES (3, 'refundPolicy', 0x726566756e642e747874);
INSERT INTO `preferences` VALUES (3, 'currentRound', 0x2d33);
INSERT INTO `preferences` VALUES (3, 'finalRounds', 0x35);
INSERT INTO `preferences` VALUES (3, 'cryptoStr', '');
INSERT INTO `preferences` VALUES (3, 'useVerify', 0x31);
INSERT INTO `preferences` VALUES (3, 'pre5Type', 0x30);
INSERT INTO `preferences` VALUES (3, 'pre4Type', 0x30);
INSERT INTO `preferences` VALUES (3, 'pre3Type', 0x33);
INSERT INTO `preferences` VALUES (3, 'pre2Type', 0x32);
INSERT INTO `preferences` VALUES (3, 'pre1Type', 0x31);
INSERT INTO `preferences` VALUES (3, 'showTopOrators', 0x31);
INSERT INTO `preferences` VALUES (3, 'topOratorCount', 0x3130);
INSERT INTO `preferences` VALUES (3, 'teamsListByScore', 0x30);
INSERT INTO `preferences` VALUES (3, 'hideOratorsLastRound', 0x31);
INSERT INTO `preferences` VALUES (3, 'noNewRegistration', 0x30);
INSERT INTO `preferences` VALUES (3, 'maxPrelimRounds', 0x35);
INSERT INTO `preferences` VALUES (3, 'maxFinalRounds', 0x36);
INSERT INTO `preferences` VALUES (3, 'noDoubleJeapordy', 0x31);
INSERT INTO `preferences` VALUES (3, 'generateAllPrelims', 0x31);
INSERT INTO `preferences` VALUES (3, 'keepTeamsInSameBldg', 0x31);
INSERT INTO `preferences` VALUES (3, 'feeAmount', 0x3735);
INSERT INTO `preferences` VALUES (3, 'tournamentOver', 0x3230303630313231313830303030);
INSERT INTO `preferences` VALUES (3, 'registrationCutoff', 0x3230303630313137303030303030);
INSERT INTO `preferences` VALUES (3, 'lateFeeAmount', 0x313030);
INSERT INTO `preferences` VALUES (3, 'lateFeeAfter', 0x3230303531323233);
INSERT INTO `texts` VALUES (3, 2, 'The tournament is concluded. Thank you to all of the judges, schools, participants, coaches and staff for making the tournament a success.');
INSERT INTO `texts` VALUES (3, 53, '3,0,0;2,0,1;2,1,0;1,0,2;1,1,1;1,2,0;0,0,3;0,1,2;0,2,1;0,3,0;2,0,0;1,0,1;0,0,2;0,1,1;0,2,0;1,0,0;0,0,1;0,1,0;0,0,0');
INSERT INTO `texts` VALUES (3, 55, '5,0,0;4,0,1;4,1,0;3,0,2;3,1,1;3,2,0;2,0,3;2,1,2;2,2,1;2,3,0;1,0,4;1,1,3;1,2,2;1,3,1;1,4,0;0,0,5;0,1,4;0,2,3;0,3,2;0,4,1;0,5,0;0,0,0;');
INSERT INTO `texts` VALUES (3, 54, '4,0,0;3,0,1;3,1,0;2,0,2;2,1,1;2,2,0;1,0,3;1,1,2;1,2,1;1,3,0;0,0,4;0,1,3;0,2,2;0,3,1;0,4,0;0,0,0;');
INSERT INTO `texts` VALUES (3, 52, '2,0,0;1,0,1;1,1,0;0,0,2;0,1,1;0,2,0;0,0,0;');
INSERT INTO `texts` VALUES (3, 51, '1,0,0;0,0,1;0,1,0;0,0,0;');
INSERT INTO `texts` VALUES (3, 1, 'Online registration for the 2006 National tournament will be available December 5, 2005, after all of the Regional Tournaments are concluded. Once the number of teams that automatically advance to the National Tournament are known, registration will open for the remaining slots.');
INSERT INTO `texts` VALUES (3, 3, 'No refunds will be given after January 27, 2006. Contact Jim Perry for information regarding the refund procedure.');
INSERT INTO `texts` VALUES (3, 100, '');
INSERT INTO `texts` VALUES (3, 101, '');

INSERT INTO `authentication` VALUES (4, AES_ENCRYPT("windycity","32CharactersOfRandomFun"), AES_ENCRYPT("AMCA","32CharactersOfRandomFun"), 2, 0);
INSERT INTO `tournaments` VALUES (4, 'ACMA Tournament', '', '', '', '', '', '', '', '', '', '', '0', '', '');
INSERT INTO `preferences` VALUES (4, 'newTeamNotify', 0x79dd9188c47937118222b0eabfe4267d);
INSERT INTO `preferences` VALUES (4, 'prelimRounds', 0x33);
INSERT INTO `preferences` VALUES (4, 'registrationOn', 0x30);
INSERT INTO `preferences` VALUES (4, 'campusMap', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f);
INSERT INTO `preferences` VALUES (4, 'campusMapFile', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f63616d7075736d61702e706466);
INSERT INTO `preferences` VALUES (4, 'administrator', 0x484dc36308eb8317d6d6babbe681b9c6b7ae29d9755962bb254defcb980e09f1);
INSERT INTO `preferences` VALUES (4, 'statusShowScores', 0x30);
INSERT INTO `preferences` VALUES (4, 'statusRefresh', 0x313230);
INSERT INTO `preferences` VALUES (4, 'registrationTeams', 0x31);
INSERT INTO `preferences` VALUES (4, 'registrationPayment', 0x31);
INSERT INTO `preferences` VALUES (4, 'tournamentDates', 0x4a616e75617279203230202d203231);
INSERT INTO `preferences` VALUES (4, 'tournamentLocation', 0x55542041726c696e67746f6e);
INSERT INTO `preferences` VALUES (4, 'refundPolicy', 0x726566756e642e747874);
INSERT INTO `preferences` VALUES (4, 'currentRound', 0x2d33);
INSERT INTO `preferences` VALUES (4, 'finalRounds', 0x35);
INSERT INTO `preferences` VALUES (4, 'cryptoStr', '');
INSERT INTO `preferences` VALUES (4, 'useVerify', 0x31);
INSERT INTO `preferences` VALUES (4, 'pre5Type', 0x30);
INSERT INTO `preferences` VALUES (4, 'pre4Type', 0x30);
INSERT INTO `preferences` VALUES (4, 'pre3Type', 0x33);
INSERT INTO `preferences` VALUES (4, 'pre2Type', 0x32);
INSERT INTO `preferences` VALUES (4, 'pre1Type', 0x31);
INSERT INTO `preferences` VALUES (4, 'showTopOrators', 0x31);
INSERT INTO `preferences` VALUES (4, 'topOratorCount', 0x3130);
INSERT INTO `preferences` VALUES (4, 'teamsListByScore', 0x30);
INSERT INTO `preferences` VALUES (4, 'hideOratorsLastRound', 0x31);
INSERT INTO `preferences` VALUES (4, 'noNewRegistration', 0x30);
INSERT INTO `preferences` VALUES (4, 'maxPrelimRounds', 0x35);
INSERT INTO `preferences` VALUES (4, 'maxFinalRounds', 0x36);
INSERT INTO `preferences` VALUES (4, 'noDoubleJeapordy', 0x31);
INSERT INTO `preferences` VALUES (4, 'generateAllPrelims', 0x31);
INSERT INTO `preferences` VALUES (4, 'keepTeamsInSameBldg', 0x31);
INSERT INTO `preferences` VALUES (4, 'feeAmount', 0x3735);
INSERT INTO `preferences` VALUES (4, 'tournamentOver', 0x3230303630313231313830303030);
INSERT INTO `preferences` VALUES (4, 'registrationCutoff', 0x3230303630313137303030303030);
INSERT INTO `preferences` VALUES (4, 'lateFeeAmount', 0x313030);
INSERT INTO `preferences` VALUES (4, 'lateFeeAfter', 0x3230303531323233);
INSERT INTO `texts` VALUES (4, 2, 'The tournament is concluded. Thank you to all of the judges, schools, participants, coaches and staff for making the tournament a success.');
INSERT INTO `texts` VALUES (4, 53, '3,0,0;2,0,1;2,1,0;1,0,2;1,1,1;1,2,0;0,0,3;0,1,2;0,2,1;0,3,0;2,0,0;1,0,1;0,0,2;0,1,1;0,2,0;1,0,0;0,0,1;0,1,0;0,0,0');
INSERT INTO `texts` VALUES (4, 55, '5,0,0;4,0,1;4,1,0;3,0,2;3,1,1;3,2,0;2,0,3;2,1,2;2,2,1;2,3,0;1,0,4;1,1,3;1,2,2;1,3,1;1,4,0;0,0,5;0,1,4;0,2,3;0,3,2;0,4,1;0,5,0;0,0,0;');
INSERT INTO `texts` VALUES (4, 54, '4,0,0;3,0,1;3,1,0;2,0,2;2,1,1;2,2,0;1,0,3;1,1,2;1,2,1;1,3,0;0,0,4;0,1,3;0,2,2;0,3,1;0,4,0;0,0,0;');
INSERT INTO `texts` VALUES (4, 52, '2,0,0;1,0,1;1,1,0;0,0,2;0,1,1;0,2,0;0,0,0;');
INSERT INTO `texts` VALUES (4, 51, '1,0,0;0,0,1;0,1,0;0,0,0;');
INSERT INTO `texts` VALUES (4, 1, 'Online registration for the 2006 National tournament will be available December 5, 2005, after all of the Regional Tournaments are concluded. Once the number of teams that automatically advance to the National Tournament are known, registration will open for the remaining slots.');
INSERT INTO `texts` VALUES (4, 3, 'No refunds will be given after January 27, 2006. Contact Jim Perry for information regarding the refund procedure.');
INSERT INTO `texts` VALUES (4, 100, '');
INSERT INTO `texts` VALUES (4, 101, '');

INSERT INTO `authentication` VALUES (5, AES_ENCRYPT("greatlakes","32CharactersOfRandomFun"), AES_ENCRYPT("AMCA","32CharactersOfRandomFun"), 2, 0);
INSERT INTO `tournaments` VALUES (5, 'ACMA Tournament', '', '', '', '', '', '', '', '', '', '', '0', '', '');
INSERT INTO `preferences` VALUES (5, 'newTeamNotify', 0x79dd9188c47937118222b0eabfe4267d);
INSERT INTO `preferences` VALUES (5, 'prelimRounds', 0x33);
INSERT INTO `preferences` VALUES (5, 'registrationOn', 0x30);
INSERT INTO `preferences` VALUES (5, 'campusMap', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f);
INSERT INTO `preferences` VALUES (5, 'campusMapFile', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f63616d7075736d61702e706466);
INSERT INTO `preferences` VALUES (5, 'administrator', 0x484dc36308eb8317d6d6babbe681b9c6b7ae29d9755962bb254defcb980e09f1);
INSERT INTO `preferences` VALUES (5, 'statusShowScores', 0x30);
INSERT INTO `preferences` VALUES (5, 'statusRefresh', 0x313230);
INSERT INTO `preferences` VALUES (5, 'registrationTeams', 0x31);
INSERT INTO `preferences` VALUES (5, 'registrationPayment', 0x31);
INSERT INTO `preferences` VALUES (5, 'tournamentDates', 0x4a616e75617279203230202d203231);
INSERT INTO `preferences` VALUES (5, 'tournamentLocation', 0x55542041726c696e67746f6e);
INSERT INTO `preferences` VALUES (5, 'refundPolicy', 0x726566756e642e747874);
INSERT INTO `preferences` VALUES (5, 'currentRound', 0x2d33);
INSERT INTO `preferences` VALUES (5, 'finalRounds', 0x35);
INSERT INTO `preferences` VALUES (5, 'cryptoStr', '');
INSERT INTO `preferences` VALUES (5, 'useVerify', 0x31);
INSERT INTO `preferences` VALUES (5, 'pre5Type', 0x30);
INSERT INTO `preferences` VALUES (5, 'pre4Type', 0x30);
INSERT INTO `preferences` VALUES (5, 'pre3Type', 0x33);
INSERT INTO `preferences` VALUES (5, 'pre2Type', 0x32);
INSERT INTO `preferences` VALUES (5, 'pre1Type', 0x31);
INSERT INTO `preferences` VALUES (5, 'showTopOrators', 0x31);
INSERT INTO `preferences` VALUES (5, 'topOratorCount', 0x3130);
INSERT INTO `preferences` VALUES (5, 'teamsListByScore', 0x30);
INSERT INTO `preferences` VALUES (5, 'hideOratorsLastRound', 0x31);
INSERT INTO `preferences` VALUES (5, 'noNewRegistration', 0x30);
INSERT INTO `preferences` VALUES (5, 'maxPrelimRounds', 0x35);
INSERT INTO `preferences` VALUES (5, 'maxFinalRounds', 0x36);
INSERT INTO `preferences` VALUES (5, 'noDoubleJeapordy', 0x31);
INSERT INTO `preferences` VALUES (5, 'generateAllPrelims', 0x31);
INSERT INTO `preferences` VALUES (5, 'keepTeamsInSameBldg', 0x31);
INSERT INTO `preferences` VALUES (5, 'feeAmount', 0x3735);
INSERT INTO `preferences` VALUES (5, 'tournamentOver', 0x3230303630313231313830303030);
INSERT INTO `preferences` VALUES (5, 'registrationCutoff', 0x3230303630313137303030303030);
INSERT INTO `preferences` VALUES (5, 'lateFeeAmount', 0x313030);
INSERT INTO `preferences` VALUES (5, 'lateFeeAfter', 0x3230303531323233);
INSERT INTO `texts` VALUES (5, 2, 'The tournament is concluded. Thank you to all of the judges, schools, participants, coaches and staff for making the tournament a success.');
INSERT INTO `texts` VALUES (5, 53, '3,0,0;2,0,1;2,1,0;1,0,2;1,1,1;1,2,0;0,0,3;0,1,2;0,2,1;0,3,0;2,0,0;1,0,1;0,0,2;0,1,1;0,2,0;1,0,0;0,0,1;0,1,0;0,0,0');
INSERT INTO `texts` VALUES (5, 55, '5,0,0;4,0,1;4,1,0;3,0,2;3,1,1;3,2,0;2,0,3;2,1,2;2,2,1;2,3,0;1,0,4;1,1,3;1,2,2;1,3,1;1,4,0;0,0,5;0,1,4;0,2,3;0,3,2;0,4,1;0,5,0;0,0,0;');
INSERT INTO `texts` VALUES (5, 54, '4,0,0;3,0,1;3,1,0;2,0,2;2,1,1;2,2,0;1,0,3;1,1,2;1,2,1;1,3,0;0,0,4;0,1,3;0,2,2;0,3,1;0,4,0;0,0,0;');
INSERT INTO `texts` VALUES (5, 52, '2,0,0;1,0,1;1,1,0;0,0,2;0,1,1;0,2,0;0,0,0;');
INSERT INTO `texts` VALUES (5, 51, '1,0,0;0,0,1;0,1,0;0,0,0;');
INSERT INTO `texts` VALUES (5, 1, 'Online registration for the 2006 National tournament will be available December 5, 2005, after all of the Regional Tournaments are concluded. Once the number of teams that automatically advance to the National Tournament are known, registration will open for the remaining slots.');
INSERT INTO `texts` VALUES (5, 3, 'No refunds will be given after January 27, 2006. Contact Jim Perry for information regarding the refund procedure.');
INSERT INTO `texts` VALUES (5, 100, '');
INSERT INTO `texts` VALUES (5, 101, '');

INSERT INTO `authentication` VALUES (6, AES_ENCRYPT("southatlantic","32CharactersOfRandomFun"), AES_ENCRYPT("AMCA","32CharactersOfRandomFun"), 2, 0);
INSERT INTO `tournaments` VALUES (6, 'ACMA Tournament', '', '', '', '', '', '', '', '', '', '', '0', '', '');
INSERT INTO `preferences` VALUES (6, 'newTeamNotify', 0x79dd9188c47937118222b0eabfe4267d);
INSERT INTO `preferences` VALUES (6, 'prelimRounds', 0x33);
INSERT INTO `preferences` VALUES (6, 'registrationOn', 0x30);
INSERT INTO `preferences` VALUES (6, 'campusMap', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f);
INSERT INTO `preferences` VALUES (6, 'campusMapFile', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f63616d7075736d61702e706466);
INSERT INTO `preferences` VALUES (6, 'administrator', 0x484dc36308eb8317d6d6babbe681b9c6b7ae29d9755962bb254defcb980e09f1);
INSERT INTO `preferences` VALUES (6, 'statusShowScores', 0x30);
INSERT INTO `preferences` VALUES (6, 'statusRefresh', 0x313230);
INSERT INTO `preferences` VALUES (6, 'registrationTeams', 0x31);
INSERT INTO `preferences` VALUES (6, 'registrationPayment', 0x31);
INSERT INTO `preferences` VALUES (6, 'tournamentDates', 0x4a616e75617279203230202d203231);
INSERT INTO `preferences` VALUES (6, 'tournamentLocation', 0x55542041726c696e67746f6e);
INSERT INTO `preferences` VALUES (6, 'refundPolicy', 0x726566756e642e747874);
INSERT INTO `preferences` VALUES (6, 'currentRound', 0x2d33);
INSERT INTO `preferences` VALUES (6, 'finalRounds', 0x35);
INSERT INTO `preferences` VALUES (6, 'cryptoStr', '');
INSERT INTO `preferences` VALUES (6, 'useVerify', 0x31);
INSERT INTO `preferences` VALUES (6, 'pre5Type', 0x30);
INSERT INTO `preferences` VALUES (6, 'pre4Type', 0x30);
INSERT INTO `preferences` VALUES (6, 'pre3Type', 0x33);
INSERT INTO `preferences` VALUES (6, 'pre2Type', 0x32);
INSERT INTO `preferences` VALUES (6, 'pre1Type', 0x31);
INSERT INTO `preferences` VALUES (6, 'showTopOrators', 0x31);
INSERT INTO `preferences` VALUES (6, 'topOratorCount', 0x3130);
INSERT INTO `preferences` VALUES (6, 'teamsListByScore', 0x30);
INSERT INTO `preferences` VALUES (6, 'hideOratorsLastRound', 0x31);
INSERT INTO `preferences` VALUES (6, 'noNewRegistration', 0x30);
INSERT INTO `preferences` VALUES (6, 'maxPrelimRounds', 0x35);
INSERT INTO `preferences` VALUES (6, 'maxFinalRounds', 0x36);
INSERT INTO `preferences` VALUES (6, 'noDoubleJeapordy', 0x31);
INSERT INTO `preferences` VALUES (6, 'generateAllPrelims', 0x31);
INSERT INTO `preferences` VALUES (6, 'keepTeamsInSameBldg', 0x31);
INSERT INTO `preferences` VALUES (6, 'feeAmount', 0x3735);
INSERT INTO `preferences` VALUES (6, 'tournamentOver', 0x3230303630313231313830303030);
INSERT INTO `preferences` VALUES (6, 'registrationCutoff', 0x3230303630313137303030303030);
INSERT INTO `preferences` VALUES (6, 'lateFeeAmount', 0x313030);
INSERT INTO `preferences` VALUES (6, 'lateFeeAfter', 0x3230303531323233);
INSERT INTO `texts` VALUES (6, 2, 'The tournament is concluded. Thank you to all of the judges, schools, participants, coaches and staff for making the tournament a success.');
INSERT INTO `texts` VALUES (6, 53, '3,0,0;2,0,1;2,1,0;1,0,2;1,1,1;1,2,0;0,0,3;0,1,2;0,2,1;0,3,0;2,0,0;1,0,1;0,0,2;0,1,1;0,2,0;1,0,0;0,0,1;0,1,0;0,0,0');
INSERT INTO `texts` VALUES (6, 55, '5,0,0;4,0,1;4,1,0;3,0,2;3,1,1;3,2,0;2,0,3;2,1,2;2,2,1;2,3,0;1,0,4;1,1,3;1,2,2;1,3,1;1,4,0;0,0,5;0,1,4;0,2,3;0,3,2;0,4,1;0,5,0;0,0,0;');
INSERT INTO `texts` VALUES (6, 54, '4,0,0;3,0,1;3,1,0;2,0,2;2,1,1;2,2,0;1,0,3;1,1,2;1,2,1;1,3,0;0,0,4;0,1,3;0,2,2;0,3,1;0,4,0;0,0,0;');
INSERT INTO `texts` VALUES (6, 52, '2,0,0;1,0,1;1,1,0;0,0,2;0,1,1;0,2,0;0,0,0;');
INSERT INTO `texts` VALUES (6, 51, '1,0,0;0,0,1;0,1,0;0,0,0;');
INSERT INTO `texts` VALUES (6, 1, 'Online registration for the 2006 National tournament will be available December 5, 2005, after all of the Regional Tournaments are concluded. Once the number of teams that automatically advance to the National Tournament are known, registration will open for the remaining slots.');
INSERT INTO `texts` VALUES (6, 3, 'No refunds will be given after January 27, 2006. Contact Jim Perry for information regarding the refund procedure.');
INSERT INTO `texts` VALUES (6, 100, '');
INSERT INTO `texts` VALUES (6, 101, '');

INSERT INTO `authentication` VALUES (7, AES_ENCRYPT("southeast","32CharactersOfRandomFun"), AES_ENCRYPT("AMCA","32CharactersOfRandomFun"), 2, 0);
INSERT INTO `tournaments` VALUES (7, 'ACMA Tournament', '', '', '', '', '', '', '', '', '', '', '0', '', '');
INSERT INTO `preferences` VALUES (7, 'newTeamNotify', 0x79dd9188c47937118222b0eabfe4267d);
INSERT INTO `preferences` VALUES (7, 'prelimRounds', 0x33);
INSERT INTO `preferences` VALUES (7, 'registrationOn', 0x30);
INSERT INTO `preferences` VALUES (7, 'campusMap', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f);
INSERT INTO `preferences` VALUES (7, 'campusMapFile', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f63616d7075736d61702e706466);
INSERT INTO `preferences` VALUES (7, 'administrator', 0x484dc36308eb8317d6d6babbe681b9c6b7ae29d9755962bb254defcb980e09f1);
INSERT INTO `preferences` VALUES (7, 'statusShowScores', 0x30);
INSERT INTO `preferences` VALUES (7, 'statusRefresh', 0x313230);
INSERT INTO `preferences` VALUES (7, 'registrationTeams', 0x31);
INSERT INTO `preferences` VALUES (7, 'registrationPayment', 0x31);
INSERT INTO `preferences` VALUES (7, 'tournamentDates', 0x4a616e75617279203230202d203231);
INSERT INTO `preferences` VALUES (7, 'tournamentLocation', 0x55542041726c696e67746f6e);
INSERT INTO `preferences` VALUES (7, 'refundPolicy', 0x726566756e642e747874);
INSERT INTO `preferences` VALUES (7, 'currentRound', 0x2d33);
INSERT INTO `preferences` VALUES (7, 'finalRounds', 0x35);
INSERT INTO `preferences` VALUES (7, 'cryptoStr', '');
INSERT INTO `preferences` VALUES (7, 'useVerify', 0x31);
INSERT INTO `preferences` VALUES (7, 'pre5Type', 0x30);
INSERT INTO `preferences` VALUES (7, 'pre4Type', 0x30);
INSERT INTO `preferences` VALUES (7, 'pre3Type', 0x33);
INSERT INTO `preferences` VALUES (7, 'pre2Type', 0x32);
INSERT INTO `preferences` VALUES (7, 'pre1Type', 0x31);
INSERT INTO `preferences` VALUES (7, 'showTopOrators', 0x31);
INSERT INTO `preferences` VALUES (7, 'topOratorCount', 0x3130);
INSERT INTO `preferences` VALUES (7, 'teamsListByScore', 0x30);
INSERT INTO `preferences` VALUES (7, 'hideOratorsLastRound', 0x31);
INSERT INTO `preferences` VALUES (7, 'noNewRegistration', 0x30);
INSERT INTO `preferences` VALUES (7, 'maxPrelimRounds', 0x35);
INSERT INTO `preferences` VALUES (7, 'maxFinalRounds', 0x36);
INSERT INTO `preferences` VALUES (7, 'noDoubleJeapordy', 0x31);
INSERT INTO `preferences` VALUES (7, 'generateAllPrelims', 0x31);
INSERT INTO `preferences` VALUES (7, 'keepTeamsInSameBldg', 0x31);
INSERT INTO `preferences` VALUES (7, 'feeAmount', 0x3735);
INSERT INTO `preferences` VALUES (7, 'tournamentOver', 0x3230303630313231313830303030);
INSERT INTO `preferences` VALUES (7, 'registrationCutoff', 0x3230303630313137303030303030);
INSERT INTO `preferences` VALUES (7, 'lateFeeAmount', 0x313030);
INSERT INTO `preferences` VALUES (7, 'lateFeeAfter', 0x3230303531323233);
INSERT INTO `texts` VALUES (7, 2, 'The tournament is concluded. Thank you to all of the judges, schools, participants, coaches and staff for making the tournament a success.');
INSERT INTO `texts` VALUES (7, 53, '3,0,0;2,0,1;2,1,0;1,0,2;1,1,1;1,2,0;0,0,3;0,1,2;0,2,1;0,3,0;2,0,0;1,0,1;0,0,2;0,1,1;0,2,0;1,0,0;0,0,1;0,1,0;0,0,0');
INSERT INTO `texts` VALUES (7, 55, '5,0,0;4,0,1;4,1,0;3,0,2;3,1,1;3,2,0;2,0,3;2,1,2;2,2,1;2,3,0;1,0,4;1,1,3;1,2,2;1,3,1;1,4,0;0,0,5;0,1,4;0,2,3;0,3,2;0,4,1;0,5,0;0,0,0;');
INSERT INTO `texts` VALUES (7, 54, '4,0,0;3,0,1;3,1,0;2,0,2;2,1,1;2,2,0;1,0,3;1,1,2;1,2,1;1,3,0;0,0,4;0,1,3;0,2,2;0,3,1;0,4,0;0,0,0;');
INSERT INTO `texts` VALUES (7, 52, '2,0,0;1,0,1;1,1,0;0,0,2;0,1,1;0,2,0;0,0,0;');
INSERT INTO `texts` VALUES (7, 51, '1,0,0;0,0,1;0,1,0;0,0,0;');
INSERT INTO `texts` VALUES (7, 1, 'Online registration for the 2006 National tournament will be available December 5, 2005, after all of the Regional Tournaments are concluded. Once the number of teams that automatically advance to the National Tournament are known, registration will open for the remaining slots.');
INSERT INTO `texts` VALUES (7, 3, 'No refunds will be given after January 27, 2006. Contact Jim Perry for information regarding the refund procedure.');
INSERT INTO `texts` VALUES (7, 100, '');
INSERT INTO `texts` VALUES (7, 101, '');

INSERT INTO `authentication` VALUES (8, AES_ENCRYPT("southtexas","32CharactersOfRandomFun"), AES_ENCRYPT("AMCA","32CharactersOfRandomFun"), 2, 0);
INSERT INTO `tournaments` VALUES (8, 'ACMA Tournament', '', '', '', '', '', '', '', '', '', '', '0', '', '');
INSERT INTO `preferences` VALUES (8, 'newTeamNotify', 0x79dd9188c47937118222b0eabfe4267d);
INSERT INTO `preferences` VALUES (8, 'prelimRounds', 0x33);
INSERT INTO `preferences` VALUES (8, 'registrationOn', 0x30);
INSERT INTO `preferences` VALUES (8, 'campusMap', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f);
INSERT INTO `preferences` VALUES (8, 'campusMapFile', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f63616d7075736d61702e706466);
INSERT INTO `preferences` VALUES (8, 'administrator', 0x484dc36308eb8317d6d6babbe681b9c6b7ae29d9755962bb254defcb980e09f1);
INSERT INTO `preferences` VALUES (8, 'statusShowScores', 0x30);
INSERT INTO `preferences` VALUES (8, 'statusRefresh', 0x313230);
INSERT INTO `preferences` VALUES (8, 'registrationTeams', 0x31);
INSERT INTO `preferences` VALUES (8, 'registrationPayment', 0x31);
INSERT INTO `preferences` VALUES (8, 'tournamentDates', 0x4a616e75617279203230202d203231);
INSERT INTO `preferences` VALUES (8, 'tournamentLocation', 0x55542041726c696e67746f6e);
INSERT INTO `preferences` VALUES (8, 'refundPolicy', 0x726566756e642e747874);
INSERT INTO `preferences` VALUES (8, 'currentRound', 0x2d33);
INSERT INTO `preferences` VALUES (8, 'finalRounds', 0x35);
INSERT INTO `preferences` VALUES (8, 'cryptoStr', '');
INSERT INTO `preferences` VALUES (8, 'useVerify', 0x31);
INSERT INTO `preferences` VALUES (8, 'pre5Type', 0x30);
INSERT INTO `preferences` VALUES (8, 'pre4Type', 0x30);
INSERT INTO `preferences` VALUES (8, 'pre3Type', 0x33);
INSERT INTO `preferences` VALUES (8, 'pre2Type', 0x32);
INSERT INTO `preferences` VALUES (8, 'pre1Type', 0x31);
INSERT INTO `preferences` VALUES (8, 'showTopOrators', 0x31);
INSERT INTO `preferences` VALUES (8, 'topOratorCount', 0x3130);
INSERT INTO `preferences` VALUES (8, 'teamsListByScore', 0x30);
INSERT INTO `preferences` VALUES (8, 'hideOratorsLastRound', 0x31);
INSERT INTO `preferences` VALUES (8, 'noNewRegistration', 0x30);
INSERT INTO `preferences` VALUES (8, 'maxPrelimRounds', 0x35);
INSERT INTO `preferences` VALUES (8, 'maxFinalRounds', 0x36);
INSERT INTO `preferences` VALUES (8, 'noDoubleJeapordy', 0x31);
INSERT INTO `preferences` VALUES (8, 'generateAllPrelims', 0x31);
INSERT INTO `preferences` VALUES (8, 'keepTeamsInSameBldg', 0x31);
INSERT INTO `preferences` VALUES (8, 'feeAmount', 0x3735);
INSERT INTO `preferences` VALUES (8, 'tournamentOver', 0x3230303630313231313830303030);
INSERT INTO `preferences` VALUES (8, 'registrationCutoff', 0x3230303630313137303030303030);
INSERT INTO `preferences` VALUES (8, 'lateFeeAmount', 0x313030);
INSERT INTO `preferences` VALUES (8, 'lateFeeAfter', 0x3230303531323233);
INSERT INTO `texts` VALUES (8, 2, 'The tournament is concluded. Thank you to all of the judges, schools, participants, coaches and staff for making the tournament a success.');
INSERT INTO `texts` VALUES (8, 53, '3,0,0;2,0,1;2,1,0;1,0,2;1,1,1;1,2,0;0,0,3;0,1,2;0,2,1;0,3,0;2,0,0;1,0,1;0,0,2;0,1,1;0,2,0;1,0,0;0,0,1;0,1,0;0,0,0');
INSERT INTO `texts` VALUES (8, 55, '5,0,0;4,0,1;4,1,0;3,0,2;3,1,1;3,2,0;2,0,3;2,1,2;2,2,1;2,3,0;1,0,4;1,1,3;1,2,2;1,3,1;1,4,0;0,0,5;0,1,4;0,2,3;0,3,2;0,4,1;0,5,0;0,0,0;');
INSERT INTO `texts` VALUES (8, 54, '4,0,0;3,0,1;3,1,0;2,0,2;2,1,1;2,2,0;1,0,3;1,1,2;1,2,1;1,3,0;0,0,4;0,1,3;0,2,2;0,3,1;0,4,0;0,0,0;');
INSERT INTO `texts` VALUES (8, 52, '2,0,0;1,0,1;1,1,0;0,0,2;0,1,1;0,2,0;0,0,0;');
INSERT INTO `texts` VALUES (8, 51, '1,0,0;0,0,1;0,1,0;0,0,0;');
INSERT INTO `texts` VALUES (8, 1, 'Online registration for the 2006 National tournament will be available December 5, 2005, after all of the Regional Tournaments are concluded. Once the number of teams that automatically advance to the National Tournament are known, registration will open for the remaining slots.');
INSERT INTO `texts` VALUES (8, 3, 'No refunds will be given after January 27, 2006. Contact Jim Perry for information regarding the refund procedure.');
INSERT INTO `texts` VALUES (8, 100, '');
INSERT INTO `texts` VALUES (8, 101, '');

INSERT INTO `authentication` VALUES (9, AES_ENCRYPT("atchafalaya","32CharactersOfRandomFun"), AES_ENCRYPT("AMCA","32CharactersOfRandomFun"), 2, 0);
INSERT INTO `tournaments` VALUES (9, 'ACMA Tournament', '', '', '', '', '', '', '', '', '', '', '0', '', '');
INSERT INTO `preferences` VALUES (9, 'newTeamNotify', 0x79dd9188c47937118222b0eabfe4267d);
INSERT INTO `preferences` VALUES (9, 'prelimRounds', 0x33);
INSERT INTO `preferences` VALUES (9, 'registrationOn', 0x30);
INSERT INTO `preferences` VALUES (9, 'campusMap', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f);
INSERT INTO `preferences` VALUES (9, 'campusMapFile', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f63616d7075736d61702e706466);
INSERT INTO `preferences` VALUES (9, 'administrator', 0x484dc36308eb8317d6d6babbe681b9c6b7ae29d9755962bb254defcb980e09f1);
INSERT INTO `preferences` VALUES (9, 'statusShowScores', 0x30);
INSERT INTO `preferences` VALUES (9, 'statusRefresh', 0x313230);
INSERT INTO `preferences` VALUES (9, 'registrationTeams', 0x31);
INSERT INTO `preferences` VALUES (9, 'registrationPayment', 0x31);
INSERT INTO `preferences` VALUES (9, 'tournamentDates', 0x4a616e75617279203230202d203231);
INSERT INTO `preferences` VALUES (9, 'tournamentLocation', 0x55542041726c696e67746f6e);
INSERT INTO `preferences` VALUES (9, 'refundPolicy', 0x726566756e642e747874);
INSERT INTO `preferences` VALUES (9, 'currentRound', 0x2d33);
INSERT INTO `preferences` VALUES (9, 'finalRounds', 0x35);
INSERT INTO `preferences` VALUES (9, 'cryptoStr', '');
INSERT INTO `preferences` VALUES (9, 'useVerify', 0x31);
INSERT INTO `preferences` VALUES (9, 'pre5Type', 0x30);
INSERT INTO `preferences` VALUES (9, 'pre4Type', 0x30);
INSERT INTO `preferences` VALUES (9, 'pre3Type', 0x33);
INSERT INTO `preferences` VALUES (9, 'pre2Type', 0x32);
INSERT INTO `preferences` VALUES (9, 'pre1Type', 0x31);
INSERT INTO `preferences` VALUES (9, 'showTopOrators', 0x31);
INSERT INTO `preferences` VALUES (9, 'topOratorCount', 0x3130);
INSERT INTO `preferences` VALUES (9, 'teamsListByScore', 0x30);
INSERT INTO `preferences` VALUES (9, 'hideOratorsLastRound', 0x31);
INSERT INTO `preferences` VALUES (9, 'noNewRegistration', 0x30);
INSERT INTO `preferences` VALUES (9, 'maxPrelimRounds', 0x35);
INSERT INTO `preferences` VALUES (9, 'maxFinalRounds', 0x36);
INSERT INTO `preferences` VALUES (9, 'noDoubleJeapordy', 0x31);
INSERT INTO `preferences` VALUES (9, 'generateAllPrelims', 0x31);
INSERT INTO `preferences` VALUES (9, 'keepTeamsInSameBldg', 0x31);
INSERT INTO `preferences` VALUES (9, 'feeAmount', 0x3735);
INSERT INTO `preferences` VALUES (9, 'tournamentOver', 0x3230303630313231313830303030);
INSERT INTO `preferences` VALUES (9, 'registrationCutoff', 0x3230303630313137303030303030);
INSERT INTO `preferences` VALUES (9, 'lateFeeAmount', 0x313030);
INSERT INTO `preferences` VALUES (9, 'lateFeeAfter', 0x3230303531323233);
INSERT INTO `texts` VALUES (9, 2, 'The tournament is concluded. Thank you to all of the judges, schools, participants, coaches and staff for making the tournament a success.');
INSERT INTO `texts` VALUES (9, 53, '3,0,0;2,0,1;2,1,0;1,0,2;1,1,1;1,2,0;0,0,3;0,1,2;0,2,1;0,3,0;2,0,0;1,0,1;0,0,2;0,1,1;0,2,0;1,0,0;0,0,1;0,1,0;0,0,0');
INSERT INTO `texts` VALUES (9, 55, '5,0,0;4,0,1;4,1,0;3,0,2;3,1,1;3,2,0;2,0,3;2,1,2;2,2,1;2,3,0;1,0,4;1,1,3;1,2,2;1,3,1;1,4,0;0,0,5;0,1,4;0,2,3;0,3,2;0,4,1;0,5,0;0,0,0;');
INSERT INTO `texts` VALUES (9, 54, '4,0,0;3,0,1;3,1,0;2,0,2;2,1,1;2,2,0;1,0,3;1,1,2;1,2,1;1,3,0;0,0,4;0,1,3;0,2,2;0,3,1;0,4,0;0,0,0;');
INSERT INTO `texts` VALUES (9, 52, '2,0,0;1,0,1;1,1,0;0,0,2;0,1,1;0,2,0;0,0,0;');
INSERT INTO `texts` VALUES (9, 51, '1,0,0;0,0,1;0,1,0;0,0,0;');
INSERT INTO `texts` VALUES (9, 1, 'Online registration for the 2006 National tournament will be available December 5, 2005, after all of the Regional Tournaments are concluded. Once the number of teams that automatically advance to the National Tournament are known, registration will open for the remaining slots.');
INSERT INTO `texts` VALUES (9, 3, 'No refunds will be given after January 27, 2006. Contact Jim Perry for information regarding the refund procedure.');
INSERT INTO `texts` VALUES (9, 100, '');
INSERT INTO `texts` VALUES (9, 101, '');

INSERT INTO `authentication` VALUES (10, AES_ENCRYPT("eastern","32CharactersOfRandomFun"), AES_ENCRYPT("AMCA","32CharactersOfRandomFun"), 2, 0);
INSERT INTO `tournaments` VALUES (10, 'ACMA Tournament', '', '', '', '', '', '', '', '', '', '', '0', '', '');
INSERT INTO `preferences` VALUES (10, 'newTeamNotify', 0x79dd9188c47937118222b0eabfe4267d);
INSERT INTO `preferences` VALUES (10, 'prelimRounds', 0x33);
INSERT INTO `preferences` VALUES (10, 'registrationOn', 0x30);
INSERT INTO `preferences` VALUES (10, 'campusMap', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f);
INSERT INTO `preferences` VALUES (10, 'campusMapFile', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f63616d7075736d61702e706466);
INSERT INTO `preferences` VALUES (10, 'administrator', 0x484dc36308eb8317d6d6babbe681b9c6b7ae29d9755962bb254defcb980e09f1);
INSERT INTO `preferences` VALUES (10, 'statusShowScores', 0x30);
INSERT INTO `preferences` VALUES (10, 'statusRefresh', 0x313230);
INSERT INTO `preferences` VALUES (10, 'registrationTeams', 0x31);
INSERT INTO `preferences` VALUES (10, 'registrationPayment', 0x31);
INSERT INTO `preferences` VALUES (10, 'tournamentDates', 0x4a616e75617279203230202d203231);
INSERT INTO `preferences` VALUES (10, 'tournamentLocation', 0x55542041726c696e67746f6e);
INSERT INTO `preferences` VALUES (10, 'refundPolicy', 0x726566756e642e747874);
INSERT INTO `preferences` VALUES (10, 'currentRound', 0x2d33);
INSERT INTO `preferences` VALUES (10, 'finalRounds', 0x35);
INSERT INTO `preferences` VALUES (10, 'cryptoStr', '');
INSERT INTO `preferences` VALUES (10, 'useVerify', 0x31);
INSERT INTO `preferences` VALUES (10, 'pre5Type', 0x30);
INSERT INTO `preferences` VALUES (10, 'pre4Type', 0x30);
INSERT INTO `preferences` VALUES (10, 'pre3Type', 0x33);
INSERT INTO `preferences` VALUES (10, 'pre2Type', 0x32);
INSERT INTO `preferences` VALUES (10, 'pre1Type', 0x31);
INSERT INTO `preferences` VALUES (10, 'showTopOrators', 0x31);
INSERT INTO `preferences` VALUES (10, 'topOratorCount', 0x3130);
INSERT INTO `preferences` VALUES (10, 'teamsListByScore', 0x30);
INSERT INTO `preferences` VALUES (10, 'hideOratorsLastRound', 0x31);
INSERT INTO `preferences` VALUES (10, 'noNewRegistration', 0x30);
INSERT INTO `preferences` VALUES (10, 'maxPrelimRounds', 0x35);
INSERT INTO `preferences` VALUES (10, 'maxFinalRounds', 0x36);
INSERT INTO `preferences` VALUES (10, 'noDoubleJeapordy', 0x31);
INSERT INTO `preferences` VALUES (10, 'generateAllPrelims', 0x31);
INSERT INTO `preferences` VALUES (10, 'keepTeamsInSameBldg', 0x31);
INSERT INTO `preferences` VALUES (10, 'feeAmount', 0x3735);
INSERT INTO `preferences` VALUES (10, 'tournamentOver', 0x3230303630313231313830303030);
INSERT INTO `preferences` VALUES (10, 'registrationCutoff', 0x3230303630313137303030303030);
INSERT INTO `preferences` VALUES (10, 'lateFeeAmount', 0x313030);
INSERT INTO `preferences` VALUES (10, 'lateFeeAfter', 0x3230303531323233);
INSERT INTO `texts` VALUES (10, 2, 'The tournament is concluded. Thank you to all of the judges, schools, participants, coaches and staff for making the tournament a success.');
INSERT INTO `texts` VALUES (10, 53, '3,0,0;2,0,1;2,1,0;1,0,2;1,1,1;1,2,0;0,0,3;0,1,2;0,2,1;0,3,0;2,0,0;1,0,1;0,0,2;0,1,1;0,2,0;1,0,0;0,0,1;0,1,0;0,0,0');
INSERT INTO `texts` VALUES (10, 55, '5,0,0;4,0,1;4,1,0;3,0,2;3,1,1;3,2,0;2,0,3;2,1,2;2,2,1;2,3,0;1,0,4;1,1,3;1,2,2;1,3,1;1,4,0;0,0,5;0,1,4;0,2,3;0,3,2;0,4,1;0,5,0;0,0,0;');
INSERT INTO `texts` VALUES (10, 54, '4,0,0;3,0,1;3,1,0;2,0,2;2,1,1;2,2,0;1,0,3;1,1,2;1,2,1;1,3,0;0,0,4;0,1,3;0,2,2;0,3,1;0,4,0;0,0,0;');
INSERT INTO `texts` VALUES (10, 52, '2,0,0;1,0,1;1,1,0;0,0,2;0,1,1;0,2,0;0,0,0;');
INSERT INTO `texts` VALUES (10, 51, '1,0,0;0,0,1;0,1,0;0,0,0;');
INSERT INTO `texts` VALUES (10, 1, 'Online registration for the 2006 National tournament will be available December 5, 2005, after all of the Regional Tournaments are concluded. Once the number of teams that automatically advance to the National Tournament are known, registration will open for the remaining slots.');
INSERT INTO `texts` VALUES (10, 3, 'No refunds will be given after January 27, 2006. Contact Jim Perry for information regarding the refund procedure.');
INSERT INTO `texts` VALUES (10, 100, '');
INSERT INTO `texts` VALUES (10, 101, '');

INSERT INTO `authentication` VALUES (11, AES_ENCRYPT("midwest","32CharactersOfRandomFun"), AES_ENCRYPT("AMCA","32CharactersOfRandomFun"), 2, 0);
INSERT INTO `tournaments` VALUES (11, 'ACMA Tournament', '', '', '', '', '', '', '', '', '', '', '0', '', '');
INSERT INTO `preferences` VALUES (11, 'newTeamNotify', 0x79dd9188c47937118222b0eabfe4267d);
INSERT INTO `preferences` VALUES (11, 'prelimRounds', 0x33);
INSERT INTO `preferences` VALUES (11, 'registrationOn', 0x30);
INSERT INTO `preferences` VALUES (11, 'campusMap', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f);
INSERT INTO `preferences` VALUES (11, 'campusMapFile', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f63616d7075736d61702e706466);
INSERT INTO `preferences` VALUES (11, 'administrator', 0x484dc36308eb8317d6d6babbe681b9c6b7ae29d9755962bb254defcb980e09f1);
INSERT INTO `preferences` VALUES (11, 'statusShowScores', 0x30);
INSERT INTO `preferences` VALUES (11, 'statusRefresh', 0x313230);
INSERT INTO `preferences` VALUES (11, 'registrationTeams', 0x31);
INSERT INTO `preferences` VALUES (11, 'registrationPayment', 0x31);
INSERT INTO `preferences` VALUES (11, 'tournamentDates', 0x4a616e75617279203230202d203231);
INSERT INTO `preferences` VALUES (11, 'tournamentLocation', 0x55542041726c696e67746f6e);
INSERT INTO `preferences` VALUES (11, 'refundPolicy', 0x726566756e642e747874);
INSERT INTO `preferences` VALUES (11, 'currentRound', 0x2d33);
INSERT INTO `preferences` VALUES (11, 'finalRounds', 0x35);
INSERT INTO `preferences` VALUES (11, 'cryptoStr', '');
INSERT INTO `preferences` VALUES (11, 'useVerify', 0x31);
INSERT INTO `preferences` VALUES (11, 'pre5Type', 0x30);
INSERT INTO `preferences` VALUES (11, 'pre4Type', 0x30);
INSERT INTO `preferences` VALUES (11, 'pre3Type', 0x33);
INSERT INTO `preferences` VALUES (11, 'pre2Type', 0x32);
INSERT INTO `preferences` VALUES (11, 'pre1Type', 0x31);
INSERT INTO `preferences` VALUES (11, 'showTopOrators', 0x31);
INSERT INTO `preferences` VALUES (11, 'topOratorCount', 0x3130);
INSERT INTO `preferences` VALUES (11, 'teamsListByScore', 0x30);
INSERT INTO `preferences` VALUES (11, 'hideOratorsLastRound', 0x31);
INSERT INTO `preferences` VALUES (11, 'noNewRegistration', 0x30);
INSERT INTO `preferences` VALUES (11, 'maxPrelimRounds', 0x35);
INSERT INTO `preferences` VALUES (11, 'maxFinalRounds', 0x36);
INSERT INTO `preferences` VALUES (11, 'noDoubleJeapordy', 0x31);
INSERT INTO `preferences` VALUES (11, 'generateAllPrelims', 0x31);
INSERT INTO `preferences` VALUES (11, 'keepTeamsInSameBldg', 0x31);
INSERT INTO `preferences` VALUES (11, 'feeAmount', 0x3735);
INSERT INTO `preferences` VALUES (11, 'tournamentOver', 0x3230303630313231313830303030);
INSERT INTO `preferences` VALUES (11, 'registrationCutoff', 0x3230303630313137303030303030);
INSERT INTO `preferences` VALUES (11, 'lateFeeAmount', 0x313030);
INSERT INTO `preferences` VALUES (11, 'lateFeeAfter', 0x3230303531323233);
INSERT INTO `texts` VALUES (11, 2, 'The tournament is concluded. Thank you to all of the judges, schools, participants, coaches and staff for making the tournament a success.');
INSERT INTO `texts` VALUES (11, 53, '3,0,0;2,0,1;2,1,0;1,0,2;1,1,1;1,2,0;0,0,3;0,1,2;0,2,1;0,3,0;2,0,0;1,0,1;0,0,2;0,1,1;0,2,0;1,0,0;0,0,1;0,1,0;0,0,0');
INSERT INTO `texts` VALUES (11, 55, '5,0,0;4,0,1;4,1,0;3,0,2;3,1,1;3,2,0;2,0,3;2,1,2;2,2,1;2,3,0;1,0,4;1,1,3;1,2,2;1,3,1;1,4,0;0,0,5;0,1,4;0,2,3;0,3,2;0,4,1;0,5,0;0,0,0;');
INSERT INTO `texts` VALUES (11, 54, '4,0,0;3,0,1;3,1,0;2,0,2;2,1,1;2,2,0;1,0,3;1,1,2;1,2,1;1,3,0;0,0,4;0,1,3;0,2,2;0,3,1;0,4,0;0,0,0;');
INSERT INTO `texts` VALUES (11, 52, '2,0,0;1,0,1;1,1,0;0,0,2;0,1,1;0,2,0;0,0,0;');
INSERT INTO `texts` VALUES (11, 51, '1,0,0;0,0,1;0,1,0;0,0,0;');
INSERT INTO `texts` VALUES (11, 1, 'Online registration for the 2006 National tournament will be available December 5, 2005, after all of the Regional Tournaments are concluded. Once the number of teams that automatically advance to the National Tournament are known, registration will open for the remaining slots.');
INSERT INTO `texts` VALUES (11, 3, 'No refunds will be given after January 27, 2006. Contact Jim Perry for information regarding the refund procedure.');
INSERT INTO `texts` VALUES (11, 100, '');
INSERT INTO `texts` VALUES (11, 101, '');

INSERT INTO `authentication` VALUES (12, AES_ENCRYPT("southcentral","32CharactersOfRandomFun"), AES_ENCRYPT("AMCA","32CharactersOfRandomFun"), 2, 0);
INSERT INTO `tournaments` VALUES (12, 'ACMA Tournament', '', '', '', '', '', '', '', '', '', '', '0', '', '');
INSERT INTO `preferences` VALUES (12, 'newTeamNotify', 0x79dd9188c47937118222b0eabfe4267d);
INSERT INTO `preferences` VALUES (12, 'prelimRounds', 0x33);
INSERT INTO `preferences` VALUES (12, 'registrationOn', 0x30);
INSERT INTO `preferences` VALUES (12, 'campusMap', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f);
INSERT INTO `preferences` VALUES (12, 'campusMapFile', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f63616d7075736d61702e706466);
INSERT INTO `preferences` VALUES (12, 'administrator', 0x484dc36308eb8317d6d6babbe681b9c6b7ae29d9755962bb254defcb980e09f1);
INSERT INTO `preferences` VALUES (12, 'statusShowScores', 0x30);
INSERT INTO `preferences` VALUES (12, 'statusRefresh', 0x313230);
INSERT INTO `preferences` VALUES (12, 'registrationTeams', 0x31);
INSERT INTO `preferences` VALUES (12, 'registrationPayment', 0x31);
INSERT INTO `preferences` VALUES (12, 'tournamentDates', 0x4a616e75617279203230202d203231);
INSERT INTO `preferences` VALUES (12, 'tournamentLocation', 0x55542041726c696e67746f6e);
INSERT INTO `preferences` VALUES (12, 'refundPolicy', 0x726566756e642e747874);
INSERT INTO `preferences` VALUES (12, 'currentRound', 0x2d33);
INSERT INTO `preferences` VALUES (12, 'finalRounds', 0x35);
INSERT INTO `preferences` VALUES (12, 'cryptoStr', '');
INSERT INTO `preferences` VALUES (12, 'useVerify', 0x31);
INSERT INTO `preferences` VALUES (12, 'pre5Type', 0x30);
INSERT INTO `preferences` VALUES (12, 'pre4Type', 0x30);
INSERT INTO `preferences` VALUES (12, 'pre3Type', 0x33);
INSERT INTO `preferences` VALUES (12, 'pre2Type', 0x32);
INSERT INTO `preferences` VALUES (12, 'pre1Type', 0x31);
INSERT INTO `preferences` VALUES (12, 'showTopOrators', 0x31);
INSERT INTO `preferences` VALUES (12, 'topOratorCount', 0x3130);
INSERT INTO `preferences` VALUES (12, 'teamsListByScore', 0x30);
INSERT INTO `preferences` VALUES (12, 'hideOratorsLastRound', 0x31);
INSERT INTO `preferences` VALUES (12, 'noNewRegistration', 0x30);
INSERT INTO `preferences` VALUES (12, 'maxPrelimRounds', 0x35);
INSERT INTO `preferences` VALUES (12, 'maxFinalRounds', 0x36);
INSERT INTO `preferences` VALUES (12, 'noDoubleJeapordy', 0x31);
INSERT INTO `preferences` VALUES (12, 'generateAllPrelims', 0x31);
INSERT INTO `preferences` VALUES (12, 'keepTeamsInSameBldg', 0x31);
INSERT INTO `preferences` VALUES (12, 'feeAmount', 0x3735);
INSERT INTO `preferences` VALUES (12, 'tournamentOver', 0x3230303630313231313830303030);
INSERT INTO `preferences` VALUES (12, 'registrationCutoff', 0x3230303630313137303030303030);
INSERT INTO `preferences` VALUES (12, 'lateFeeAmount', 0x313030);
INSERT INTO `preferences` VALUES (12, 'lateFeeAfter', 0x3230303531323233);
INSERT INTO `texts` VALUES (12, 2, 'The tournament is concluded. Thank you to all of the judges, schools, participants, coaches and staff for making the tournament a success.');
INSERT INTO `texts` VALUES (12, 53, '3,0,0;2,0,1;2,1,0;1,0,2;1,1,1;1,2,0;0,0,3;0,1,2;0,2,1;0,3,0;2,0,0;1,0,1;0,0,2;0,1,1;0,2,0;1,0,0;0,0,1;0,1,0;0,0,0');
INSERT INTO `texts` VALUES (12, 55, '5,0,0;4,0,1;4,1,0;3,0,2;3,1,1;3,2,0;2,0,3;2,1,2;2,2,1;2,3,0;1,0,4;1,1,3;1,2,2;1,3,1;1,4,0;0,0,5;0,1,4;0,2,3;0,3,2;0,4,1;0,5,0;0,0,0;');
INSERT INTO `texts` VALUES (12, 54, '4,0,0;3,0,1;3,1,0;2,0,2;2,1,1;2,2,0;1,0,3;1,1,2;1,2,1;1,3,0;0,0,4;0,1,3;0,2,2;0,3,1;0,4,0;0,0,0;');
INSERT INTO `texts` VALUES (12, 52, '2,0,0;1,0,1;1,1,0;0,0,2;0,1,1;0,2,0;0,0,0;');
INSERT INTO `texts` VALUES (12, 51, '1,0,0;0,0,1;0,1,0;0,0,0;');
INSERT INTO `texts` VALUES (12, 1, 'Online registration for the 2006 National tournament will be available December 5, 2005, after all of the Regional Tournaments are concluded. Once the number of teams that automatically advance to the National Tournament are known, registration will open for the remaining slots.');
INSERT INTO `texts` VALUES (12, 3, 'No refunds will be given after January 27, 2006. Contact Jim Perry for information regarding the refund procedure.');
INSERT INTO `texts` VALUES (12, 100, '');
INSERT INTO `texts` VALUES (12, 101, '');

INSERT INTO `authentication` VALUES (13, AES_ENCRYPT("empirestate","32CharactersOfRandomFun"), AES_ENCRYPT("AMCA","32CharactersOfRandomFun"), 2, 0);
INSERT INTO `tournaments` VALUES (13, 'ACMA Tournament', '', '', '', '', '', '', '', '', '', '', '0', '', '');
INSERT INTO `preferences` VALUES (13, 'newTeamNotify', 0x79dd9188c47937118222b0eabfe4267d);
INSERT INTO `preferences` VALUES (13, 'prelimRounds', 0x33);
INSERT INTO `preferences` VALUES (13, 'registrationOn', 0x30);
INSERT INTO `preferences` VALUES (13, 'campusMap', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f);
INSERT INTO `preferences` VALUES (13, 'campusMapFile', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f63616d7075736d61702e706466);
INSERT INTO `preferences` VALUES (13, 'administrator', 0x484dc36308eb8317d6d6babbe681b9c6b7ae29d9755962bb254defcb980e09f1);
INSERT INTO `preferences` VALUES (13, 'statusShowScores', 0x30);
INSERT INTO `preferences` VALUES (13, 'statusRefresh', 0x313230);
INSERT INTO `preferences` VALUES (13, 'registrationTeams', 0x31);
INSERT INTO `preferences` VALUES (13, 'registrationPayment', 0x31);
INSERT INTO `preferences` VALUES (13, 'tournamentDates', 0x4a616e75617279203230202d203231);
INSERT INTO `preferences` VALUES (13, 'tournamentLocation', 0x55542041726c696e67746f6e);
INSERT INTO `preferences` VALUES (13, 'refundPolicy', 0x726566756e642e747874);
INSERT INTO `preferences` VALUES (13, 'currentRound', 0x2d33);
INSERT INTO `preferences` VALUES (13, 'finalRounds', 0x35);
INSERT INTO `preferences` VALUES (13, 'cryptoStr', '');
INSERT INTO `preferences` VALUES (13, 'useVerify', 0x31);
INSERT INTO `preferences` VALUES (13, 'pre5Type', 0x30);
INSERT INTO `preferences` VALUES (13, 'pre4Type', 0x30);
INSERT INTO `preferences` VALUES (13, 'pre3Type', 0x33);
INSERT INTO `preferences` VALUES (13, 'pre2Type', 0x32);
INSERT INTO `preferences` VALUES (13, 'pre1Type', 0x31);
INSERT INTO `preferences` VALUES (13, 'showTopOrators', 0x31);
INSERT INTO `preferences` VALUES (13, 'topOratorCount', 0x3130);
INSERT INTO `preferences` VALUES (13, 'teamsListByScore', 0x30);
INSERT INTO `preferences` VALUES (13, 'hideOratorsLastRound', 0x31);
INSERT INTO `preferences` VALUES (13, 'noNewRegistration', 0x30);
INSERT INTO `preferences` VALUES (13, 'maxPrelimRounds', 0x35);
INSERT INTO `preferences` VALUES (13, 'maxFinalRounds', 0x36);
INSERT INTO `preferences` VALUES (13, 'noDoubleJeapordy', 0x31);
INSERT INTO `preferences` VALUES (13, 'generateAllPrelims', 0x31);
INSERT INTO `preferences` VALUES (13, 'keepTeamsInSameBldg', 0x31);
INSERT INTO `preferences` VALUES (13, 'feeAmount', 0x3735);
INSERT INTO `preferences` VALUES (13, 'tournamentOver', 0x3230303630313231313830303030);
INSERT INTO `preferences` VALUES (13, 'registrationCutoff', 0x3230303630313137303030303030);
INSERT INTO `preferences` VALUES (13, 'lateFeeAmount', 0x313030);
INSERT INTO `preferences` VALUES (13, 'lateFeeAfter', 0x3230303531323233);
INSERT INTO `texts` VALUES (13, 2, 'The tournament is concluded. Thank you to all of the judges, schools, participants, coaches and staff for making the tournament a success.');
INSERT INTO `texts` VALUES (13, 53, '3,0,0;2,0,1;2,1,0;1,0,2;1,1,1;1,2,0;0,0,3;0,1,2;0,2,1;0,3,0;2,0,0;1,0,1;0,0,2;0,1,1;0,2,0;1,0,0;0,0,1;0,1,0;0,0,0');
INSERT INTO `texts` VALUES (13, 55, '5,0,0;4,0,1;4,1,0;3,0,2;3,1,1;3,2,0;2,0,3;2,1,2;2,2,1;2,3,0;1,0,4;1,1,3;1,2,2;1,3,1;1,4,0;0,0,5;0,1,4;0,2,3;0,3,2;0,4,1;0,5,0;0,0,0;');
INSERT INTO `texts` VALUES (13, 54, '4,0,0;3,0,1;3,1,0;2,0,2;2,1,1;2,2,0;1,0,3;1,1,2;1,2,1;1,3,0;0,0,4;0,1,3;0,2,2;0,3,1;0,4,0;0,0,0;');
INSERT INTO `texts` VALUES (13, 52, '2,0,0;1,0,1;1,1,0;0,0,2;0,1,1;0,2,0;0,0,0;');
INSERT INTO `texts` VALUES (13, 51, '1,0,0;0,0,1;0,1,0;0,0,0;');
INSERT INTO `texts` VALUES (13, 1, 'Online registration for the 2006 National tournament will be available December 5, 2005, after all of the Regional Tournaments are concluded. Once the number of teams that automatically advance to the National Tournament are known, registration will open for the remaining slots.');
INSERT INTO `texts` VALUES (13, 3, 'No refunds will be given after January 27, 2006. Contact Jim Perry for information regarding the refund procedure.');
INSERT INTO `texts` VALUES (13, 100, '');
INSERT INTO `texts` VALUES (13, 101, '');

INSERT INTO `authentication` VALUES (14, AES_ENCRYPT("newengland","32CharactersOfRandomFun"), AES_ENCRYPT("AMCA","32CharactersOfRandomFun"), 2, 0);
INSERT INTO `tournaments` VALUES (14, 'ACMA Tournament', '', '', '', '', '', '', '', '', '', '', '0', '', '');
INSERT INTO `preferences` VALUES (14, 'newTeamNotify', 0x79dd9188c47937118222b0eabfe4267d);
INSERT INTO `preferences` VALUES (14, 'prelimRounds', 0x33);
INSERT INTO `preferences` VALUES (14, 'registrationOn', 0x30);
INSERT INTO `preferences` VALUES (14, 'campusMap', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f);
INSERT INTO `preferences` VALUES (14, 'campusMapFile', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f63616d7075736d61702e706466);
INSERT INTO `preferences` VALUES (14, 'administrator', 0x484dc36308eb8317d6d6babbe681b9c6b7ae29d9755962bb254defcb980e09f1);
INSERT INTO `preferences` VALUES (14, 'statusShowScores', 0x30);
INSERT INTO `preferences` VALUES (14, 'statusRefresh', 0x313230);
INSERT INTO `preferences` VALUES (14, 'registrationTeams', 0x31);
INSERT INTO `preferences` VALUES (14, 'registrationPayment', 0x31);
INSERT INTO `preferences` VALUES (14, 'tournamentDates', 0x4a616e75617279203230202d203231);
INSERT INTO `preferences` VALUES (14, 'tournamentLocation', 0x55542041726c696e67746f6e);
INSERT INTO `preferences` VALUES (14, 'refundPolicy', 0x726566756e642e747874);
INSERT INTO `preferences` VALUES (14, 'currentRound', 0x2d33);
INSERT INTO `preferences` VALUES (14, 'finalRounds', 0x35);
INSERT INTO `preferences` VALUES (14, 'cryptoStr', '');
INSERT INTO `preferences` VALUES (14, 'useVerify', 0x31);
INSERT INTO `preferences` VALUES (14, 'pre5Type', 0x30);
INSERT INTO `preferences` VALUES (14, 'pre4Type', 0x30);
INSERT INTO `preferences` VALUES (14, 'pre3Type', 0x33);
INSERT INTO `preferences` VALUES (14, 'pre2Type', 0x32);
INSERT INTO `preferences` VALUES (14, 'pre1Type', 0x31);
INSERT INTO `preferences` VALUES (14, 'showTopOrators', 0x31);
INSERT INTO `preferences` VALUES (14, 'topOratorCount', 0x3130);
INSERT INTO `preferences` VALUES (14, 'teamsListByScore', 0x30);
INSERT INTO `preferences` VALUES (14, 'hideOratorsLastRound', 0x31);
INSERT INTO `preferences` VALUES (14, 'noNewRegistration', 0x30);
INSERT INTO `preferences` VALUES (14, 'maxPrelimRounds', 0x35);
INSERT INTO `preferences` VALUES (14, 'maxFinalRounds', 0x36);
INSERT INTO `preferences` VALUES (14, 'noDoubleJeapordy', 0x31);
INSERT INTO `preferences` VALUES (14, 'generateAllPrelims', 0x31);
INSERT INTO `preferences` VALUES (14, 'keepTeamsInSameBldg', 0x31);
INSERT INTO `preferences` VALUES (14, 'feeAmount', 0x3735);
INSERT INTO `preferences` VALUES (14, 'tournamentOver', 0x3230303630313231313830303030);
INSERT INTO `preferences` VALUES (14, 'registrationCutoff', 0x3230303630313137303030303030);
INSERT INTO `preferences` VALUES (14, 'lateFeeAmount', 0x313030);
INSERT INTO `preferences` VALUES (14, 'lateFeeAfter', 0x3230303531323233);
INSERT INTO `texts` VALUES (14, 2, 'The tournament is concluded. Thank you to all of the judges, schools, participants, coaches and staff for making the tournament a success.');
INSERT INTO `texts` VALUES (14, 53, '3,0,0;2,0,1;2,1,0;1,0,2;1,1,1;1,2,0;0,0,3;0,1,2;0,2,1;0,3,0;2,0,0;1,0,1;0,0,2;0,1,1;0,2,0;1,0,0;0,0,1;0,1,0;0,0,0');
INSERT INTO `texts` VALUES (14, 55, '5,0,0;4,0,1;4,1,0;3,0,2;3,1,1;3,2,0;2,0,3;2,1,2;2,2,1;2,3,0;1,0,4;1,1,3;1,2,2;1,3,1;1,4,0;0,0,5;0,1,4;0,2,3;0,3,2;0,4,1;0,5,0;0,0,0;');
INSERT INTO `texts` VALUES (14, 54, '4,0,0;3,0,1;3,1,0;2,0,2;2,1,1;2,2,0;1,0,3;1,1,2;1,2,1;1,3,0;0,0,4;0,1,3;0,2,2;0,3,1;0,4,0;0,0,0;');
INSERT INTO `texts` VALUES (14, 52, '2,0,0;1,0,1;1,1,0;0,0,2;0,1,1;0,2,0;0,0,0;');
INSERT INTO `texts` VALUES (14, 51, '1,0,0;0,0,1;0,1,0;0,0,0;');
INSERT INTO `texts` VALUES (14, 1, 'Online registration for the 2006 National tournament will be available December 5, 2005, after all of the Regional Tournaments are concluded. Once the number of teams that automatically advance to the National Tournament are known, registration will open for the remaining slots.');
INSERT INTO `texts` VALUES (14, 3, 'No refunds will be given after January 27, 2006. Contact Jim Perry for information regarding the refund procedure.');
INSERT INTO `texts` VALUES (14, 100, '');
INSERT INTO `texts` VALUES (14, 101, '');

INSERT INTO `authentication` VALUES (15, AES_ENCRYPT("uppermidwest","32CharactersOfRandomFun"), AES_ENCRYPT("AMCA","32CharactersOfRandomFun"), 2, 0);
INSERT INTO `tournaments` VALUES (15, 'ACMA Tournament', '', '', '', '', '', '', '', '', '', '', '0', '', '');
INSERT INTO `preferences` VALUES (15, 'newTeamNotify', 0x79dd9188c47937118222b0eabfe4267d);
INSERT INTO `preferences` VALUES (15, 'prelimRounds', 0x33);
INSERT INTO `preferences` VALUES (15, 'registrationOn', 0x30);
INSERT INTO `preferences` VALUES (15, 'campusMap', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f);
INSERT INTO `preferences` VALUES (15, 'campusMapFile', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f63616d7075736d61702e706466);
INSERT INTO `preferences` VALUES (15, 'administrator', 0x484dc36308eb8317d6d6babbe681b9c6b7ae29d9755962bb254defcb980e09f1);
INSERT INTO `preferences` VALUES (15, 'statusShowScores', 0x30);
INSERT INTO `preferences` VALUES (15, 'statusRefresh', 0x313230);
INSERT INTO `preferences` VALUES (15, 'registrationTeams', 0x31);
INSERT INTO `preferences` VALUES (15, 'registrationPayment', 0x31);
INSERT INTO `preferences` VALUES (15, 'tournamentDates', 0x4a616e75617279203230202d203231);
INSERT INTO `preferences` VALUES (15, 'tournamentLocation', 0x55542041726c696e67746f6e);
INSERT INTO `preferences` VALUES (15, 'refundPolicy', 0x726566756e642e747874);
INSERT INTO `preferences` VALUES (15, 'currentRound', 0x2d33);
INSERT INTO `preferences` VALUES (15, 'finalRounds', 0x35);
INSERT INTO `preferences` VALUES (15, 'cryptoStr', '');
INSERT INTO `preferences` VALUES (15, 'useVerify', 0x31);
INSERT INTO `preferences` VALUES (15, 'pre5Type', 0x30);
INSERT INTO `preferences` VALUES (15, 'pre4Type', 0x30);
INSERT INTO `preferences` VALUES (15, 'pre3Type', 0x33);
INSERT INTO `preferences` VALUES (15, 'pre2Type', 0x32);
INSERT INTO `preferences` VALUES (15, 'pre1Type', 0x31);
INSERT INTO `preferences` VALUES (15, 'showTopOrators', 0x31);
INSERT INTO `preferences` VALUES (15, 'topOratorCount', 0x3130);
INSERT INTO `preferences` VALUES (15, 'teamsListByScore', 0x30);
INSERT INTO `preferences` VALUES (15, 'hideOratorsLastRound', 0x31);
INSERT INTO `preferences` VALUES (15, 'noNewRegistration', 0x30);
INSERT INTO `preferences` VALUES (15, 'maxPrelimRounds', 0x35);
INSERT INTO `preferences` VALUES (15, 'maxFinalRounds', 0x36);
INSERT INTO `preferences` VALUES (15, 'noDoubleJeapordy', 0x31);
INSERT INTO `preferences` VALUES (15, 'generateAllPrelims', 0x31);
INSERT INTO `preferences` VALUES (15, 'keepTeamsInSameBldg', 0x31);
INSERT INTO `preferences` VALUES (15, 'feeAmount', 0x3735);
INSERT INTO `preferences` VALUES (15, 'tournamentOver', 0x3230303630313231313830303030);
INSERT INTO `preferences` VALUES (15, 'registrationCutoff', 0x3230303630313137303030303030);
INSERT INTO `preferences` VALUES (15, 'lateFeeAmount', 0x313030);
INSERT INTO `preferences` VALUES (15, 'lateFeeAfter', 0x3230303531323233);
INSERT INTO `texts` VALUES (15, 2, 'The tournament is concluded. Thank you to all of the judges, schools, participants, coaches and staff for making the tournament a success.');
INSERT INTO `texts` VALUES (15, 53, '3,0,0;2,0,1;2,1,0;1,0,2;1,1,1;1,2,0;0,0,3;0,1,2;0,2,1;0,3,0;2,0,0;1,0,1;0,0,2;0,1,1;0,2,0;1,0,0;0,0,1;0,1,0;0,0,0');
INSERT INTO `texts` VALUES (15, 55, '5,0,0;4,0,1;4,1,0;3,0,2;3,1,1;3,2,0;2,0,3;2,1,2;2,2,1;2,3,0;1,0,4;1,1,3;1,2,2;1,3,1;1,4,0;0,0,5;0,1,4;0,2,3;0,3,2;0,4,1;0,5,0;0,0,0;');
INSERT INTO `texts` VALUES (15, 54, '4,0,0;3,0,1;3,1,0;2,0,2;2,1,1;2,2,0;1,0,3;1,1,2;1,2,1;1,3,0;0,0,4;0,1,3;0,2,2;0,3,1;0,4,0;0,0,0;');
INSERT INTO `texts` VALUES (15, 52, '2,0,0;1,0,1;1,1,0;0,0,2;0,1,1;0,2,0;0,0,0;');
INSERT INTO `texts` VALUES (15, 51, '1,0,0;0,0,1;0,1,0;0,0,0;');
INSERT INTO `texts` VALUES (15, 1, 'Online registration for the 2006 National tournament will be available December 5, 2005, after all of the Regional Tournaments are concluded. Once the number of teams that automatically advance to the National Tournament are known, registration will open for the remaining slots.');
INSERT INTO `texts` VALUES (15, 3, 'No refunds will be given after January 27, 2006. Contact Jim Perry for information regarding the refund procedure.');
INSERT INTO `texts` VALUES (15, 100, '');
INSERT INTO `texts` VALUES (15, 101, '');

INSERT INTO `authentication` VALUES (16, AES_ENCRYPT("western","32CharactersOfRandomFun"), AES_ENCRYPT("AMCA","32CharactersOfRandomFun"), 2, 0);
INSERT INTO `tournaments` VALUES (16, 'ACMA Tournament', '', '', '', '', '', '', '', '', '', '', '0', '', '');
INSERT INTO `preferences` VALUES (16, 'newTeamNotify', 0x79dd9188c47937118222b0eabfe4267d);
INSERT INTO `preferences` VALUES (16, 'prelimRounds', 0x33);
INSERT INTO `preferences` VALUES (16, 'registrationOn', 0x30);
INSERT INTO `preferences` VALUES (16, 'campusMap', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f);
INSERT INTO `preferences` VALUES (16, 'campusMapFile', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f63616d7075736d61702e706466);
INSERT INTO `preferences` VALUES (16, 'administrator', 0x484dc36308eb8317d6d6babbe681b9c6b7ae29d9755962bb254defcb980e09f1);
INSERT INTO `preferences` VALUES (16, 'statusShowScores', 0x30);
INSERT INTO `preferences` VALUES (16, 'statusRefresh', 0x313230);
INSERT INTO `preferences` VALUES (16, 'registrationTeams', 0x31);
INSERT INTO `preferences` VALUES (16, 'registrationPayment', 0x31);
INSERT INTO `preferences` VALUES (16, 'tournamentDates', 0x4a616e75617279203230202d203231);
INSERT INTO `preferences` VALUES (16, 'tournamentLocation', 0x55542041726c696e67746f6e);
INSERT INTO `preferences` VALUES (16, 'refundPolicy', 0x726566756e642e747874);
INSERT INTO `preferences` VALUES (16, 'currentRound', 0x2d33);
INSERT INTO `preferences` VALUES (16, 'finalRounds', 0x35);
INSERT INTO `preferences` VALUES (16, 'cryptoStr', '');
INSERT INTO `preferences` VALUES (16, 'useVerify', 0x31);
INSERT INTO `preferences` VALUES (16, 'pre5Type', 0x30);
INSERT INTO `preferences` VALUES (16, 'pre4Type', 0x30);
INSERT INTO `preferences` VALUES (16, 'pre3Type', 0x33);
INSERT INTO `preferences` VALUES (16, 'pre2Type', 0x32);
INSERT INTO `preferences` VALUES (16, 'pre1Type', 0x31);
INSERT INTO `preferences` VALUES (16, 'showTopOrators', 0x31);
INSERT INTO `preferences` VALUES (16, 'topOratorCount', 0x3130);
INSERT INTO `preferences` VALUES (16, 'teamsListByScore', 0x30);
INSERT INTO `preferences` VALUES (16, 'hideOratorsLastRound', 0x31);
INSERT INTO `preferences` VALUES (16, 'noNewRegistration', 0x30);
INSERT INTO `preferences` VALUES (16, 'maxPrelimRounds', 0x35);
INSERT INTO `preferences` VALUES (16, 'maxFinalRounds', 0x36);
INSERT INTO `preferences` VALUES (16, 'noDoubleJeapordy', 0x31);
INSERT INTO `preferences` VALUES (16, 'generateAllPrelims', 0x31);
INSERT INTO `preferences` VALUES (16, 'keepTeamsInSameBldg', 0x31);
INSERT INTO `preferences` VALUES (16, 'feeAmount', 0x3735);
INSERT INTO `preferences` VALUES (16, 'tournamentOver', 0x3230303630313231313830303030);
INSERT INTO `preferences` VALUES (16, 'registrationCutoff', 0x3230303630313137303030303030);
INSERT INTO `preferences` VALUES (16, 'lateFeeAmount', 0x313030);
INSERT INTO `preferences` VALUES (16, 'lateFeeAfter', 0x3230303531323233);
INSERT INTO `texts` VALUES (16, 2, 'The tournament is concluded. Thank you to all of the judges, schools, participants, coaches and staff for making the tournament a success.');
INSERT INTO `texts` VALUES (16, 53, '3,0,0;2,0,1;2,1,0;1,0,2;1,1,1;1,2,0;0,0,3;0,1,2;0,2,1;0,3,0;2,0,0;1,0,1;0,0,2;0,1,1;0,2,0;1,0,0;0,0,1;0,1,0;0,0,0');
INSERT INTO `texts` VALUES (16, 55, '5,0,0;4,0,1;4,1,0;3,0,2;3,1,1;3,2,0;2,0,3;2,1,2;2,2,1;2,3,0;1,0,4;1,1,3;1,2,2;1,3,1;1,4,0;0,0,5;0,1,4;0,2,3;0,3,2;0,4,1;0,5,0;0,0,0;');
INSERT INTO `texts` VALUES (16, 54, '4,0,0;3,0,1;3,1,0;2,0,2;2,1,1;2,2,0;1,0,3;1,1,2;1,2,1;1,3,0;0,0,4;0,1,3;0,2,2;0,3,1;0,4,0;0,0,0;');
INSERT INTO `texts` VALUES (16, 52, '2,0,0;1,0,1;1,1,0;0,0,2;0,1,1;0,2,0;0,0,0;');
INSERT INTO `texts` VALUES (16, 51, '1,0,0;0,0,1;0,1,0;0,0,0;');
INSERT INTO `texts` VALUES (16, 1, 'Online registration for the 2006 National tournament will be available December 5, 2005, after all of the Regional Tournaments are concluded. Once the number of teams that automatically advance to the National Tournament are known, registration will open for the remaining slots.');
INSERT INTO `texts` VALUES (16, 3, 'No refunds will be given after January 27, 2006. Contact Jim Perry for information regarding the refund procedure.');
INSERT INTO `texts` VALUES (16, 100, '');
INSERT INTO `texts` VALUES (16, 101, '');

INSERT INTO `authentication` VALUES (17, AES_ENCRYPT("national","32CharactersOfRandomFun"), AES_ENCRYPT("AMCA","32CharactersOfRandomFun"), 2, 0);
INSERT INTO `tournaments` VALUES (17, 'ACMA Tournament', '', '', '', '', '', '', '', '', '', '', '0', '', '');
INSERT INTO `preferences` VALUES (17, 'newTeamNotify', 0x79dd9188c47937118222b0eabfe4267d);
INSERT INTO `preferences` VALUES (17, 'prelimRounds', 0x33);
INSERT INTO `preferences` VALUES (17, 'registrationOn', 0x30);
INSERT INTO `preferences` VALUES (17, 'campusMap', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f);
INSERT INTO `preferences` VALUES (17, 'campusMapFile', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f63616d7075736d61702e706466);
INSERT INTO `preferences` VALUES (17, 'administrator', 0x484dc36308eb8317d6d6babbe681b9c6b7ae29d9755962bb254defcb980e09f1);
INSERT INTO `preferences` VALUES (17, 'statusShowScores', 0x30);
INSERT INTO `preferences` VALUES (17, 'statusRefresh', 0x313230);
INSERT INTO `preferences` VALUES (17, 'registrationTeams', 0x31);
INSERT INTO `preferences` VALUES (17, 'registrationPayment', 0x31);
INSERT INTO `preferences` VALUES (17, 'tournamentDates', 0x4a616e75617279203230202d203231);
INSERT INTO `preferences` VALUES (17, 'tournamentLocation', 0x55542041726c696e67746f6e);
INSERT INTO `preferences` VALUES (17, 'refundPolicy', 0x726566756e642e747874);
INSERT INTO `preferences` VALUES (17, 'currentRound', 0x2d33);
INSERT INTO `preferences` VALUES (17, 'finalRounds', 0x35);
INSERT INTO `preferences` VALUES (17, 'cryptoStr', '');
INSERT INTO `preferences` VALUES (17, 'useVerify', 0x31);
INSERT INTO `preferences` VALUES (17, 'pre5Type', 0x30);
INSERT INTO `preferences` VALUES (17, 'pre4Type', 0x30);
INSERT INTO `preferences` VALUES (17, 'pre3Type', 0x33);
INSERT INTO `preferences` VALUES (17, 'pre2Type', 0x32);
INSERT INTO `preferences` VALUES (17, 'pre1Type', 0x31);
INSERT INTO `preferences` VALUES (17, 'showTopOrators', 0x31);
INSERT INTO `preferences` VALUES (17, 'topOratorCount', 0x3130);
INSERT INTO `preferences` VALUES (17, 'teamsListByScore', 0x30);
INSERT INTO `preferences` VALUES (17, 'hideOratorsLastRound', 0x31);
INSERT INTO `preferences` VALUES (17, 'noNewRegistration', 0x30);
INSERT INTO `preferences` VALUES (17, 'maxPrelimRounds', 0x35);
INSERT INTO `preferences` VALUES (17, 'maxFinalRounds', 0x36);
INSERT INTO `preferences` VALUES (17, 'noDoubleJeapordy', 0x31);
INSERT INTO `preferences` VALUES (17, 'generateAllPrelims', 0x31);
INSERT INTO `preferences` VALUES (17, 'keepTeamsInSameBldg', 0x31);
INSERT INTO `preferences` VALUES (17, 'feeAmount', 0x3735);
INSERT INTO `preferences` VALUES (17, 'tournamentOver', 0x3230303630313231313830303030);
INSERT INTO `preferences` VALUES (17, 'registrationCutoff', 0x3230303630313137303030303030);
INSERT INTO `preferences` VALUES (17, 'lateFeeAmount', 0x313030);
INSERT INTO `preferences` VALUES (17, 'lateFeeAfter', 0x3230303531323233);
INSERT INTO `texts` VALUES (17, 2, 'The tournament is concluded. Thank you to all of the judges, schools, participants, coaches and staff for making the tournament a success.');
INSERT INTO `texts` VALUES (17, 53, '3,0,0;2,0,1;2,1,0;1,0,2;1,1,1;1,2,0;0,0,3;0,1,2;0,2,1;0,3,0;2,0,0;1,0,1;0,0,2;0,1,1;0,2,0;1,0,0;0,0,1;0,1,0;0,0,0');
INSERT INTO `texts` VALUES (17, 55, '5,0,0;4,0,1;4,1,0;3,0,2;3,1,1;3,2,0;2,0,3;2,1,2;2,2,1;2,3,0;1,0,4;1,1,3;1,2,2;1,3,1;1,4,0;0,0,5;0,1,4;0,2,3;0,3,2;0,4,1;0,5,0;0,0,0;');
INSERT INTO `texts` VALUES (17, 54, '4,0,0;3,0,1;3,1,0;2,0,2;2,1,1;2,2,0;1,0,3;1,1,2;1,2,1;1,3,0;0,0,4;0,1,3;0,2,2;0,3,1;0,4,0;0,0,0;');
INSERT INTO `texts` VALUES (17, 52, '2,0,0;1,0,1;1,1,0;0,0,2;0,1,1;0,2,0;0,0,0;');
INSERT INTO `texts` VALUES (17, 51, '1,0,0;0,0,1;0,1,0;0,0,0;');
INSERT INTO `texts` VALUES (17, 1, 'Online registration for the 2006 National tournament will be available December 5, 2005, after all of the Regional Tournaments are concluded. Once the number of teams that automatically advance to the National Tournament are known, registration will open for the remaining slots.');
INSERT INTO `texts` VALUES (17, 3, 'No refunds will be given after January 27, 2006. Contact Jim Perry for information regarding the refund procedure.');
INSERT INTO `texts` VALUES (17, 100, '');
INSERT INTO `texts` VALUES (17, 101, '');

INSERT INTO `authentication` VALUES (18, AES_ENCRYPT("invitational","32CharactersOfRandomFun"), AES_ENCRYPT("AMCA","32CharactersOfRandomFun"), 2, 0);
INSERT INTO `tournaments` VALUES (18, 'ACMA Tournament', '', '', '', '', '', '', '', '', '', '', '0', '', '');
INSERT INTO `preferences` VALUES (18, 'newTeamNotify', 0x79dd9188c47937118222b0eabfe4267d);
INSERT INTO `preferences` VALUES (18, 'prelimRounds', 0x33);
INSERT INTO `preferences` VALUES (18, 'registrationOn', 0x30);
INSERT INTO `preferences` VALUES (18, 'campusMap', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f);
INSERT INTO `preferences` VALUES (18, 'campusMapFile', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f63616d7075736d61702e706466);
INSERT INTO `preferences` VALUES (18, 'administrator', 0x484dc36308eb8317d6d6babbe681b9c6b7ae29d9755962bb254defcb980e09f1);
INSERT INTO `preferences` VALUES (18, 'statusShowScores', 0x30);
INSERT INTO `preferences` VALUES (18, 'statusRefresh', 0x313230);
INSERT INTO `preferences` VALUES (18, 'registrationTeams', 0x31);
INSERT INTO `preferences` VALUES (18, 'registrationPayment', 0x31);
INSERT INTO `preferences` VALUES (18, 'tournamentDates', 0x4a616e75617279203230202d203231);
INSERT INTO `preferences` VALUES (18, 'tournamentLocation', 0x55542041726c696e67746f6e);
INSERT INTO `preferences` VALUES (18, 'refundPolicy', 0x726566756e642e747874);
INSERT INTO `preferences` VALUES (18, 'currentRound', 0x2d33);
INSERT INTO `preferences` VALUES (18, 'finalRounds', 0x35);
INSERT INTO `preferences` VALUES (18, 'cryptoStr', '');
INSERT INTO `preferences` VALUES (18, 'useVerify', 0x31);
INSERT INTO `preferences` VALUES (18, 'pre5Type', 0x30);
INSERT INTO `preferences` VALUES (18, 'pre4Type', 0x30);
INSERT INTO `preferences` VALUES (18, 'pre3Type', 0x33);
INSERT INTO `preferences` VALUES (18, 'pre2Type', 0x32);
INSERT INTO `preferences` VALUES (18, 'pre1Type', 0x31);
INSERT INTO `preferences` VALUES (18, 'showTopOrators', 0x31);
INSERT INTO `preferences` VALUES (18, 'topOratorCount', 0x3130);
INSERT INTO `preferences` VALUES (18, 'teamsListByScore', 0x30);
INSERT INTO `preferences` VALUES (18, 'hideOratorsLastRound', 0x31);
INSERT INTO `preferences` VALUES (18, 'noNewRegistration', 0x30);
INSERT INTO `preferences` VALUES (18, 'maxPrelimRounds', 0x35);
INSERT INTO `preferences` VALUES (18, 'maxFinalRounds', 0x36);
INSERT INTO `preferences` VALUES (18, 'noDoubleJeapordy', 0x31);
INSERT INTO `preferences` VALUES (18, 'generateAllPrelims', 0x31);
INSERT INTO `preferences` VALUES (18, 'keepTeamsInSameBldg', 0x31);
INSERT INTO `preferences` VALUES (18, 'feeAmount', 0x3735);
INSERT INTO `preferences` VALUES (18, 'tournamentOver', 0x3230303630313231313830303030);
INSERT INTO `preferences` VALUES (18, 'registrationCutoff', 0x3230303630313137303030303030);
INSERT INTO `preferences` VALUES (18, 'lateFeeAmount', 0x313030);
INSERT INTO `preferences` VALUES (18, 'lateFeeAfter', 0x3230303531323233);
INSERT INTO `texts` VALUES (18, 2, 'The tournament is concluded. Thank you to all of the judges, schools, participants, coaches and staff for making the tournament a success.');
INSERT INTO `texts` VALUES (18, 53, '3,0,0;2,0,1;2,1,0;1,0,2;1,1,1;1,2,0;0,0,3;0,1,2;0,2,1;0,3,0;2,0,0;1,0,1;0,0,2;0,1,1;0,2,0;1,0,0;0,0,1;0,1,0;0,0,0');
INSERT INTO `texts` VALUES (18, 55, '5,0,0;4,0,1;4,1,0;3,0,2;3,1,1;3,2,0;2,0,3;2,1,2;2,2,1;2,3,0;1,0,4;1,1,3;1,2,2;1,3,1;1,4,0;0,0,5;0,1,4;0,2,3;0,3,2;0,4,1;0,5,0;0,0,0;');
INSERT INTO `texts` VALUES (18, 54, '4,0,0;3,0,1;3,1,0;2,0,2;2,1,1;2,2,0;1,0,3;1,1,2;1,2,1;1,3,0;0,0,4;0,1,3;0,2,2;0,3,1;0,4,0;0,0,0;');
INSERT INTO `texts` VALUES (18, 52, '2,0,0;1,0,1;1,1,0;0,0,2;0,1,1;0,2,0;0,0,0;');
INSERT INTO `texts` VALUES (18, 51, '1,0,0;0,0,1;0,1,0;0,0,0;');
INSERT INTO `texts` VALUES (18, 1, 'Online registration for the 2006 National tournament will be available December 5, 2005, after all of the Regional Tournaments are concluded. Once the number of teams that automatically advance to the National Tournament are known, registration will open for the remaining slots.');
INSERT INTO `texts` VALUES (18, 3, 'No refunds will be given after January 27, 2006. Contact Jim Perry for information regarding the refund procedure.');
INSERT INTO `texts` VALUES (18, 100, '');
INSERT INTO `texts` VALUES (18, 101, '');

INSERT INTO `authentication` VALUES (19, AES_ENCRYPT("tumca","32CharactersOfRandomFun"), AES_ENCRYPT("AMCA","32CharactersOfRandomFun"), 2, 0);
INSERT INTO `tournaments` VALUES (19, 'ACMA Tournament', '', '', '', '', '', '', '', '', '', '', '0', '', '');
INSERT INTO `preferences` VALUES (19, 'newTeamNotify', 0x79dd9188c47937118222b0eabfe4267d);
INSERT INTO `preferences` VALUES (19, 'prelimRounds', 0x33);
INSERT INTO `preferences` VALUES (19, 'registrationOn', 0x30);
INSERT INTO `preferences` VALUES (19, 'campusMap', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f);
INSERT INTO `preferences` VALUES (19, 'campusMapFile', 0x687474703a2f2f7777772e7574612e6564752f6d6170732f63616d7075736d61702e706466);
INSERT INTO `preferences` VALUES (19, 'administrator', 0x484dc36308eb8317d6d6babbe681b9c6b7ae29d9755962bb254defcb980e09f1);
INSERT INTO `preferences` VALUES (19, 'statusShowScores', 0x30);
INSERT INTO `preferences` VALUES (19, 'statusRefresh', 0x313230);
INSERT INTO `preferences` VALUES (19, 'registrationTeams', 0x31);
INSERT INTO `preferences` VALUES (19, 'registrationPayment', 0x31);
INSERT INTO `preferences` VALUES (19, 'tournamentDates', 0x4a616e75617279203230202d203231);
INSERT INTO `preferences` VALUES (19, 'tournamentLocation', 0x55542041726c696e67746f6e);
INSERT INTO `preferences` VALUES (19, 'refundPolicy', 0x726566756e642e747874);
INSERT INTO `preferences` VALUES (19, 'currentRound', 0x2d33);
INSERT INTO `preferences` VALUES (19, 'finalRounds', 0x35);
INSERT INTO `preferences` VALUES (19, 'cryptoStr', '');
INSERT INTO `preferences` VALUES (19, 'useVerify', 0x31);
INSERT INTO `preferences` VALUES (19, 'pre5Type', 0x30);
INSERT INTO `preferences` VALUES (19, 'pre4Type', 0x30);
INSERT INTO `preferences` VALUES (19, 'pre3Type', 0x33);
INSERT INTO `preferences` VALUES (19, 'pre2Type', 0x32);
INSERT INTO `preferences` VALUES (19, 'pre1Type', 0x31);
INSERT INTO `preferences` VALUES (19, 'showTopOrators', 0x31);
INSERT INTO `preferences` VALUES (19, 'topOratorCount', 0x3130);
INSERT INTO `preferences` VALUES (19, 'teamsListByScore', 0x30);
INSERT INTO `preferences` VALUES (19, 'hideOratorsLastRound', 0x31);
INSERT INTO `preferences` VALUES (19, 'noNewRegistration', 0x30);
INSERT INTO `preferences` VALUES (19, 'maxPrelimRounds', 0x35);
INSERT INTO `preferences` VALUES (19, 'maxFinalRounds', 0x36);
INSERT INTO `preferences` VALUES (19, 'noDoubleJeapordy', 0x31);
INSERT INTO `preferences` VALUES (19, 'generateAllPrelims', 0x31);
INSERT INTO `preferences` VALUES (19, 'keepTeamsInSameBldg', 0x31);
INSERT INTO `preferences` VALUES (19, 'feeAmount', 0x3735);
INSERT INTO `preferences` VALUES (19, 'tournamentOver', 0x3230303630313231313830303030);
INSERT INTO `preferences` VALUES (19, 'registrationCutoff', 0x3230303630313137303030303030);
INSERT INTO `preferences` VALUES (19, 'lateFeeAmount', 0x313030);
INSERT INTO `preferences` VALUES (19, 'lateFeeAfter', 0x3230303531323233);
INSERT INTO `texts` VALUES (19, 2, 'The tournament is concluded. Thank you to all of the judges, schools, participants, coaches and staff for making the tournament a success.');
INSERT INTO `texts` VALUES (19, 53, '3,0,0;2,0,1;2,1,0;1,0,2;1,1,1;1,2,0;0,0,3;0,1,2;0,2,1;0,3,0;2,0,0;1,0,1;0,0,2;0,1,1;0,2,0;1,0,0;0,0,1;0,1,0;0,0,0');
INSERT INTO `texts` VALUES (19, 55, '5,0,0;4,0,1;4,1,0;3,0,2;3,1,1;3,2,0;2,0,3;2,1,2;2,2,1;2,3,0;1,0,4;1,1,3;1,2,2;1,3,1;1,4,0;0,0,5;0,1,4;0,2,3;0,3,2;0,4,1;0,5,0;0,0,0;');
INSERT INTO `texts` VALUES (19, 54, '4,0,0;3,0,1;3,1,0;2,0,2;2,1,1;2,2,0;1,0,3;1,1,2;1,2,1;1,3,0;0,0,4;0,1,3;0,2,2;0,3,1;0,4,0;0,0,0;');
INSERT INTO `texts` VALUES (19, 52, '2,0,0;1,0,1;1,1,0;0,0,2;0,1,1;0,2,0;0,0,0;');
INSERT INTO `texts` VALUES (19, 51, '1,0,0;0,0,1;0,1,0;0,0,0;');
INSERT INTO `texts` VALUES (19, 1, 'Online registration for the 2006 National tournament will be available December 5, 2005, after all of the Regional Tournaments are concluded. Once the number of teams that automatically advance to the National Tournament are known, registration will open for the remaining slots.');
INSERT INTO `texts` VALUES (19, 3, 'No refunds will be given after January 27, 2006. Contact Jim Perry for information regarding the refund procedure.');
INSERT INTO `texts` VALUES (19, 100, '');
INSERT INTO `texts` VALUES (19, 101, '');
