% File Name: acyclic_path.pl
% -----------------------------------------------------------------------------
% Author: Saif Mahmud
% Date: 03-12-2023
% Purpose:  Given a graph G and two nodes A and Z in G, write a program in Prolog that 
%           finds an acyclic path P between A and Z. The path should be represented as 
%           an ordered list of nodes from the start node to the goal node. Since the 
%           path must be acyclic, a node can appear in the path only once. 
% -----------------------------------------------------------------------------
 
/* 
- Short Report of how the program works.

This Program runs by the main predicate findPath(A, Z, PathList). Then it calls the helper predicate findPathHelper(X, Y, VisitedList, PathList). If the base case is met, then the path is found and the path list is returned. If the recursive case is met, then the program will find an edge from node X to another node Z. Then it will check if Z has already been visited. If it has not been visited, then it will recursively call the findPathHelper predicate with Z as the new X, Y as the same, and the new visited list with Z added. This will continue until the base case is met. 

- Execution Example

    ?- findPath(b, z, PathList).
    The result will be-> PathList = [b, c, z] .

    ?- findPath(a, z, PathList).
    The result will be-> false.
*/


% Defining my graph
myGraph([a(b,c), a(b,d), a(d,z), a(c,z), a(c,d)]).

% Defining the main predicate to find a path from A to Z
findPath(A, Z, PathList) :-
    % Starting with list of visited nodes where from A to A is only visited. 
    findPathHelper(A, Z, [A], ReversedPathList),
    % Reversing the path list to get the correct order
    reverse(ReversedPathList, PathList).

% Base Case: If X is equal to Y, then we have found a full path
findPathHelper(X, Y, VisitedList, PathList) :-
    X = Y,
    % Now setting the final path list.
    PathList = VisitedList.
    
% % Recursive Case: If X is not equal to Y, then we need to find a path from X to Y  
findPathHelper(X, Y, VisitedList, PathList) :-
    
    % Get the list of edges for node X in the graph. Setting that list to NodeEdgesList variable.
    myGraph(NodeEdgesList),
    % Find an edge from node X to another node Z.
    member(a(X, Z), NodeEdgesList),

    % Ensuring Z has not already been visited by using if member is not present in VisitedList
    \+ member(Z, VisitedList),

    % Recursively finding a path from Z to Y, with Z added to the visited nodes list
    NewVisitedList = [Z|VisitedList],
    findPathHelper(Z, Y, NewVisitedList, PathList).
