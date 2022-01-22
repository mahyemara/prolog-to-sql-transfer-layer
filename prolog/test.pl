:- dynamic data/3.

appears_in(SubText, Text) :- sub_string(Text, _, _, _, SubText).

append( [], X, X).                                  
append( [X | Y], Z, [X | W]) :- append( Y, Z, W). 



mainCSV(File, Lines) :-
   setup_call_cleanup(open(File, read, In),
      stream_lines(In, Lines),
      close(In)),
      parse_data(Lines, [Output|Rest]),
      sort_data(Output, Rest, 0),
      write(Output).

stream_lines(In, Lines) :-
   read_string(In, _, Str),
   split_string(Str, "\n", "", Lines).


parse_data([], _).
parse_data([Head|Tail], [X|Rest]) :- 
   split_string(Head, ",", "", L),
   L = X,
   parse_data(Tail, Rest).

sort_data(_, [], _).
sort_data(Headers, [Data|RestData], Id) :-
   assert_data(Headers, Data, Id),
   NewId is Id + 1,
   sort_data(Headers, RestData, NewId).


assert_data([],[], _).
assert_data([Head|Rest], [Y|Xs], Id) :-
   \+ data(topID, Head, _),
   assert(data(topID, Head, Id)),
   assert(data(Head, Y, Id)),
   assert_data(Rest, Xs, Id).
assert_data([Head|Rest], [Y|Xs], Id) :-
   data(topID, Head, OldID),
   retract(data(topID, Head, OldID)),
   assert(data(topID, Head, Id)),
   assert(data(Head, Y, Id)),
   assert_data(Rest, Xs, Id).

mainTXT(File) :-
   open(File, read, Str),
   read_file(Str,Lines),
   close(Str),
   header(Header,Lines),
   assertToData(Header, Lines, 0),
   write(Lines).

% gets the header of the data file
header(header, [X|_]) :- nb_setval(header, X). 

% takes the header and the data and asserts it
assertToData(_, [], _).
assertToData(Header, [Y|Xs], Id):- 
   \+ data(topID, Header, _),
   assert(data(topID, Header, Id)),  
   assert(data(Header, Y, Id)), 
   NewID is Id + 1,
   assertToData(Header, Xs, NewID).
assertToData(Header, [Y|Xs], Id):- 
   data(topID, Header, OldID),
   retract(data(topID, Header, OldID)),
   assert(data(topID, Header, Id)),  
   assert(data(Header, Y, Id)), 
   NewID is Id + 1,
   assertToData(Header, Xs, NewID).

% reads in the file with empty data
read_file(Stream,[]) :-
   at_end_of_stream(Stream).

% reads in the file with non-empty data
read_file(Stream,[X|L]) :-
   \+ at_end_of_stream(Stream),
   read(Stream, X),
   read_file(Stream, L).

getData(Header) :- data(Header, _, _).
getData(Header, Data) :- data(Header, Data, _).

% INSERT INTO Header VALUES Data;                      
insert_Data(Header, Data) :- data(topID, Header, OldId), Id is OldId + 1, retract(data(topID, Header, OldID)), assert(data(topID, Header, Id)), assert(data(Header,Data, Id)).

% DELETE FROM Header WHERE Value = Data;
remove_Data(Header, Data) :- data(Header, Data, _), retract(data(Header, Data, _)).

clear_Data :- abolish(data/3).

% UPDATE
update_Data(Header, Data, Id) :- data(Header, _, Id), retract(data(Header, _, Id)), assert(data(Header, Data, Id)).


% SELECT * FROM *
sql(clear) :- clear_Data.
sql(select, Data, from, Header) :- getData(Header, Data).
sql(insert, Data, in, Header) :- insert_Data(Header, Data).
sql(delete, Data, from, Header) :- remove_Data(Header, Data).
sql(select, FileName) :- appears_in(".txt", FileName), mainTXT(FileName).
sql(select, FileName) :- appears_in(".csv", FileName), mainCSV(FileName,_).
sql(select, id, Id, from, Header) :- data(Header, _, Id).
sql(update, Header, set, Data, where, Id) :- update_Data(Header, Data, Id).



:- begin_tests('sql').

test('test for main .txt file', [nondet]) :-
   mainTXT('practiceFile.txt').

test('test for main .csv file', [nondet]) :-
   mainCSV('smallcsvtest.csv', _).

test('reading in a small csv file', [nondet]) :- 
   sql(select, 'smallcsvtest.csv').

test('reading in a large csv file', [nondet]) :-
   sql(select, 'accessories.csv').

test('test for setting the header of data', [nondet]) :-
   header(header, [header]).

test('selecting all data from the header', [nondet]) :-
   sql(select, _, from, 'header').

test('selecting specific data from the header', [nondet]) :-
   sql(select, 'line 0', from, 'header').

test('selecting specific data from the header', [nondet]) :-
   sql(select, 'line 9', from, 'header').
   
test('inserting specific data into the header', [nondet]) :-
   insert_Data('header', 'line 10').

test('inserting specific data from sql command line', [nondet]) :-
   sql(insert, 'line 10', in,  'header').

test('deleting specific data into the header', [nondet]) :-
   remove_Data('header', 'line 9').

test('removing data from sql command line', [nondet]) :-
   sql(select, 'smallcsvtest.csv'),
   sql(delete, "3D glasses", from, "Name").

test('update data in the knowledge base using its id', [nondet]) :-
   sql(update, 'header', set, 'line updated', where, 3).

test('clear all data from the knowledge base', [nondet]) :-
   sql(select, 'accessories.csv'),
   sql(clear).



:- end_tests('sql').

% Run me with: run_tests.
