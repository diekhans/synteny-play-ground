### Special cases in resolving synteny


**Duplications**

can be resolved unambiguously <br />
`Genome A chr1  1 2 3`<br />
`Genome A chr2  4 2 5`<br />
`Genome B chr3  1 2 3`<br />
`Genome B chr4  4 2 5`<br />

still can be resolved unambiguosly for 1 2 3 context<br />
what about the other pair (4 2 5 and 7 5 8)? <br />
`Genome A chr1  1 2 3`<br />
`Genome A chr2  4 2 5`<br />
`Genome B chr3  1 2 3`<br />
`Genome B chr4  7 5 8`<br />

if such case is even possible?<br />
anyway it doesn't look like synteny in all the contextes below<br />
`Genome A chr1  1 2 3`<br />
`Genome A chr2  4 2 5`<br />
`Genome B chr3  6 2 7`<br />
`Genome B chr4  8 5 9`<br />

One can be resolved, another one is a clear duplication<br />
`Genome A chr1  1 2 3`<br />
`Genome A chr2  4 2 5`<br />
`Genome B chr3  1 2 3`<br />

If 6 is small enough then synteny is continued<br />
`Genome A chr1  1 2 3`<br />
`Genome A chr2  4 2 5`<br />
`Genome B chr3  1 2 6 3`<br />
`Genome B chr4  4 2 5`<br />


