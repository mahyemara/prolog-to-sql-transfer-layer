# CPSC 312 Project: **Prolog to SQL Transfer Layer**

## We call ourselves:
teamProlog

## Team Members:
+ Mahitab Emara (80537723)
+ Kenneth Averna (74109653)
+ Madeleine Penner (57844268)
+ Tristan Russell (77080802)

## Proposal Link:
found in Proposal.md

## Video Link:
https://www.youtube.com/watch?v=Ql3Rvn8qcSo

## MVP:

Through our MVP, we Prolog programmers are now able to perform certain SQL queries on existing databases! In our code, we import existing databases in Prolog using the mainCSV/2, stream_lines/2, parse_data/2, sort_data/2, assert_data/2, and mainTXT/1 predicates. We later get the header of the data file using the header/2 predicate, assert the data and header by the assertToData/2 predicate, and read the file using the read_file/2 predicates. 

We are now also able to alter a database in Prolog as we would in SQL by various commands. SQL Commands implemented include:

### INSERT INTO Header VALUES Data:
this is implemented using _insert_Data(Header, Data) :- data(topID, Header, OldId), Id is OldId + 1, retract(data(topID, Header, OldID)), assert(data(topID, Header, Id)), assert(data(Header,Data, Id))._ To insert Data into Header, we simply assert the data as a fact into our existing knowledgebase. It must also assign that data an id, so it finds the current highest id for that header, and sets the new data's id to be 1 higher, and updates the highest id value.

### DELETE FROM Header WHERE Value = Data;
this is implemented using _remove_Data(Header, Data) :- data(Header, Data, _), retract(data(Header, Data, _))._ To remove Data from Header, we must first assert that Data is in fact a data in header, then we retract it.

### UPDATE Header SET Data WHERE Id:
this is implemented using _update_Data(Header, Data, Id) :- data(Header, _, Id), retract(data(Header, _, Id)), assert(data(Header, Data, Id))._ To update Data in Header, it looks for an existing Data in the Header with id = Id, retracts that Data, and inserts the new Data with the same Id. 


## Guide To Our New Learning:

After consulting the Prolog documentation, we were able to learn to import files into Prolog, but also how to assert the files' data as facts! The most exciting part, however, was learning how to use known Prolog predicates to tie SQL with Prolog. We learned how to insert, select, delete and update data in a database...all using facts and predicates as opposed to using commands!


