1. Filter list pf psl blocks by query sequence id and sort them by qStart.<br />
Build a graph upon it where vertices are blocks and edges are constrcuted based on possible candidates of next vertices <br /> 
Candiate blocks are the closest next syntenic block and all blocks overlapping it (currently used).<br />
The goal is to find a set of paths covering DAG based on their maximal weight and most continuous of them. <br />
2. Search for a vertex with the maximal weight: <br />
  * the weight of each edge coming into the vertex i equals the length of the corresponding psl block
  * the weight of each vertex is initialized as infinity, then for each vertex A consider its possible next blocks (descendants) 
  and update weight of each descendant-candidate vertex B in case the weight of an edge coming into B + weight of the previous vertex A 
  is greater then weight of B. In case of update store the id of the previous vertex.
3. Find the vertex with maximal weight and trace back.
4. Remove the vertices that comprise the best path from the graph
5. If not all vertices are in some paths then go to 2.
