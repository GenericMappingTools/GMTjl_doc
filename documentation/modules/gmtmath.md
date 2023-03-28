# gmtmath

Reverse Polish Notation (RPN) calculator for data tables

Description
-----------

**gmtmath** will perform operations like add, subtract, multiply, and
numerous other operands on one or more table data files or constants using
[Reverse Polish Notation (RPN)](https://en.wikipedia.org/wiki/Reverse_Polish_notation)
syntax.  Arbitrarily complicated expressions may therefore be evaluated; the
final result is written to an output file [or standard output]. Data
operations are element-by-element, not matrix manipulations (except
where noted). Some operators only require one operand (see below). If no
data tables are used in the expression then options |-T|, |-N| can
be set (and optionally **-bo** to indicate the
data type for binary tables). If STDIN is given, the standard input will
be read and placed on the stack as if a file with that content had been
given on the command line. By default, all columns except the "time"
column are operated on, but this can be changed (see |-C|).
Complicated or frequently occurring expressions may be coded as a macro
for future use or stored and recalled via named memory locations.

OK, but RPN is quite painfull to master for other than simple expressions and for it the normal
Julia operators are much easier to use. However, there are many operators that are handy and
already programmed or even kind of unique like for example **XYZ2LAB** that converts x,y,z triplets to l,a,b triplets
to coastlines. So, there is still interest in **gmtmath** but due to its nature it was nor wrapped
into a vebose version and for using it one must use the \myreflink{Monolithic} mode.

For the full manual, consult the main GMT [gmtmath manual](https://docs.generic-mapping-tools.org/dev/gmtmath.html)
