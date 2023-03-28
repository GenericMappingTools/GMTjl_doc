# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
topo = makecpt(color=:rainbow, range=(1000,5000,500), continuous=true);
grdview("@tut_relief.nc", proj=:Mercator, zsize=1, shade=(azim=100, norm="e0.8"), view=(135,30),
        frame=:a, Q="i100", show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_tmp.png"), joinpath(@OUTPUT, "example_8930495291843333046.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide