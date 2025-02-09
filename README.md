# SQL Project: Music Store Database

📌 Project Overview

The main goal of this project is to use SQL to analyze an existing digital music store database. By creating optimal queries with Joins, Subqueries, Aggregate Functions, Window Functions, and Common Table Expressions (CTEs), the objective is to extract significant insights. The database consists of 10 interconnected tables, managing various entities such as customers, invoices, tracks, albums, artists, playlists, and employees. This project showcases efficient querying techniques to derive actionable insights for business decision-making in a music store environment.

Normalization: The database follows 3rd Normal Form (3NF) to reduce redundancy and ensure data integrity.
Data Integrity: Implemented primary keys, foreign keys, and constraints to maintain relationships between tables.
Efficient Querying: Used joins, subqueries, and aggregate functions for deeper analysis of sales, customer behavior, and track popularity.
Scalability: Designed to handle thousands of records, making it applicable for real-world music store management.

📊 Dataset

The dataset includes information on customers, invoices, tracks, albums, artists, playlists, and employees. It consists of structured data stored in an Excel file, which was imported into MySQL to create relational tables. The database schema was designed based on an Entity-Relationship (ER) diagram, ensuring logical connections between entities.

🔧 Features & Optimizations

Efficient Queries: Implemented optimized SQL queries for retrieving key insights.
Joins & Subqueries: Used advanced joins and subqueries to link multiple tables effectively.
Aggregate Functions: Leveraged SUM(), AVG(), and COUNT() for deeper data analysis.
Windows Functions: Applied RANK(), DENSE_RANK(), and ROW_NUMBER() for analytical queries.
Common Table Expressions (CTE): Used WITH statements to simplify complex queries and improve readability.
Data Integrity Constraints: Used primary keys, foreign keys, and constraints to maintain data consistency.

📈 Analysis & Insights

This project involved solving 15 SQL(basic to advannce) queries, each designed to extract meaningful insights from the music store database. Here’s a summary:

Customer Analysis: Identified the top-paying customers and frequent buyers.
Sales Trends: Analyzed which genres, artists, and albums generate the highest revenue.
Employee Performance: Tracked which sales representatives handled the most customer accounts.
Playlist & Track Insights: Determined the most added songs to playlists and popular media types.

📌 Real-World Applications

The insights from these queries can be useful in real-world business decisions, such as:

Music Store Management: Understanding which genres and artists generate the most sales.
Marketing Strategies: Targeting high-value customers with personalized promotions.
Employee Evaluation: Assessing sales representatives' performance based on customer retention.
Playlist Optimization: Recommending tracks based on user preferences.

🗂 Files in This Repository

SQL_Code.sql → Contains all SQL queries (schema & data).
ER_Diagram.png → Visual representation of the database.
Table_name.csv → Raw dataset used for creating tables.
Queries.pdf → Contains the project questions and objectives.

🚀 How to Use This Project

Import SQL_Code.sql into MySQL.
Run queries to analyze the data.
Modify or expand the database as needed.

📌 Future Enhancements

Adding stored procedures for automation.
Creating a front-end interface for data visualization.

🔗 Connect with Me

If you have any feedback or suggestions, feel free to reach out! 🚀
