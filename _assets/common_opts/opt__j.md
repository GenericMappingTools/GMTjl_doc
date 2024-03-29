- **j** or **metric** or **spherical_dist** or **spherical** : -- *metric=greatcirc* or *spherical=:flat* or *spherical=:ellipsoidal*\
    Determine how spherical distances are calculated in modules that support this [Default is `spherical=:greatcirc`].
    GMT has different ways to compute distances on planetary bodies:

    - spherical=:greatcirc to perform great circle distance calculations, with parameters such as distance 
      increments or radii compared against calculated great circle distances [Default is `spherical=:greatcirc`].

    - spherical=:flat to select Flat Earth mode, which gives a more approximate but faster result.

    - spherical=:ellipsoidal to select ellipsoidal (or geodesic) mode for the highest precision 
      and slowest calculation time.

    Note: All spherical distance calculations depend on the current ellipsoid (`PROJ_ELLIPSOID`),
    the definition of the mean radius (`PROJ_MEAN_RADIUS`), and the specification of latitude type
    (`PROJ_AUX_LATITUDE`). Geodesic distance calculations is also controlled by method (`PROJ_GEODESIC`).
