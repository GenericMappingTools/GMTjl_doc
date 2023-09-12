# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT

D = linearfitxy([0.0, 0.9, 1.8, 2.6, 3.3, 4.4, 5.2, 6.1, 6.5, 7.4], [5.9, 5.4, 4.4, 4.6, 3.5, 3.7, 2.8, 2.8, 2.4, 1.5],
                 sx = 1 ./ sqrt.([1000., 1000, 500, 800, 200, 80,  60, 20, 1.8, 1]), sy=1 ./
                 sqrt.([1., 1.8, 4, 8, 20, 20, 70, 70, 100, 500]));
plot(D, linefit=true, band_ab=true, band_CI=true, ellipses=true, show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * "." * "png"), joinpath(@OUTPUT, "example_8940533420192215870.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide