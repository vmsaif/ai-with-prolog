% File Name: locate_indexes.pl
% -----------------------------------------------------------------------------
% Author: Saif Mahmud
% Date: 2023-01-13
% Purpose: A program that reads an integer x and a list of integers L; then locate the list of all positions of x into L, and return the resulting list.
% -----------------------------------------------------------------------------

% main predicate
getIndex(X, L, Location_list) :- 
    % helper predicate
    getIndex(X, L, 1, Location_list).

getIndex(_, [], _, []). % Base case, if main list is empty, return empty list.


getIndex(X, [H|T], Curr_index, Location_list) :- 
    X \== H,
    % nothing found. so incrementing index and calling predicate again
    Curr_index_new is (Curr_index + 1),
    getIndex(X, T, Curr_index_new, Location_list).
    
getIndex(X, [H|T], Curr_index, Location_list) :- 
    X == H,
    Curr_index_new is (Curr_index + 1),

    % found one but need to look for more, so calling the predicate again
    getIndex(X, T, Curr_index_new, New_location_list),

    % add to the list
    Location_list = [Curr_index | New_location_list].
    