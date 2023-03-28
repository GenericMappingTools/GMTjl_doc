- **p** or **view** or **perspective** : -- *view=(azim, elev)*\
   Default is viewpoint from an azimuth of 200 and elevation of 30 degrees.\
   Specify the viewpoint in terms of azimuth and elevation. The azimuth is the horizontal rotation about the z-axis as
   measured in degrees from the positive y-axis. That is, from North. This option is not yet fully
   expanded. Current alternatives are:
     - *view=??*\
        A full GMT compact string with the full set of options.
     - *view=(azim,elev)*\
        A two elements tuple with azimuth and elevation
     - *view=true*\
        To propagate the viewpoint used in a previous module (makes sense only in ``bar3!``)
   More at \myreflink{perspective}