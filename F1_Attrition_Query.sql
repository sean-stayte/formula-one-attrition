SELECT  ra.year, 
		ra.name, 
		re.time,
		re.laps,
		ret.retirements AS retirements,
		c.name
FROM races AS ra
LEFT JOIN (
			-- Select only records for race winners. 
			-- As the winner always completes the maximum laps, this can be used to determine the number of laps in the race. 
			-- The winner's time is taken as the race duration
			SELECT raceId, time, laps
			FROM results
			WHERE position = '1') AS re
ON ra.raceId = re.raceId
LEFT JOIN (
			-- Select records where drivers started a race but did not finish
			SELECT ra.year, 
				   ra.name,
				   ra.raceId,
				   COUNT(CASE WHEN stat.status NOT LIKE 'Finished' 
							       AND stat.status NOT LIKE '%Lap%' 
								   AND stat.status NOT LIKE 'Disqualified'
								   AND re.grid NOT LIKE '0' THEN 1
					      END) AS retirements
			FROM results AS re
			LEFT JOIN status AS stat
			ON re.statusId = stat.statusId
			LEFT JOIN races AS ra
			ON re.raceId = ra.raceId
			GROUP BY ra.year, ra.name, ra.raceId) AS ret
ON ra.raceId = ret.raceId
LEFT JOIN circuits AS c
ON ra.circuitId = c.circuitId
UNION ALL
-- Add in records for sprint races
-- The code follows the same logic as above
SELECT  ra.year, 
		REPLACE(ra.name, 'Grand Prix', 'Sprint') AS name,
		sp_re.time,
		sp_re.laps,
		ret.retirements AS retirements,
		c.name
FROM races AS ra
LEFT JOIN (
			SELECT raceId, time, laps
			FROM sprint_results
			WHERE position = '1') AS sp_re
ON ra.raceId = sp_re.raceId
LEFT JOIN (
			SELECT ra.year, 
				   ra.name,
				   ra.raceId,
				   COUNT(CASE WHEN stat.status NOT LIKE 'Finished' 
							       AND stat.status NOT LIKE '%Lap%' 
								   AND stat.status NOT LIKE 'Disqualified'
								   AND sp_re.grid NOT LIKE '0' THEN 1
					      END) AS retirements
			FROM sprint_results AS sp_re
			LEFT JOIN status AS stat
			ON sp_re.statusId = stat.statusId
			LEFT JOIN races AS ra
			ON sp_re.raceId = ra.raceId
			GROUP BY ra.year, ra.name, ra.raceId) AS ret
ON ra.raceId = ret.raceId
LEFT JOIN circuits AS c
ON ra.circuitId = c.circuitId
-- Choose only races that also featured a sprint
WHERE sprint_date NOT LIKE '\N'
ORDER BY year;
