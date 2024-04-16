# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT

G = grdcut("@earth_relief_30s", region=(-108,-103,35,40));

# Compute the distances to Denver (here we need to use the terse syntax)
Gr = grdmath("-R? -104.9903 39.7392 SDIST", G);

# Mask distances > 100 km
Ginside = Gr < 100;

# Compute gradients along two directions to use in shading.
Gint1 = grdgradient(G, azim=90, norm=(cauchy=true, amp=1));
Gint2 = grdgradient(G, azim=45, norm=(cauchy=true, amp=1));

# Combine the gradients
Gint = Gint2 * 0.5 + Gint1 + Ginside - 0.5;

# View the result
C = makecpt(range=(1000,4000));
grdview(G, shade=Gint, proj=:merc, zsize=1, view=(155,25), colormap=C, surftype=:image, show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_3642176120632087226.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide