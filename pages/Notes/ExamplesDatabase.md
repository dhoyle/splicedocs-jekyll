---
title: Splice Machine Documentation Examples Database
summary: Describes the simple database we use to provide examples throughout the documentation.
keywords: examples database, documentation examples, doc examples
toc: false
product: all
sidebar:  getstarted_sidebar
permalink: notes_examplesdb.html
folder: Notes
---
{% include splicevars.html %} <section>
<div class="TopicContent" data-swiftype-index="true" markdown="1">
# About Our Documentation Examples Database

This topic describes the database that we have created to provide code
examples throughout our documentation suite. We've pulled in basic
seasonal statistics for two Major League Baseball teams, though all
names have been changed. We're calling this our <span
class="AppCommand">DocsExamplesDb</span> database.

Our <span class="AppCommand">DocsExamplesDb</span> database features
these tables:

<table summary="Descriptions of the tables in the SpliceBBall examples database.">
    <col />
    <col />
    <thead>
        <tr>
            <th>Table</th>
            <th>Contains</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><strong>Players</strong>
            </td>
            <td>The player's name, ID, and other general information.</td>
        </tr>
        <tr>
            <td><strong>Salaries</strong>
            </td>
            <td>The salary for each player ID for each season.</td>
        </tr>
        <tr>
            <td><strong>Batting</strong>
            </td>
            <td>Batting statistics, per season, for each player ID.</td>
        </tr>
        <tr>
            <td><strong>Fielding</strong>
            </td>
            <td>Fielding statistics, per season, for each player ID.</td>
        </tr>
        <tr>
            <td><strong>Pitching</strong>
            </td>
            <td>Pitching statistics, per season, for each pitcher's player ID.</td>
        </tr>
    </tbody>
</table>
The tables were populated with data found on the Internet, primarily
from the [baseball-reference.com][1]{: target="_blank"} site.

The remainder of this topic includes this information:

* [Loading the Examples Database](#loading) walks you through importing the examples database into a new schema in your Splice Machine database.
* [Table Schemas](#tables) describes the tables.

## Loading the Examples Database {#loading}
To load the examples database, you need to follow these steps:

1. Click this link to download this small (~12KB) tarball: [https:/doc.splicemachine.com/examples/DocExamplesDb.gz]

2. Unpack the tarball. On MacOS, you can simply double-click the `.gz` file; on Linux, use the following command:
   ```
   tar -xvf DocExamplesDb.tar.gz
   ```
   {: .ShellCommand}

3. Navigate to the `DocExamplesDb` directory that was created when you unpacked the tarball.

4. Use your favorite text editor to edit the `CreateDocExamplesDb.sql` script file. Scroll to the bottom of the file, where you'll find 5 import statements. You need to update the csv filepath in each of these statements to absolute path of the examples DB directory on your machine.

   For example, one of the import statements looks like this:
   ```
   CALL SYSCS_UTIL.IMPORT_DATA('SPLICEBBALL', 'Players',
      null, './DocExamplesDb/Players.csv',
      null, null, null, null, null, 0, null, true, null);
   ```
   {: .Example}

   If you unpacked the tarball into your `Downloads` directory, you would change that to the following:
   {: .spaceAbove}

   ```
   CALL SYSCS_UTIL.IMPORT_DATA('SPLICEBBALL', 'Players',
      null, '/Users/myName/Downloads/DocExamplesDb/Players.csv',
      null, null, null, null, null, 0, null, true, null);
   ```
   {: .Example}

5. In Splice Machine, use the following command line to run the edited script file:

   ```
   splice> run '/Users/myName/Downloads/DocExamplesDb/CreateDocExamplesDb.sql';​

   ```
   {: .AppCommand}

The script file creates the `SPLICEBBALL` schema and tables, and then imports data from the included `csv` files into the tables.

## Table Schemas {#tables}

Our example tables are all stored in a schema named `SPLICEBBALL`. This
section describes the fields in each of our <span
class="AppCommand">DocsExamplesDb</span> tables.

### The Players Table

The <span class="AppCommand">SPLICEBBALL.Players</span> table contains
these columns:

<table summary="Descriptions of the columns in the Players table.">
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Column Name</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>ID</code></td>
            <td><code>SMALLINT</code></td>
            <td>The unique player ID, assigned upon insertion.</td>
        </tr>
        <tr>
            <td><code>Team</code></td>
            <td><code>VARCHAR</code></td>
            <td>The abbreviated name of the player's team.</td>
        </tr>
        <tr>
            <td><code>DisplayName</code></td>
            <td><code>VARCHAR</code></td>
            <td>The name we use when displaying this player.</td>
        </tr>
        <tr>
            <td><code>Position</code></td>
            <td><code>CHAR(2)</code></td>
            <td>The abbreviation for the player's main position, e.g. P, C, OF, 1B.</td>
        </tr>
        <tr>
            <td><code>Birthdate</code></td>
            <td><code>DATE</code></td>
            <td>The birth date of the player.</td>
        </tr>
    </tbody>
</table>
### The Salaries Table

The <span class="AppCommand">SPLICEBBALL.Salaries</span> table contains
these columns:

<table summary="Descriptions of the columns in the Salaries table.">
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Column Name</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>ID</code></td>
            <td><code>SMALLINT</code></td>
            <td>The unique player ID.</td>
        </tr>
        <tr>
            <td><code>Season</code></td>
            <td><code>SMALLINT</code></td>
            <td>The season (year).</td>
        </tr>
        <tr>
            <td><code>Salary</code></td>
            <td><code>BIGINT</code></td>
            <td>The player's salary for the season.</td>
        </tr>
    </tbody>
</table>
### The Batting Table

The <span class="AppCommand">SPLICEBBALL.Batting</span> contains these
columns:

<table summary="Descriptions of the columns in the Batting table.">
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Column Name</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>ID</code></td>
            <td><code>SMALLINT</code></td>
            <td>The unique player ID.</td>
        </tr>
        <tr>
            <td><code>Season</code></td>
            <td><code>SMALLINT</code></td>
            <td>The season (year).</td>
        </tr>
        <tr>
            <td><code>Games</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of games in which the player batted.</td>
        </tr>
        <tr>
            <td><code>PlateAppearances</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of times the player made a plate appearance.</td>
        </tr>
        <tr>
            <td><code>AtBats</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of official at bats.</td>
        </tr>
        <tr>
            <td><code>Runs</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of runs scores.</td>
        </tr>
        <tr>
            <td><code>Hits</code></td>
            <td><code>SMALLINT</code></td>
            <td>How many hits by the player.</td>
        </tr>
        <tr>
            <td><code>Singles</code></td>
            <td><code>SMALLINT</code></td>
            <td>
                <p class="noSpaceAbove">How many singles hit by the player.</p>
                <p>This value is computed by a triggered function.</p>
            </td>
        </tr>
        <tr>
            <td><code>Doubles</code></td>
            <td><code>SMALLINT</code></td>
            <td>How many doubles hit by the player.</td>
        </tr>
        <tr>
            <td><code>Triples</code></td>
            <td><code>SMALLINT</code></td>
            <td>How many triples hit by the player.</td>
        </tr>
        <tr>
            <td><code>HomeRuns</code></td>
            <td><code>SMALLINT</code></td>
            <td>How many home runs hit by the player.</td>
        </tr>
        <tr>
            <td><code>RBI</code></td>
            <td><code>SMALLINT</code></td>
            <td>How many Runs Batted In by the player.</td>
        </tr>
        <tr>
            <td><code>StolenBases</code></td>
            <td><code>SMALLINT</code></td>
            <td>How many bases the player stole.</td>
        </tr>
        <tr>
            <td><code>CaughtStealing</code></td>
            <td><code>SMALLINT</code></td>
            <td>How many times the player was caught attempting to steal a base.</td>
        </tr>
        <tr>
            <td><code>Walks</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of walks the player drew.</td>
        </tr>
        <tr>
            <td><code>Strikeouts</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of times the player walked.</td>
        </tr>
        <tr>
            <td><code>DoublePlays</code></td>
            <td><code>SMALLINT</code></td>
            <td>How many times the player hit into a double play.</td>
        </tr>
        <tr>
            <td><code>HitByPitches</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of times the player was hit by a pitch.</td>
        </tr>
        <tr>
            <td><code>SacrificeHits</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of sacrifice bunts the player hit.</td>
        </tr>
        <tr>
            <td><code>SacrificeFlies</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of sacrifice flies the player hit.</td>
        </tr>
        <tr>
            <td><code>IntentionalWalks</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of intentional walks issued to the player.</td>
        </tr>
        <tr>
            <td><code>Average</code></td>
            <td><code>DECIMAL</code></td>
            <td>
                <p class="noSpaceAbove">The player's batting average.</p>
                <p>This value is computed by a triggered function.</p>
            </td>
        </tr>
        <tr>
            <td><code>TotalBases</code></td>
            <td><code>SMALLINT</code></td>
            <td>
                <p class="noSpaceAbove">The total number of bases for the player.</p>
                <p>This value is computed by a triggered function.</p>
            </td>
        </tr>
        <tr>
            <td><code>OnBasePercentage</code></td>
            <td><code>DECIMAL</code></td>
            <td>
                <p class="noSpaceAbove">The percentage of times the player reached base.</p>
                <p>This value is computed by a triggered function.</p>
            </td>
        </tr>
        <tr>
            <td><code>Slugging</code></td>
            <td><code>DECIMAL</code></td>
            <td>
                <p class="noSpaceAbove">The slugging average of the player.</p>
                <p>This value is computed by a triggered function.</p>
            </td>
        </tr>
        <tr>
            <td><code>OnBasePlusSlugging</code></td>
            <td><code>DECIMAL</code></td>
            <td>
                <p class="noSpaceAbove">The OPS for the player.</p>
                <p>This value is computed by a triggered function.</p>
            </td>
        </tr>
    </tbody>
</table>
### The Fielding Table

The <span class="AppCommand">SPLICEBBALL.Fielding</span> table contains
these columns:

<table summary="Descriptions of the columns in the Fielding table.">
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Column Name</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>ID</code></td>
            <td><code>SMALLINT</code></td>
            <td>The unique player ID.</td>
        </tr>
        <tr>
            <td><code>Season</code></td>
            <td><code>SMALLINT</code></td>
            <td>The season (year).</td>
        </tr>
        <tr>
            <td><code>FldGames</code></td>
            <td><code>SMALLINT</code></td>
            <td>How many games the player was in the field for.</td>
        </tr>
        <tr>
            <td><code>Chances</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of fielding chances the player had.</td>
        </tr>
        <tr>
            <td><code>Putouts</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of putouts the player had.</td>
        </tr>
        <tr>
            <td><code>Assists</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of assists the player had.</td>
        </tr>
        <tr>
            <td><code>Errors</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of errors committed by the player.</td>
        </tr>
        <tr>
            <td><code>FldDoublePlays</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of doubles plays in which the player was involved in as a fielder.</td>
        </tr>
        <tr>
            <td><code>Percentage</code></td>
            <td><code>DECIMAL</code></td>
            <td>The percentage of opportunities for outs that the player successfully completed.</td>
        </tr>
        <tr>
            <td><code>TZAboveAverage</code></td>
            <td><code>SMALLINT</code></td>
            <td>A fielding metric: total zone runs above average for his position.</td>
        </tr>
        <tr>
            <td><code>TZAboveAveragePer1200</code></td>
            <td><code>SMALLINT</code></td>
            <td>Total zone runs extrapolated for 1200 innings.</td>
        </tr>
        <tr>
            <td><code>RunsSaved</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of runs saved in the field by the player.</td>
        </tr>
        <tr>
            <td><code>RunsSavedAboveAvg</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of runs saved by the player over the average number saved for his position.</td>
        </tr>
        <tr>
            <td><code>RangeFactorPerNine</code></td>
            <td><code>DECIMAL</code></td>
            <td>A fielding metric that evaluates the average number of putouts and assists per nine innings,</td>
        </tr>
        <tr>
            <td><code>RangeFactorPerGame</code></td>
            <td><code>DECIMAL</code></td>
            <td>A fielding metric that evaluates the average number of putouts and assists per game played,</td>
        </tr>
        <tr>
            <td><code>PassedBalls</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of passed balls for catchers.</td>
        </tr>
        <tr>
            <td><code>WildPitches</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of wild pitches for pitchers.</td>
        </tr>
        <tr>
            <td><code>FldStolenBases</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of stolen bases given up by a pitcher or catcher.</td>
        </tr>
        <tr>
            <td><code>FldCaughtStealing</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of players caught stealing by a pitcher or catcher.</td>
        </tr>
        <tr>
            <td><code>FldCaughtStealingPercent</code></td>
            <td><code>DECIMAL</code></td>
            <td>For catchers and pitchers, the percentage of attempted stolen bases that were successful.</td>
        </tr>
        <tr>
            <td><code>FldLeagueCaughtStealingPercent</code></td>
            <td><code>DECIMAL</code></td>
            <td>For pitchers and catchers, the league average percentage of attempted stolen bases that were successful.</td>
        </tr>
        <tr>
            <td><code>Pickoffs</code></td>
            <td><code>SMALLINT</code></td>
            <td>For pitchers and catchers, the number of runners picked off.</td>
        </tr>
        <tr>
            <td><code>FldInnings</code></td>
            <td><code>DECIMAL</code></td>
            <td>The number of innings in which the player was in the field.</td>
        </tr>
    </tbody>
</table>
### The Pitching Table

The <span class="AppCommand">SPLICEBBALL.Pitching</span> table contains
these fields:

<table summary="Descriptions of the columns in the Pitching table.">
    <col />
    <col />
    <col />
    <thead>
        <tr>
            <th>Column Name</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>ID</code></td>
            <td><code>SMALLINT</code></td>
            <td>The unique player ID.</td>
        </tr>
        <tr>
            <td><code>Season</code></td>
            <td><code>SMALLINT</code></td>
            <td>The season (year).</td>
        </tr>
        <tr>
            <td><code>Wins</code></td>
            <td><code>SMALLINT</code></td>
            <td>How many games the pitcher won.</td>
        </tr>
        <tr>
            <td><code>Losses</code></td>
            <td><code>SMALLINT</code></td>
            <td>How many games the pitcher lost.</td>
        </tr>
        <tr>
            <td><code>Games</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of games in which the pitcher appeared.</td>
        </tr>
        <tr>
            <td><code>GamesStarted</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of games the pitcher started.</td>
        </tr>
        <tr>
            <td><code>GamesFinished</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of games the pitcher finished.</td>
        </tr>
        <tr>
            <td><code>CompleteGames</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of complete games by the pitcher.</td>
        </tr>
        <tr>
            <td><code>Shutouts</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of shutout games thrown by the pitcher.</td>
        </tr>
        <tr>
            <td><code>Saves</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of games saved by the pitcher.</td>
        </tr>
        <tr>
            <td><code>Innings</code></td>
            <td><code>DECIMAL</code></td>
            <td>The number of innings pitched.</td>
        </tr>
        <tr>
            <td><code>Hits</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of hits given up by the pitcher.</td>
        </tr>
        <tr>
            <td><code>Runs</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of runs give up by the pitcher.</td>
        </tr>
        <tr>
            <td><code>EarnedRuns</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of earned runs give up by the pitcher.</td>
        </tr>
        <tr>
            <td><code>HomeRuns</code></td>
            <td><code>SMALLINT</code></td>
            <td>How many homeruns the pitcher gave up.</td>
        </tr>
        <tr>
            <td><code>Walks</code></td>
            <td><code>SMALLINT</code></td>
            <td>How many walks the pitcher issued.</td>
        </tr>
        <tr>
            <td><code>IntentionalWalks</code></td>
            <td><code>SMALLINT</code></td>
            <td>How many intentional walks the pitcher issued.</td>
        </tr>
        <tr>
            <td><code>Strikeouts</code></td>
            <td><code>SMALLINT</code></td>
            <td>How many batters the pitchers struck out.</td>
        </tr>
        <tr>
            <td><code>HitBatters</code></td>
            <td><code>SMALLINT</code></td>
            <td>How many batters the pitcher hit with a pitch.</td>
        </tr>
        <tr>
            <td><code>Balks</code></td>
            <td><code>SMALLINT</code></td>
            <td>How many balks the pitcher committed.</td>
        </tr>
        <tr>
            <td><code>WildPitches</code></td>
            <td><code>SMALLINT</code></td>
            <td>How many wild pitches were thrown by the pitcher.</td>
        </tr>
        <tr>
            <td><code>BattersFaced</code></td>
            <td><code>SMALLINT</code></td>
            <td>The number of batters faced by the pitcher.</td>
        </tr>
        <tr>
            <td><code>FieldingIndependent</code></td>
            <td><code>DECIMAL</code></td>
            <td>A metric (FIP) for pitchers that determines the quality of a pitcher's performance by eliminating plate appearance outcomes that involve defensive play.</td>
        </tr>
        <tr>
            <td><code>ERA</code></td>
            <td><code>DECIMAL</code></td>
            <td>
                <p>The pitcher's earned run average.</p>
                <p>This value is computed by a triggered function.</p>
            </td>
        </tr>
        <tr>
            <td><code>WHIP</code></td>
            <td><code>DECIMAL</code></td>
            <td>
                <p>The number of walks and hits per inning pitched by the player.</p>
                <p>This value is computed by a triggered function.</p>
            </td>
        </tr>
        <tr>
            <td><code>HitsPerNine</code></td>
            <td><code>DECIMAL</code></td>
            <td>
                <p>The number of hits per nine innings pitched by the player.</p>
                <p>This value is computed by a triggered function.</p>
            </td>
        </tr>
        <tr>
            <td><code>HomeRunsPerNine</code></td>
            <td><code>DECIMAL</code></td>
            <td>
                <p>The number of home runs per nine innings pitched by the player.</p>
                <p>This value is computed by a triggered function.</p>
            </td>
        </tr>
        <tr>
            <td><code>WalksPerNine</code></td>
            <td><code>DECIMAL</code></td>
            <td>
                <p>The number of walks per nine innings pitched by the player.</p>
                <p>This value is computed by a triggered function.</p>
            </td>
        </tr>
        <tr>
            <td><code>StrikeoutsPerNine</code></td>
            <td><code>DECIMAL</code></td>
            <td>
                <p>The number of strikeouts per nine innings pitched by the player.</p>
                <p>This value is computed by a triggered function.</p>
            </td>
        </tr>
        <tr>
            <td><code>StrikeoutsToWalks</code></td>
            <td><code>DECIMAL</code></td>
            <td>
                <p>The ratio of strikeouts to walks thrown by the pitcher.</p>
                <p>This value is computed by a triggered function.</p>
            </td>
        </tr>
    </tbody>
</table>
</div>
</section>



[1]: http://www.baseball-reference.com/
