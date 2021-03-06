Inside/outside Status
---------------------

To determine if a point is inside, outside, or exactly on the boundary of a polygon
we need to balance the complexity (and execution time) of the algorithm with the
type of data and shape of the polygons. For any Cartesian data we use a non-zero
winding algorithm, which is quite fast. For geographic data we will also use this algorithm
as long as (1) the polygons do not include a geographic pole, and (2) the longitude extent
of the polygons is less than 360.  If this is the situation we also carefully adjust
the test point longitude for any 360 degree offsets, if appropriate. Otherwise,
we employ a full spherical ray-shooting method to determine a points status.
