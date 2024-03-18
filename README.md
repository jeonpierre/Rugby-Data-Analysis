# Rugby-Data-Analysis

# Structure
- Initial DataSet from Kaggle is linked in this readme file
- Set up GitHub Repository and connection with VSCode to Remote Push Files and Updates to the Repository for this project and maintain source control. 
- SQL Queries and Cleaning Steps are documented and available in the Repo (Queries.py)
- Clean Excel dataset and SQL Temporary Tables are Avaialble in the uploaded Clean_Six_Nations. excel file available in the Repo. This will be used for Tableau and Power BI visualisations.
- Visualisations currently available under the Rugby_visualisations.pbix file in this GitHub repo, although remains unfinished and will be supplemented with Tableau Visualisations. 

# Intention
The Intention behind this project is to Analyse some Rugby Union Data. 
Specifically to clean, query / analyse and visualise data behind Six Nations Campaigns from the Year 2000-2023.

# The Data
The Data was obtained from a Kaggle Dataset - https://www.kaggle.com/datasets/lylebegbie/international-rugby-union-results-from-18712022

# Procedure

I Downloaded the Dataset from Kaggle and Opened the file in Microsoft Excel. 

The first step was to profile the data, and get a bearing of the data and its strucutre. 

After Profiling the data and recognising some errors in standardisation and duplicates. I set about cleaning the data in Excel.

# Cleanining in Excel

Firstly this involved removing the duplicates from the data with the inbuilt funcitons. 
- TRIM & PROPER to standardise Text and Spacing
- Find / Replace to remove special characters
- Standardising Date format to YYYY-MM-DD.

Additional Steps involved:


# Cleanining in SQL

See Queries.py for more detail.

This involved standardising the Stadium Names, Competition Names, Creating a New Table and inserting data from the Rugby Union data set WHERE 'Six Nations' was the competition. 

Other steps involved..

# Querying the Dataset

See Queries.py for more detail.

# Visualising Trends & Relationships

- Intended to be Visualised in Power BI and Tableau, and will be linked in this Repo.

Power BI Interactive Report:
What I Visualised:

Overview of the Six Nations 
Total Wins for Each Nation, with Drill Down for Home vs Away Record.
Home vs. Away Wins for Each Nation
Win Percentage by Year for Each nation
Total Home Scores
Total Away Scores
Average Points Difference by Year (Filtered with Slider)
Points Difference for Winner (Filtered with Slider)
Nation Performance by Location / Stadium (Drill down for City)


Techniques used:
- DAX: SUM, COUNT, SUMX, AVERAGE,
- Data Moddeling, Bridging new connections, Cardinality and Cross Filter Direction between 7 Different Tables.
- Created New Columns, Dropped Columns
- Changed Data-Types
- Created New Measures and Calculated Columns
  

