% File Name: minimum_cost_path
% -----------------------------------------------------------------------------
% Author: Saif Mahmud
% Date: 03-12-2023
% Description: A program in Prolog that given two nodes X and Y in the graph will find the minimum-cost path from node X to node Y and display the found path and its cost.
% -----------------------------------------------------------------------------

/* 
- Short Report of how the program works.

This Program runs by the main predicate minPath(A, Z, PathList, TotalCost). Then it calls the helper predicate minPathHelper(X, Y, VisitedList, PathList, CurrCost, TotalCost). If the base case is met, then the path and the cost are found and they are returned. If the recursive case is met, then the program will find an edge and it's cost from node X to another node Z. Then it will check if Z has already been visited. If it has not been visited, then it will add the cost to current cost, then it will recursively call the minPathHelper predicate with Z as the new X, Y as the same, and the new visited list with Z added. This will continue until the base case is met. 

- Execution Example

    ?- minPath(a,d, Path, Cost).

    The result will be-> 
    Path = [a, b, c, d],
    Cost = 6 .

    ?- minPath(c,b, Path, Cost). 

    The result will be-> 
    Path = [c, d, b],
    Cost = 3 .

    if no path exists between two nodes, then it will return false.
    ?- minPath(b, a,  Path, Cost). 
    The result will be-> false.
    
*/

% Defining the edges and their costs
edge(a, b, 3).
edge(b, c, 1).
edge(b, d, 5).
edge(c, d, 2).
edge(d, b, 1).

% Defining the main predicate to find the minimum-cost path
minPath(X, Y, PathList, TotalCost) :-
     % Starting with list of visited nodes where from X to X is only visited with current cost 0. 
    minPathHelper(X, Y, [X], ReversedPath, 0, TotalCost),
    % Reversing the path list to get the correct order
    reverse(ReversedPath, PathList).

% Base Case: If X is equal to Y, then we have found a full path, and total cost.
minPathHelper(X, Y, VisitedList, PathList, CurrCost, TotalCost) :-
    X = Y,
    % Now setting the final path list.
    PathList = VisitedList,
    % Now setting the final cost.
    TotalCost = CurrCost.
    
% Recursive case: If X is not equal to Y, then we need to find a path from X to Y and add the cost of the edge to CurrCost.
minPathHelper(X, Y, VisitedList, PathList, CurrCost, TotalCost) :-
    % Find a neighbor of the current node X to another node Z. 
    edge(X, Z, EdgeCost),
    % Ensuring Z has not already been visited by using if member is not present in VisitedList
    \+ member(Z, VisitedList),
    % Calculating the cost of the path so far and the cost of the edge
    NewCurrCost is CurrCost + EdgeCost,
    % Recursively finding a path from Z to Y, with Z added to the visited nodes list
    NewVisitedList = [Z | VisitedList],
    minPathHelper(Z, Y, NewVisitedList, PathList, NewCurrCost, TotalCost).

% -----------------------------------------------------------------------------
