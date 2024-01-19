# Attrition Rate in Formula 1 Races
## aka: My First Data Analysis Project

### Update 19th January 2024

This is a [test link](https://github.com/sean-stayte/formula-one-attrition/blob/main/F1_Attrition_Dashboard.pbix)

### 5th January 2024
**Question:** Which Formula 1 races had the highest rate of attrition? (And were obviously therefore the most interesting to watch)

**Rationale:** F1 recently introduced a short-format Sprint race, which is held alongside the main Grand Prix on the same weekend. The 2023 Qatar sprint was very entertaining and saw five cars retire in just 19 laps. While watching, I wondered if it seemed more exciting because the short number of laps (compared to 57 for the main race) concentrated the incidents and led a high attrition rate. How did the Qatar Sprint compare to other races? Did Grands Prix have lower attrition rates? Which races in history had the highest/lowest attrition rates? How would the numbers change if attrition was measured as retirements per kilometer, or retirements per minute?

**Data:** http://ergast.com/mrd/ (althought I used a different source that hadn't been fully updated for the 2023 season)

**The Story So Far:**
- Carried out EDA in SQL Server
- Wrote SQL query to identify number of cars that started each race, number of cars that finished, and therefore retirements and retirements per lap
- Visualised data in PowerBI

**Insights So Far:**
- Attrition rate has generally decreased over time
- Between 1950 and 1980, 7.6% of races had an attrition rate (RPL) of over 0.4 - compared to 0.4% of races between 1980 and 2023
- The 1975 German Grand Prix had the highest attrition rate of all time - 1.14 retirements per lap. During the 14-lap race, 16 cars retired!
- The length of a race (measured in number of laps) is negatively correlated with attrition rate. The shorter the race, the higher the attrition rate.
- 2.5% of races had 30 laps or fewer, but these races accounted for 88% of races with RPL > 0.4

**Issues:**
- Dataset doesn't include the second half of the 2023 season
- Dataset doesn't include sprint races (!) The SQL query used the field "raceId" to identify different races, but sprint races (as well as other session, such as qualifying) all share the same raceId. So it is not trivial to join sprint results data to main grand prix results data
- I haven't included races with zero retirements (1% of total races)

**Next steps:**
- Redo analysis using complete dataset (including second half of 2023)
- Find a way to include sprint race results
- Repeat analysis using time instead of laps as a measure of race length - the same method as for laps should work for this
- Repeat analysis using distance instead of laps as a measure of race length - this is non-trivial as circuits have been reconfigured over the years. For example, every race in Singapore is listed as using the Marina Bay circuit, but the length of this circuit has varied between seasons.
