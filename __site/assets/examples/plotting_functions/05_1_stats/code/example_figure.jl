# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
D = gmtread(getpath4docs("iris.dat"));
plot(D, xvar=1, yvar=2, hue="Species", xlabel=:auto, ylabel=:auto, linefit=true,
     band_ci=true, legend=true, show=1)
end # hide
mv(joinpath(tempdir(), "GMTjl_tmp.png"), joinpath(@OUTPUT, "example_1252949028278191020.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide