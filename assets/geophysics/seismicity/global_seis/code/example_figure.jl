# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT	# Hide
seismicity(region="86/175/-25/33", size=(exp, [2 12], [3 9]), land=:lightbrown,
           ocean=:lightblue, starttime="2020-01-01", endtime="2022-12-31")
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * "." * "png"), joinpath(@OUTPUT, "example_8148593474960214475.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide