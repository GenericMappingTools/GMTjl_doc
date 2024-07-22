# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

pts = [[1 2 3;1 2 3;1 2 3][:] [1 1 1;2 2 2; 3 3 3][:]];
D = triplot(pts, noplot=true);
points = [2.4 1.2; 1.4 1.4];
ids = inwhichpolygon(points, D);

# Plot the triangulation and the query points.
plot(D)
plot!(D[ids[1]], fill=:grey)
plot!(D[ids[2]], fill=:green)
plot!(points, marker=:star, ms="12p", fill=:blue, show=true)
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_7803874889161507702.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide