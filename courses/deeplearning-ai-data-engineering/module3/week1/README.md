# Week 1: Graph Databases and Vector Search with Neo4j

## Assignment: Cypher Query Language & Air Routes Graph
**Status**: ✅ Completed  
**Date**: January 15, 2026

## Overview
Learned Cypher query language to query highly connected data in Neo4j graph database. Worked with Air Routes network dataset containing airports, countries, continents, and routes.

## Technologies Used
- **Neo4j**: Graph database
- **Cypher**: Graph query language (OpenCypher standard)
- **Python Libraries**:
  - `neo4j`: Python driver for Neo4j
  - `python-dotenv`: Environment variable management
  - `IPython`: Display utilities

## What We Accomplished

### 1. Graph Database Fundamentals
- Understood nodes, relationships, and paths
- Learned Cypher pattern matching syntax
- Explored directed vs undirected relationships

### 2. Basic CRUD Operations (Ex 1-13)

#### Read Operations
- **Ex 1**: Count nodes by label (Continent, Airport, Country)
- **Ex 2**: Match Country nodes with LIMIT
- **Ex 3**: Count all directed relationships
- **Ex 4**: Count relationships by TYPE (Route, Contains)
- **Ex 5**: Get Airport node properties
- **Ex 6**: Get Route relationship properties

#### Filtering
- **Ex 7**: WHERE clause for routes > 1000 miles

#### Create Operations
- **Ex 8**: CREATE Route relationship between CLR and BWC airports

#### Update Operations
- **Ex 9**: UPDATE BWC airport elevation using SET
- **Ex 10**: Query to verify property update

#### Delete Operations
- **Ex 11**: DELETE CLR airport with relationships
- **Ex 12**: DELETE BWC airport
- **Ex 13**: Verify both airports deleted

### 3. Advanced Queries (Ex 14-16)

#### Aggregation & Counting
- **Ex 14**: Count direct routes from LaGuardia (LGA) airport
  - Used DISTINCT count(r) for accurate route counting

#### WITH Clause for Chaining
- **Ex 15**: Find US airports with only 1 route
  - Used WITH clause to carry aggregation results
  - Combined count() with WHERE filtering

#### Multi-Hop Path Queries
- **Ex 16**: Find paths from Columbia (COU) to Miami (MIA)
  - Used `[:Route*..2]` syntax for up to 2 hops
  - Discovered routes with 0-1 intermediary airports

### 4. Vector Search (Ex 17 - Optional)
- Loaded airport embeddings from CSV
- Created vector index on embedding property
- Performed similarity search using cosine distance
- Found similar airports based on vector representations

## Key Cypher Concepts Learned

### Pattern Matching
```cypher
()              # Any node
(n)             # Node assigned to variable n
(n:Airport)     # Node with label Airport
[r:Route]       # Relationship with label Route
-->             # Directed relationship
--              # Undirected relationship
```

### CRUD Syntax
```cypher
MATCH           # Find patterns
WHERE           # Filter results
RETURN          # Specify output
CREATE          # Create nodes/relationships
SET             # Update properties
DELETE          # Remove nodes/relationships
WITH            # Chain query parts
LIMIT           # Limit results
```

### Aggregation Functions
- `count()`: Count elements
- `avg()`: Average values
- `properties()`: Get all properties
- `labels()`: Get node labels
- `TYPE()`: Get relationship type

### Advanced Features
- `DISTINCT`: Remove duplicates
- `shortestPath()`: Find shortest path
- `*..N`: Variable length paths
- Vector indexes for similarity search

## Dataset Schema

```
Continent --Contains--> Country --Contains--> Airport
Airport --Route--> Airport
```

**Node Types:**
- Continent (7 nodes)
- Country (237 nodes)
- Airport (3504 nodes)

**Relationship Types:**
- Route (50,637 directed, 101,274 total)
- Contains (7,008 directed, 14,016 total)

## File Structure
```
week1/
├── C3_W1_Assignment.ipynb    # Main assignment notebook (all exercises complete)
├── src/
│   ├── env.template          # Credential template
│   └── env                   # Actual credentials (gitignored)
├── images/                   # Assignment diagrams
│   ├── air-routes-graph.png
│   ├── AWSLogout.png
│   ├── neo4j-cmd.png
│   └── neo4j-cmd-run.png
├── scripts/                  # Utility scripts
│   └── fix_notebook.py       # One-time notebook fix script
└── README.md                 # This file
```

## Running the Code

### Setup in Coursera Environment
```bash
cd /home/coder/project

# Download notebook
curl -o C3_W1_Assignment.ipynb https://raw.githubusercontent.com/anix-lynch/deeplearning-ai-data-engineering-certificate/main/module3/week1/C3_W1_Assignment.ipynb

# Download setup files
mkdir -p src images scripts
curl -o src/env.template https://raw.githubusercontent.com/anix-lynch/deeplearning-ai-data-engineering-certificate/main/module3/week1/src/env.template

# Configure Neo4j connection
# Get Neo4j DNS from AWS CloudFormation Outputs
# Update src/env with Neo4jDNSConnection value (without port)
# Use credentials: neo4j / adminneo4j
```

### Local Setup
```bash
# Install dependencies
pip install neo4j python-dotenv ipython

# Configure Neo4j connection
cp src/env.template src/env
# Edit src/env with Neo4j DNS from AWS CloudFormation
```

### Execute Notebook
```bash
jupyter notebook C3_W1_Assignment.ipynb
```

### Neo4j Connection
1. Get Neo4j DNS from AWS CloudFormation Outputs
2. Update `src/env` with `Neo4jDNSConnection` value (without port)
3. Use credentials: `neo4j` / `adminneo4j`

## Key Takeaways

### Graph Databases vs Relational
- **Relationships are first-class citizens** in graph DBs
- **Traversal queries** are more natural and performant
- **Pattern matching** is more intuitive than JOINs
- **Schema flexibility** for evolving data models

### When to Use Graph Databases
- Highly connected data (social networks, routes, recommendations)
- Relationship-heavy queries (shortest path, network analysis)
- Real-time recommendations
- Fraud detection patterns
- Knowledge graphs

### Cypher vs SQL
- Cypher uses ASCII art for patterns: `(a)-[:ROUTE]->(b)`
- More declarative for graph traversals
- Built-in graph algorithms (shortestPath, etc.)
- OpenCypher is becoming a standard across graph DBs

## Notes
- Neo4j supports ACID transactions
- Vector search enables ML/AI integration
- AWS Neptune also supports OpenCypher
- Exercise 17 (vector index) is optional/ungraded

## Next Steps
- Week 2: Data transformation with graph queries
- Week 3: Advanced graph algorithms
- Week 4: Production graph database deployment
