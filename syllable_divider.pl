% File Name: syllable_divider.pl
% -----------------------------------------------------------------------------
% Author: Saif Mahmud
% Date: 03-18-2023
%
% Description: Prolog program that teaches children how to pronounce multisyllable words by dividing them into syllables. Limiting my program to deal only with syllables of the following two sequences:
%   1. vowel–consonant–vowel: divide the word after the second vowel.
%   Example: analog ---> ana-log
%   2. vowel–consonant–consonant–vowel: divide the word between the two consonants.
%   Example: bumper ---> bum-per
% -----------------------------------------------------------------------------

/* 
- Short Report of how the program works.

The program starts by defining vowels and non-vowels. It then defines the main predicate, "syllables," that takes a word as input and returns the syllables of that word. The program converts the input word to a list of characters and passes it to the helper predicate, "syllablesHelper," along with an empty list that acts as a working list. The helper predicate then checks for the two patterns mentioned above. If the pattern is found, it adds a dash to the working list and appends the rest of the list to the working list. If the pattern is not found, it just appends the current character to the working list. The helper predicate then calls itself with the rest of the list and the new working list. The base case is when the input list is empty, then the helper predicate returns the final working list to the main predicate, which then converts it to a string and prints it on the console.

- Execution Example

    ?- syllables(analog).

    The result will be-> 
        ana-log
        true.
    
    ?- syllables(bumper).

    The result will be-> 
        bum-per
        true.
    
*/

% Defining the vowels
vowel(a).
vowel(e).
vowel(i).
vowel(o).
vowel(u).

% Defining the non-vowels
notVowel(Char) :-
    \+(vowel(Char)).

%  This is the main predicate that will be called by the user.
syllables(Word) :-
    % converting the input word to a list of chars
    atom_chars(Word, CharList),
    % calling the helper predicate with the empty list as the running/working List
    syllablesHelper(CharList, [], Syllables),

    % Got the final result in the syllables list, but it is a list of chars, so we need to convert it to a string
    % converting the list of chars to a string
    atom_chars(NonListSyllables, Syllables),
    % printing the result on the console
    write(NonListSyllables).

% base case when the input list is empty, then we are done, return the final list to Syllables.
syllablesHelper(CharList, RunningList, Syllables) :-
    CharList = [],
    Syllables = RunningList.
    
% case 1: vowel–consonant–vowel: divide the word after the second vowel.
syllablesHelper(CharList, RunningList, Syllables) :-
    CharList = [H|T], 
    vowel(H),
    T = [H1|T1],
    notVowel(H1),
    T1 = [H2|T2],
    vowel(H2),

    % pattern found, adding a dash, append the rest of the list to the resultList
    append(RunningList, [H, H1, H2, '-'], NewResultList),
    % calling the helper predicate with the rest of the list and the new result list
    syllablesHelper(T2, NewResultList, Syllables).


% case 2: vowel–consonant–consonant–vowel: divide the word between the two consonants.
syllablesHelper(CharList, RunningList, Syllables) :-
    CharList = [H|T],
    vowel(H),
    T = [H1|T1],
    notVowel(H1),
    T1 = [H2|T2],
    notVowel(H2),
    T2 = [H3|T3],
    vowel(H3),

    % pattern found, adding a dash, append the rest of the list to the resultList
    append(RunningList, [H, H1,'-', H2, H3], NewResultList),
    % calling the helper predicate with the rest of the list and the new result list
    syllablesHelper(T3, NewResultList, Syllables).


% First one is a non-vowel, or no pattern found in between, then just append the current char to the result list
syllablesHelper(CharList, RunningList, Syllables) :-
    CharList = [H|T],
    append(RunningList, [H], NewResultList),
    % calling the helper predicate with the rest of the list and the new result list
    syllablesHelper(T, NewResultList, Syllables).
    