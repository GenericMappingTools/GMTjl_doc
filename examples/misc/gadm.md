# GADM

### Plot countries administrative units

We start by download and save in cache the geopackage file with Mozambique data.
Note, a downloading message will be printed only once, and in this case it will say

*Downloading geographic data for country MOZ provided by the https://gadm.org project. It may take a while.
The file gadm36_MOZ.gpkg (after uncompressing) will be stored in your home dir/.gmt/cache*

\begin{examplefig}{}
```julia
using GMT
mozambique = gadm("MOZ");

imshow(mozambique, proj=:guess, title="Moçambique")
```
\end{examplefig}


Next let us add all the provincies of Moçambique. For that we'll use the country code as parent and
the option `children=true` to indicate that we want all provincies boundaries.

\begin{examplefig}{}
```julia
using GMT
mozambique = gadm("MOZ", children=true);
imshow(mozambique, proj=:guess, title="Provinces of Moçambique")
```
\end{examplefig}


To know the provinces names such that we can use them individually for example, we use the option `names=true`

```julia
gadm("MOZ", names=true)
```
```
"Cabo Delgado"
"Gaza"
"Inhambane"
"Manica"
"Maputo"
"Maputo City"
"Nampula"
"Nassa"
"Sofala"
"Tete"
"Zambezia"
```

Now we can plot only one of those provinces and its children

\begin{examplefig}{}
```julia
using GMT
CD = gadm("MOZ", "Cabo Delgado", children=true);
imshow(CD, proj=:guess, title="Cabo Delgado")
```
\end{examplefig}