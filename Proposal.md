# CPSC 312 Project

Prolog Transfer Layer for SQL

Our group is going to implement a Prolog project that executes queries against a database. Our project will be implemented using the existing knowledge base of Prolog and SQL language.

This project is in fulfillment of the [CPSC 312 2021W1 project requirements](https://steven-wolfman.github.io/cpsc-312-website/project.html).

# Prolog to SQL Transfer Layer 
Team Members
Our team is:
+ Mahitab Emara (80537723)
+ Kenneth Averna (74109653)
+ Madeleine Penner (57844268)
+ Tristan Russell (77080802)
We call ourselves: teamProlog

## Product Pitch

Prolog is a powerful language for creating databases using the language itself and querying on the data. However, there have not been many options for Prolog programmers who want to perform queries on existing databases. For example, in Prolog, while a person can store data/facts in Prolog, they can not store, retrieve, project and reduce trillions of rows with thousands of simultaneous users. In addition, it is extremely tedious for Prolog programmers to perform queries on existing databases. However, a language that allows a person to actually do the above is SQL! For Prolog users to do the above, we propose to create a Prolog program that uses SQL to satisfy that purpose. 

Although they operate across the same conceptual domains, their focuses are in completely different directions. In Prolog terms, SQL is primarily a Fact and Relation(set) engine, whereas Prolog is primarily a Rules and Inferencing engine. For example, SQL is more able to extract relevant data from a data set as compared to Prolog. SQL and Prolog form a great pairing! For starters, facts in Prolog and data in SQL are the same thing. Both languages are logic-driven, both store and express complex logical conditions and relations, and they both have queries. In addition, facts in Prolog are data in SQL (and can derive conclusions from them), relation in Relational Theory is a Table in SQL, a View in SQL is the same thing as a Rule in Prolog. 

## Minimal Viable Project

In SQL, we are able to modify the database in multiple ways; examples include but are not limited to extracting/updating/deleting/inserting data into a database, creating and altering a database, and creating/altering/dropping tables in a database. 
Our project aims to work with existing databases. A great feature of the Prolog language is that it enables us to import existing files using predicates like open and read_file. Our project only chooses to implement in prolog SQL commands that modify existing databases as opposed to creating new databases from scratch. In other words, our project will support commands from SQL like SELECT, UPDATE, DELETE, INSERT.  
A new feature of the language we are implementing is the ability to tie SQL with Prolog. We do so by creating SQL predicates and including the commands (like SELECT, UPDATE, etc.) as arguments to the predicate. 

## Proof of Concept

The proof of concept shows that we can read in a data file and call the SELECT and FROM SQL commands on it. 

The proof of concept utilizes Prolog’s ability to query databases, in essence turning it into a relational database management system such as SQL. The implementation reads in a data file and creates a local relational database with Prolog’s built-in assert function. This allows for further complex implementation with more than 2d data. The proof of concept asserts tuples to the database where the program asks queries against this in an SQL format. This includes the SELECT and FROM features as applied to our simple relational database.

## How to test and run the code: Prolog

We have a local .txt file that is recommended to use with the program. Other .txt files are acceptable to use, however be aware that it should follow the data format that leads with the column header, and has the data underneath. To query against the file, first the program either needs to run main(Filename), to assert the data, or sql(select, Filename) which achieves the same assertion. From there you can query to see if specific data is in the set by asking:
sql(select, Data, from, Header), where data is the specific string or int that you want to see if it exists, and Header is the header of the data that could possibly exist in. Example: sql(select, ‘line 0’, from, ‘header’). The query can also ask for all the data within the set by asking the same thing, but leaving the data variable as just a variable. In the terminal, pressing ; after the first print will continue to print out the rest of the data with the header matching that of your query.
