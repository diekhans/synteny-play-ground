### Special cases in resolving synteny


**Duplications**

can be resolved unambiguously <br>
`Genome A chr1  1 2 3`<br>
`Genome A chr2  4 2 5`<br>
`Genome B chr3  1 2 3`<br>
`Genome B chr4  4 2 5`<br>

still can be resolved unambiguosly for 1 2 3 context<br>
what about the other pair (4 2 5 and 7 5 8)? <br>
`Genome A chr1  1 2 3`<br>
`Genome A chr2  4 2 5`<br>
`Genome B chr3  1 2 3`<br>
`Genome B chr4  7 5 8`<br>

if such case is even possible?<br>
anyway it doesn't look like synteny in all the contextes below<br>
`Genome A chr1  1 2 3`<br>
`Genome A chr2  4 2 5`<br>
`Genome B chr3  6 2 7`<br>
`Genome B chr4  8 5 9`<br>

One can be resolved, another one is a clear duplication<br>
`Genome A chr1  1 2 3`<br>
`Genome A chr2  4 2 5`<br>
`Genome B chr3  1 2 3`<br>

If 6 is small enough then synteny is continued<br>
`Genome A chr1  1 2 3`<br>
`Genome A chr2  4 2 5`<br>
`Genome B chr3  1 2 6 3`<br>
`Genome B chr4  4 2 5`<br>


###  Discussion

* A synteny is define as a contiguously aligned region in two genomes with indels
  and inversions of no more than 1000bp.
* The pairwise alignments produce by HAL (PSL records) chain the blocks, however this
  does not necessary match the desired definition of synteny.
* PSL blocks maybe fragmented by HAL due to fragmentation in other genomes.
* Duplication ares represented in multiple PSL records, as PSL only represents
  linear increasing alignments.


### Algorithm

Synteny algorithm generates putative synteny blocks between to of the extant
species from a HAL alignment.

1. Use halLiftover to generate PSLs covering the entire genome or a test region.
2. Split all PSL into a single set of gapless blocks, each block represented by
   pairs of query/target tuples of equal length.  Strand-specific coordinates for the
   blocks are used, as this makes the dynamic programming easier:<br>
       `(qname qstrand qstart qend)`<br>
       `(tname tstrand tstart tend)`
3. Partition blocks into lists of blocks that could possibly contain syntenic blocks.
   This is referred to as a _synteny pool_.
   These have the same set of query and target sequences and strands and are indexed by<br>
   `(qname qstrand tname tstrand)`
5. Sort each _synteny pool_ by qstart.
4. Define zero of more synteny block for each _synteny pool_:
   1. xxx
   



### Thinking
[Longest increasing subsequence algorithm](https://en.wikipedia.org/wiki/Longest_increasing_subsequence)
