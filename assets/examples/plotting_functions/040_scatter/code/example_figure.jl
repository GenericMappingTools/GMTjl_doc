# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
scatter(getpath4docs("iris.dat"), xvar=1, yvar=2, hue="Species", xlabel=:auto, ylabel=:auto,
        legend=(pos=:TC, box=(pen=1, fill="gray95", shade=true, rounded=true)), show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_tmp.png"), joinpath(@OUTPUT, "example_9014346360678461545.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide