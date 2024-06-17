# Mosaicing from Web tiles servers

The \myreflink{mosaic} function let us download map tiles from Web Map Tiles servers given a BoundingBox limits
in geographical coordinates. The function has many use options and we will show here the result of using
some of them. By default it downloads images from the Bing servers but data from OpenStreetMap, Google, ESRI, 
Nimbo and other providers can be accessed as well.

To start with we create an image over Iberia using only default values. _i.,e._ Bing images and image resolution
(that is, the zoom level) computed automatically for that area.

\begin{examplefig}{}
```julia
using GMT

I = mosaic([-10, 3.5], [36.0, 44])
viz(I)
```
\end{examplefig}

If we want instead a map from OpenStreetMap, we need to specify that via the `provider` option. To know more
about the `provider` usage, see the manual of the ``getprovider`` function (e.,g._ type ``? getprovider``
in the Julia command window.)

\begin{examplefig}{}
```julia
using GMT

I = mosaic([-10, 3.5], [36.0, 44], provider=:OSM)
viz(I)
```
\end{examplefig}

A question that will often arise is: _but what if I want to control the resolution, what zoom level should I choose?_.
Well, the answer is using trial an error or help yourself a bit and make a figures with the tiles limits. For that we
use the `mesh` option and plot the tiles limits only.

\begin{examplefig}{}
```julia
using GMT

D = mosaic([-10, 3.5], [36.0, 44], mesh=true)
viz(D, coast=true)
```
\end{examplefig}

Typing `D[1].comment` shows that the default zoom level for that area is 8

```julia
julia> D[1].comment
1-element Vector{String}:
 "Zoom level = 8"`
```

So, if we want a twice resolution map we would do (for the first example). Mind you that each increase of one unit
in the zoom level duplicates the resolution and multiply by 4 the number of download tiles.

```julia
I = mosaic([-10, 3.5], [36.0, 44], zoom=9)
viz(I)
```

So, we saw how to make maps over large areas, but when it comes to smaller areas it becomes more (or much more)
cumbersome to find the appropriate map limits. That is when the \myreflink{geocoder} function comes into our rescue.
Basically, it takes as input an address and return a \myreflink{GMTdataset} with information on that place, and in
particular its coordinates and BoundingBox.

The syntax is very simple. Just give an address that it understands. It can be a general address like:

```julia
D = geocoder("Big Island Hawaii, USA")

Attribute table
┌────────────┬──────────────┬────────┬────────────────┬────────────┬───────┬────────────────────┬──────────────┬────────┬──────────┬───────
│        lat │ country_code │   type │ ISO3166-2-lvl4 │ place_rank │ class │         importance │          lon │  state │ osm_type │ addr ⋯
├────────────┼──────────────┼────────┼────────────────┼────────────┼───────┼────────────────────┼──────────────┼────────┼──────────┼───────
│ 19.5895548 │           us │ island │          US-HI │         17 │ place │ 0.5331294636028157 │ -155.4486983 │ Hawaii │ relation │      ⋯
└────────────┴──────────────┴────────┴────────────────┴────────────┴───────┴────────────────────┴──────────────┴────────┴──────────┴───────
                                                                                                                          8 columns omitted
BoundingBox: [-155.4486983, -155.4486983, 19.5895548, 19.5895548]
Global BoundingBox: [-156.0618813, -154.806698, 18.9106939, 20.2685021]
PROJ: +proj=longlat +datum=WGS84 +units=m +no_defs

1×2 GMTdataset{Float64, 2}
 Row │      Lon      Lat
─────┼───────────────────
   1 │ -155.449  19.5896
```

Since this still represents a somewhat large area we will use the reported BoundingBox via the `bbox` option. So, to create
an image of the Big Island, Hawaii we do:

\begin{examplefig}{}
```julia
using GMT

D = geocoder("Hawaii Big Island, USA");
I = mosaic(D, bbox=true);
viz(I)
```
\end{examplefig}

But when it comes to image real small areas the BoundingBox trick no longer works because it normally is ... too small.
We must than use the alternative, which is to specify the number of neighbor tiles around the obtained address. And here
we must specify the zoom level manually.

Example of a high-resolution map over the S. Peters Piazza, Vatican.

\begin{examplefig}{}
```julia
using GMT

D = geocoder("Piazza San Pietro, Vatican");
I = mosaic(D, zoom=19, neighbors=7);
viz(I)
```
\end{examplefig}

But not all small and beautifull places are geocoded. To see the lovely _Fish Island_ in Croatia, we still have to provide
the central coordinates (or the right BoundingBox).

\begin{examplefig}{}
```julia
using GMT

I = mosaic(13.71862, 44.939234, zoom=18, provider=:Google, neighbors=[7,5]);
viz(I, proj=:guess)
```
\end{examplefig}
