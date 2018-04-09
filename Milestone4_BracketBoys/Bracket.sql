/* Building Tables */

DROP TABLE Player; 
CREATE TABLE  Player
(
	Name 		varchar(20),
	PlayerID 	int unique PRIMARY KEY,
	TourneyCode 	varchar(20), 
	Wins 		int, 
	Losses 		int, 
	MatchNo 	int 
);

DROP TABLE Tournament; 
CREATE TABLE Tournament
(
	TournamentName  varchar(30),
	Password	varchar(20),
	Code		varchar(20) unique PRIMARY KEY,
	StartDate 	date,
	NumPlayers	int,
	RoundNo	 	int,
	MatchNo		int,
	Winner		varchar(20),
	Owner		varchar(20)		
);

DROP TABLE Admin;
CREATE TABLE Admin
(
	Username 	varchar(20) unique PRIMARY KEY,
	Password	varchar(20),
	Email 		varchar(40)
);

/* Sample Data */

INSERT INTO Player VALUES ('Player 1',1,'Tourney1',0,0,1);
INSERT INTO Player VALUES ('Player 2',2,'Tourney1',0,0,2);
INSERT INTO Player VALUES ('Player 3',3,'Tourney1',0,0,1);
INSERT INTO Player VALUES ('Player 4',4,'Tourney1',0,0,4);
INSERT INTO Player VALUES ('Player 5',5,'Tourney1',0,0,3);
INSERT INTO Player VALUES ('Player 6',6,'Tourney1',0,0,4);
INSERT INTO Player VALUES ('Player 7',7,'Tourney1',0,0,3);
INSERT INTO Player VALUES ('Player 8',8,'Tourney1',0,0,2);
INSERT INTO Player VALUES ('Player 9',9,'Tourney2',0,0,1);
INSERT INTO Player VALUES ('Player 10',10,'Tourney2',0,0,4);
INSERT INTO Player VALUES ('Player 11',11,'Tourney2',0,0,1);
INSERT INTO Player VALUES ('Player 12',12,'Tourney2',0,0,2);
INSERT INTO Player VALUES ('Player 13',13,'Tourney2',0,0,2);
INSERT INTO Player VALUES ('Player 14',14,'Tourney2',0,0,3);
INSERT INTO Player VALUES ('Player 15',15,'Tourney2',0,0,3);
INSERT INTO Player VALUES ('Player 16',16,'Tourney2',0,0,4);

INSERT INTO Tournament VALUES ('Test Tournament 1','passw','Tourney1',curdate(),8,1,1,NULL,'TourneyAdmin1');
INSERT INTO Tournament VALUES ('Test Tournament 2','passw','Tourney2',curdate(),8,1,1,NULL,'TourneyAdmin2');

INSERT INTO Admin VALUES ('TourneyAdmin1','password123','name@gmail.com');
INSERT INTO Admin VALUES ('TourneyAdmin2','password123','diffname@gmail.com');

/* Display Tables */

SELECT * FROM Player;
SELECT * FROM Tournament;
SELECT * FROM Admin;

/* Display Players In Table with Corresponding Match Number */

SELECT Name AS 'Participants of Test Tournament 1', Player.MatchNo
	FROM Player
	LEFT JOIN Tournament
		ON Player.TourneyCode = Tournament.Code
	RIGHT JOIN Admin
		ON Admin.Username = Tournament.Owner
	WHERE Admin.Username = 'TourneyAdmin1' 
		AND TournamentName = 'Test Tournament 1'
	ORDER BY Player.MatchNo ASC;

/* Update Results from First Round of Matches */

UPDATE Player
	SET Wins = Wins + 1, MatchNo = CEIL(MatchNo/2) + 4
	WHERE PlayerID = 1
		OR PlayerID = 2
		OR PlayerID = 6
		OR PlayerID = 7;

UPDATE Player
	SET Losses = Losses + 1
	WHERE PlayerID = 3
		OR PlayerID = 4
		OR PlayerID = 5
		OR PlayerID = 8;

SELECT Name AS 'Participants of Test Tournament 1', Player.MatchNo, Wins, Losses
	FROM Player
	LEFT JOIN Tournament
		ON Player.TourneyCode = Tournament.Code
	RIGHT JOIN Admin
		ON Admin.Username = Tournament.Owner
	WHERE Admin.Username = 'TourneyAdmin1' 
		AND Code = 'Tourney1'
	ORDER BY Player.MatchNo DESC;


/* Update Results from Second Round of Matches */

UPDATE Player
	SET Wins = Wins + 1, MatchNo = CEIL(MatchNo/2) + 4
	WHERE PlayerID = 1
		OR PlayerID = 7;

UPDATE Player
	SET Losses = Losses + 1
	WHERE PlayerID = 2
		OR PlayerID = 6;

SELECT Name AS 'Participants of Test Tournament 1', Player.MatchNo, Wins, Losses
	FROM Player
	LEFT JOIN Tournament
		ON Player.TourneyCode = Tournament.Code
	RIGHT JOIN Admin
		ON Admin.Username = Tournament.Owner
	WHERE Admin.Username = 'TourneyAdmin1' 
		AND Code = 'Tourney1'
	ORDER BY Player.MatchNo DESC;
	
/* Update Results from Final Round of Matches */

UPDATE Player
	SET Wins = Wins + 1
	WHERE PlayerID = 7;

UPDATE Player
	SET Losses = Losses + 1
	WHERE PlayerID = 1;

SELECT Name AS 'Participants of Test Tournament 1', Player.MatchNo, Wins, Losses
	FROM Player
	LEFT JOIN Tournament
		ON Player.TourneyCode = Tournament.Code
	RIGHT JOIN Admin
		ON Admin.Username = Tournament.Owner
	WHERE Admin.Username = 'TourneyAdmin1' 
		AND Code = 'Tourney1'
	ORDER BY Player.MatchNo DESC, Player.Wins DESC;

UPDATE Tournament
	INNER JOIN Player
		ON Player.TourneyCode = Tournament.Code
	SET Winner = (
		SELECT Name
			FROM Player
			WHERE TourneyCode = 'Tourney1'
			ORDER BY Wins DESC
			LIMIT 1
	)
	WHERE TourneyCode = 'Tourney1';

SELECT * FROM Tournament;
