USE NFL2018;

--Union tables
SELECT w.FirstName, w.Lastname, w.FanPoints
FROM Widereceivers w
WHERE w.TeamID = (SELECT Team.TeamID
FROM Team Where TeamAbbreviation = 'Chi')
UNION
SELECT te.FirstName, te.LastName, te.FanPoints
FROM Tightends te
WHERE te.TeamID = (SELECT Team.TeamID
FROM Team Where TeamAbbreviation = 'Chi')
UNION
SELECT q.FirstName, q.LastName, q.FanPoints
FROM Quarterbacks q
WHERE q.TeamID = (SELECT Team.TeamID
FROM Team Where TeamAbbreviation = 'Chi')
UNION
SELECT r.FirstName, r.LastName, r.FanPoints
FROM Runningbacks r
WHERE r.TeamID = (SELECT Team.TeamID
FROM Team Where TeamAbbreviation = 'Chi');

--Joining Tables
SELECT c.CoachFirstName, c.CoachLastName, t.TeamFirstName, t.Teamlastname, t.TeamAbbreviation
FROM Coach c JOIN Team t
ON c.TeamID = t.TeamID
WHERE c.TeamId = 10;

SELECT c.CoachFirstName, c.CoachLastName, t.TeamAbbreviation, t.TeamFirstName, t.Teamlastname
FROM Coach c JOIN Team t
ON c.TeamID = t.TeamID
WHERE t.TeamAbbreviation = 'Dal';

SELECT te.FirstName, te.LastName, te.FanPoints, t.TeamAbbreviation
FROM Tightends te
LEFT JOIN Team t
on te.TeamID = t.TeamID
WHERE te.GP > 14;

--Concatnate and Join
SELECT (c.CoachFirstName + ' ' + c.CoachLastName) as 'Coach Name', (t.TeamFirstName + ' ' + t.Teamlastname) AS 'Team Name', t.TeamAbbreviation
FROM Coach c JOIN Team t
ON c.TeamID = t.TeamID
WHERE c.Position = 'Head Coach';

-- Union and Join tables, Order By
(SELECT w.FirstName, w.Lastname, p.PositionAbbreviation, w.FanPoints
FROM Widereceivers w Join Position p
ON w.PositionID = p.PositionId
WHERE w.TeamID = (SELECT Team.TeamID
FROM Team Where TeamAbbreviation = 'Chi')
UNION
SELECT te.FirstName, te.LastName,  p.PositionAbbreviation, te.FanPoints
FROM Tightends te Join Position p
ON te.PositionID = p.PositionId
WHERE te.TeamID = (SELECT Team.TeamID
FROM Team Where TeamAbbreviation = 'Chi')
UNION
SELECT q.FirstName, q.LastName, p.PositionAbbreviation, q.FanPoints 
FROM Quarterbacks q Join Position p
ON q.PositionID = p.PositionId
WHERE q.TeamID = (SELECT Team.TeamID
FROM Team Where TeamAbbreviation = 'Chi')
UNION
SELECT r.FirstName, r.LastName, p.PositionAbbreviation, r.FanPoints
FROM Runningbacks r Join Position p
ON r.PositionID = p.PositionId
WHERE r.TeamID = (SELECT Team.TeamID
FROM Team Where TeamAbbreviation = 'Chi')
UNION
SELECT k.FirstName, k.LastName, p.PositionAbbreviation, k.FanPoints
FROM Kickers k Join Position p
ON k.PositionID = p.PositionId
WHERE k.TeamID = (SELECT Team.TeamID
FROM Team Where TeamAbbreviation = 'Chi')) 
Order by FanPoints DESC;

--Join 3 tables using a separate Identifying table, used Aliases 
(SELECT (def.TeamCity + ' ' + def.TeamName) as 'Team Name', c.ConferenceAbbreviation as Conference, d.DivisionName as Division, def.Sacks, def.[Int], def.FanPoints
FROM TeamDivisionConference tdc
JOIN Defense def
ON tdc.TeamId = def.TeamID
JOIN Division d
ON tdc.DivisionId = d.DivisionId
JOIN Conference c
ON tdc.ConferenceId = c.ConferenceId)
Order by FanPoints DESC;