# PCAs 

## Examples


The classic analysis of the _Iris_ dataset.

\begin{examplefig}{}
```julia
using GMT

biplot(TESTSDIR * "iris.dat", show=true)
```
\end{examplefig}

Plot a 6 cm fig with included observarion numbers.

\begin{examplefig}{}
```julia
using GMT

biplot(TESTSDIR * "iris.dat", figsize=6, obsnumbers=true, show=true)
```
\end{examplefig}
