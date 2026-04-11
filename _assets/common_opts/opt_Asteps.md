- **A** or **steps** : -- *steps=true* **|** *steps=:meridian|:parallel|:x|:y|:r|:theta*\
   By default, geographic line segments (as indicated for example by the **colinfo** option)
   are drawn as great circle arcs. To draw them as straight lines, use the **steps=true**.
   Alternatively, use **steps=:meridian** to draw the line by first following a meridian,
   then a parallel. Or append **steps=:parallel** to start following a parallel, then a meridian.
   (This can be practical to draw a line along parallels, for example). For Cartesian data,
   points are simply connected, unless you use **steps=:x** or **steps=:y** to draw stair-case
   curves that whose first move is along *x* or *y*, respectively. If your Cartesian data are
   polar (*theta*, *r*), use **steps=:t** or **steps=:r** to construct stair-case paths whose
   first move is along *theta* or *r*, respectively.