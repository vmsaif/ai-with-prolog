# AI with Prolog

This repository contains a collection of Prolog programs written by Saif Mahmud. Below is a brief description of each program and its functionality.

## Requirements

- SWI-Prolog

### Installation of SWI-Prolog

For detailed installation instructions, visit the [official SWI-Prolog website](https://www.swi-prolog.org/Download.html). Here's a quick guide for Ubuntu users:

```bash
sudo apt-add-repository ppa:swi-prolog/stable
sudo apt-get update
sudo apt-get install swi-prolog
```

### Running the Programs

Navigate to the directory containing the Prolog file you want to run. Start SWI-Prolog with:

```bash
swipl
```

Then, load the program: (don't forget the period at the end)

```prolog
?- [filename].
```

Replace `filename` with the name of the Prolog file, e.g., `acyclic_path.pl`. It will just load the program into the interpreter. To run the programs, details are given below.

## Programs

### 1. Farmer, Wolf, Goat, and Cabbage Puzzle Solver

**File Name:** `farmer_wolf_goat_cabbage_solver.pl`

**Purpose:** Solve the famous river crossing puzzle using depth-first and breadth-first search algorithms. Where a farmer has to cross a river with a wolf, a goat, and a cabbage. The boat can only carry the farmer and one of the other three items. The farmer cannot leave the wolf and the goat together, or the goat and the cabbage together, otherwise the wolf will eat the goat, or the goat will eat the cabbage unless the farmer is present. More description is given in the file. Is there any other way to solve this puzzle? This program finds that out.

**Execution Example:**

```prolog
?- depthFirstSearch.
```

or 

```prolog
?- breadthFirstSearch.
```
depending on which algorithm you want to use. More details are given in the file.

### 2. Minimum Cost Path Finder

**File Name:** `minimum_cost_path.pl`

**Purpose:** Find the minimum-cost path between two nodes in a graph and display the found path and its cost. More description is given in the file.

**Execution Example:**

```prolog
?- minPath(a,d, Path, Cost).
% The result will be-> Path = [a, b, c, d], Cost = 6.
```

### 3. Syllable Divider

**File Name:** `syllable_divider.pl`

**Purpose:** Teach children how to pronounce multisyllable words by dividing them into syllables. This was a fun program to write. More description is given in the file.

**Execution Example:**

```prolog
?- syllables(analog).
% The result will be-> ana-log.
```

### 4. Locate Indexes

**File Name:** `locate_indexes.pl`

**Purpose:** Read an integer and a list of integers. Locate the list of all positions of the integer in the list and return the resulting list.

### 5. Acyclic Path Finder

**File Name:** `acyclic_path.pl`

**Purpose:** Find an acyclic path (a node can appear in the path only once) between two nodes in a given graph. The path is represented as an ordered list of nodes from the start node to the goal node. You can change the graph by modifying `myGraph()`.

**Execution Example:**

```prolog
?- findPath(b, z, PathList).
% The result will be-> PathList = [b, c, z].
```


