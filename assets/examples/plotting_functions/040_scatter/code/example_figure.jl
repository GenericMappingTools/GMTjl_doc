# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
scatter(TESTSDIR * "assets/iris.dat", xvar=1, yvar=2, hue="Species", xlabel=:auto, ylabel=:auto,
        legend=(pos=:TC, box=(pen=1, fill="gray95", shade=true, rounded=true)), show=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_17437611840198119774.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide