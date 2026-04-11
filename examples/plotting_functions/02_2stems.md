# Stems

Create a stem plot of 50 data values between −2π and 2π. 

\begin{examplefig}{}
```julia
using GMT
Y = linspace(-2*pi,2*pi,50);
stem(Y, show=true)
```
\end{examplefig}


The same but now specify the set of x values for the stem plot. 

\begin{examplefig}{}
```julia
using GMT
Y = linspace(-2*pi,2*pi,50);
stem([Y Y], show=true)
```
\end{examplefig}


Two of them and with some variations.

\begin{examplefig}{}
```julia
using GMT
Y = linspace(-2*pi,2*pi,50);
stem(Y,[Y -Y], multicol=true, fill=true, ms="10p", nobaseline=true, ls=:DashDot, show=true)
```
\end{examplefig}
