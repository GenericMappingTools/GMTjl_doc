# The true Hello World

\begin{examplefig}{}
```julia
using GMT
x = GMT.linspace(0, 2pi, 180);	y = sin.(x/0.2)*45;
coast(region=:global, proj=(name=:ortho, center=(300,15)), frame=:g,
      land=:navy, title="Hello Round World")
plot!(x*60, y, lw=1, lc=:red, marker=:circle, size=0.2,
      markeredgecolor=0, markerfacecolor=:cyan, show=true)
```
\end{examplefig}