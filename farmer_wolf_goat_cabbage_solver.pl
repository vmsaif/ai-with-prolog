% File Name : farmer_wolf_goat_cabbage_solver.pl
% -----------------------------------------------------------------------------
% Author: Saif Mahmud
% Date: 04-19-2023
% Description: Using depth first search and breadth first seach algorithm to solve the famous problem of a farmer having a goat, a wolf, and a cabbage. The farmer wants to cross the river from the east shore to the west shore, but his boat is small. The boat has space for only the farmer with one of the items: cabbage, wolf, or goat. The farmer cannot leave the wolf alone with the goat or the goat alone with the cabbage.


/* Short report on how the program works and what it does:

    To solve the program, 2 search algorithms are used: Depth First Search and Breadth First Search. The search algorithms are implemented using Prolog. The search algorithms are implemented using the following rules:

    1. The initial state is the state where the farmer, wolf, goat, and cabbage are all on the east shore.
    2. The goal state is the state where the farmer, wolf, goat, and cabbage are all on the west shore.
    3. The farmer can move with one the goat, wolf, or cabbage at a time. The farmer can also move alone.
    4. The farmer cannot leave the wolf alone with the goat or the goat alone with the cabbage.

    The search algorithms are implemented using the following rules:
    1. For the depth first search algorithm:
        It finds a solution by starting from the initial state and then moving to the next state. It then moves to the next state and so on until it reaches the goal state. If it reaches a state where it cannot move to any other state, then it backtracks to the previous state and tries to move to another state. It continues to do this until it reaches the goal state.

    2. For the breadth first search algorithm:
        It finds a solution by starting from the initial state and then moving to its neighbors. It then moves to the neighbors of the neighbors and so on until it reaches the goal state. If it reaches a state where it cannot move to any other state, then it backtracks to the previous state and tries to move to another state. It continues to do this until it reaches the goal state.

    Execution Example:
        To run the depth first search algorithm, 
            depthFirstSearch.
        To run the breadth first search algorithm,
            breadthFirstSearch.
*/

% The starting state of the farmer, wolf, goat, and cabbage
initial_state(state(e, e, e, e)).

% The goal state of the farmer, wolf, goat, and cabbage
goal_state(state(w, w, w, w)).

% It is used to change the direction of the farmer, wolf, goat, and cabbage from e to w and vice versa.
changeDirection(e, w).
changeDirection(w, e).

% Rules to ensure that the goat or cabbage is safe
allSafeRules(state(Farmer, Wolf, Goat, Cabbage)) :-
    (
        % all are on the same side
        (Farmer = Wolf, Farmer = Goat, Farmer = Cabbage);

        % wolf and goat are not together or farmer is with them
        (Wolf \= Goat ; Farmer = Wolf, Farmer = Goat),

        % goat and cabbage are not together or farmer is with them
        (Goat \= Cabbage ; Farmer = Goat, Farmer = Cabbage)
    ).


% Possible moves

% Farmer moves with goat
move(state(F1, W1, G1, C1), state(F2, W2, G2, C2), 'Farmer moves with the goat') :-
    F1 = G1, % Ensuring that the farmer and the goat are on the same side before moving
    changeDirection(F1, F2),
    W1 = W2,
    changeDirection(G1, G2),
    C1 = C2.
    

% Farmer moves with wolf
move(state(F1, W1, G1, C1), state(F2, W2, G2, C2), 'Farmer moves with the wolf') :-
    F1 = W1, % Ensuring that the farmer and the wolf are on the same side before moving
    changeDirection(F1, F2),
    changeDirection(W1, W2),
    G1 = G2,
    C1 = C2.
    
    
% Farmer moves with cabbage
move(state(F1, W1, G1, C1), state(F2, W2, G2, C2), 'Farmer moves with the cabbage') :-
    F1 = C1, % Ensure that the farmer and the cabbage are on the same side before moving
    changeDirection(F1, F2),
    W1 = W2,
    G1 = G2,
    changeDirection(C1, C2).
    

% Farmer moves alone
move(state(F1, W1, G1, C1), state(F2, W2, G2, C2), 'Farmer comes back') :-
    changeDirection(F1, F2),
    G1 = G2,
    W1 = W2,
    C1 = C2.

% Depth-first search with cycle detection
depthFirstSearch :-
    nl,
    writeln('------------------Starting Depth First Search:-----------------------'), nl,
    initial_state(I),
    % Finding all the solutions and storing them in a list with removing duplicates
    setof(
        (Solution, MoveName),
        depthFirstSearchHelper([I], ['Initial State'], [], Solution, MoveName),
        UniqueSolutions
    ),
    writeSolutionList(UniqueSolutions).


% Base case. If the current state is the goal state, then we have found a solution.
depthFirstSearchHelper(Path, ReverseMoveName, _, Solution, MoveName) :-
    [H|_] = Path,
    goal_state(H),
    reverse(Path, Solution),
    reverse(ReverseMoveName, MoveName).


% Recursive case. If the current state is not the goal state, then we need to find a new state to move to.
depthFirstSearchHelper(Path, ReverseMoveName, Visited, RevSolution, MoveName) :-
    [H|_] = Path,
    \+ member(H, Visited),
    move(H, NewState, CurrentMove),
    % Ensuring that the new state is safe
    allSafeRules(NewState),
    % Calling the helper function with the new state, move name, visited list, and solution list.
    depthFirstSearchHelper([NewState|Path], [CurrentMove|ReverseMoveName], [H|Visited], RevSolution, MoveName).

    
% Breadth-first search with cycle detection
breadthFirstSearch :-
    nl,
    writeln('------------------Starting Breadth First Search:-----------------------'), nl,
    initial_state(I),
    % Finding all the solutions and storing them in a list with removing duplicates
    setof(
        (Solution, MoveName),
        % Start with the initial state, an empty path, visited list, move name list and call the helper function.
        breadthFirstSearchHelper([([I], ['Initial State'], [I])], Solution, MoveName),
        UniqueSolutions
    ),
    
    writeSolutionList(UniqueSolutions).
    
% Base case 
breadthFirstSearchHelper([([Current|Path], [CurrMoveName|MoveNamePath], _)|_], Solution, MoveName) :-
    % If the current state is the goal state, then we have found a solution.
    goal_state(Current),
    reverse([Current|Path], Solution),
    reverse([CurrMoveName|MoveNamePath], MoveName).

% Recursive case
% Finding all possible moves from the current state and adding them to the path list. Then call the helper function again.
breadthFirstSearchHelper([([Current|Path], [CurrMoveName|MoveNamePath], Visited)|RestPaths], Solution, MoveName) :-
    
    % Finding all possible moves from the current state.
    findall(
        (Next, NextMoveName, [Next|Visited]),
        (
            move(Current, Next, NextMoveName),
            allSafeRules(Next),
            \+ member(Next, Visited)
        ),
        NewMoves
    ),

    % Expanding the new paths and adding them to the path list.
    expandPaths(NewMoves, [Current|Path], [CurrMoveName|MoveNamePath], PathList),
    append(RestPaths, PathList, UpdatedPaths),
    
    % Calling the helper function again with the updated path list.
    breadthFirstSearchHelper(UpdatedPaths, Solution, MoveName).



% Expanding the new paths and adding them to the path list.
% Base case. If the new moves list is empty, then return the path list.
expandPaths([], _, _, []).

% Recursive case. If the new moves list is not empty, then add the new paths to the path list.
expandPaths([(H, MoveName, Visited)|T], Path, MoveNamePath, [([H|Path], [MoveName|MoveNamePath], Visited)|Rest]) :-
    expandPaths(T, Path, MoveNamePath, Rest).


%  Writing the list of states and the list of move names to the console in a readable format.
%  Base case. If the list of states and the list of move names are empty, then return.
writeList([], []).

%  If the last element, add goal reached.
writeList([H1], [H2]) :- 
    write(H2), nl,
    write(H1), write('.'), nl, nl,
    write('Goal Reached.'), 
    !.

% Recursive case. If the list of states and the list of move names are not empty, then write the state and the move name to the console.
writeList([H1|T1], [H2|T2]) :-
    
    write(H2),
    nl,

    write(H1),
    write(', '), nl, nl,
    
    writeList(T1, T2).


% Predicate to write a list of solutions
writeSolutionList([]).
writeSolutionList([(Solution, MoveName)|T]) :-
    nl,
    writeln('---------Starting A Solution:----------'), nl,
    writeList(Solution, MoveName),
    nl,
    writeSolutionList(T).








