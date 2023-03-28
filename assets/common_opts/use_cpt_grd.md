- **C** or **color** or **cmap** or **colorap** or **colorscale** : -- *color=cpt*\
   Where *cpt* is a *GMTcpt* type or a cpt file name (for *grd\_z* only). Alternatively, supply the name of
   a GMT color master dynamic CPT [turbo] to automatically determine a continuous CPT from the grid's z-range;
   you may round up/down the z-range by adding **+i** *zinc*. Yet another option is to specify
   *color="color1,color2 [,color3 ,...]"* or *color=((r1,g1,b1),(r2,g2,b2),...)* to build a linear continuous
   CPT from those colors automatically. In this case *color1* etc can be a (r,g,b) triplet, a color name, or
   an HTML hexadecimal color (e.g. #aabbcc ) (see \myreflink{Setting color}). When not explicitly set, but a
   color map is needed, we will either use the current color map, if available (set by a previous call to
   *makecpt*), or the default *turbo* color map.
