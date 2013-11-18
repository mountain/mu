mu: A Lisp with statastics on running state
============================================

Based on Michael Fogus' Lithp, we add running state statastics in the runtime,
and rename it to "mu", which means tiny. Same as Lithp, mu follow John
McCarthy's original Lisp.

Neil D. Jones, in his book, Computability and Complexity, exploited a method
to meansure time and space complexity by using a machine rooted from Lisp.

Also in the book, Algorithmic Information Theory, G. J. Chaitin introduce a
measure by using the length of a Lisp programs to represent a complexity.

mu add some statastics on running state:

* program size
* time usage: steps before finish of a running
* space usage: maximium length of the s-expression during running
* space-time usage: the total sum of the s-expression length during running

