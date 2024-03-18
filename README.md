# Rugby-Data-Analysis

# Structure
- Initial DataSet from Kaggle is linked in this readme file
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
- Standardising Date format to YYY-MM-DD.

Additional Steps involved:


# Cleanining in SQL

See Queries.py for more detail.

This involved standardising the Stadium Names, Competition Names, Creating a New Table and inserting data from the Rugby Union data set WHERE 'Six Nations' was the competition. 

Other steps involved..

# Querying the Dataset

See Queries.py for more detail.

# Visualising Trends & Relationships

- Intended to be Visualised in Power BI and Tableau, and will be linked in this Repo.

Power BI:
What I Visualised:


Techniques used:
- DAX:

- Created New Columns
- Change Data-Types.
