# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
subplot(grid=(3,2), dims=(panels=true, sizes=(("2i","4i"),("2.5i","5i","1.25i"))), row_axes=(left=true, parallel=true),
        col_axes=(bott=true,), margins=0, autolabel=(label=:A, vertical=true), title="Variable dimensions")
	basemap(region=(0,5,0,5),     frame=(fill=:pink,))
	basemap(region=(0,5,10,15),   frame=(fill=:cyan,),   panel=:next)
	basemap(region=(0,5,10,15),   frame=(fill=:lightgray,),   panel=:next)
	basemap(region=(10,15,0,5),   frame=(fill=:yellow,), panel=:next)
	basemap(region=(10,15,10,15), frame=(fill=:purple,), panel=:next)
	basemap(region=(10,15,10,15), frame=(fill=:orange,), panel=:next)
subplot(:show)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * "." * "png"), joinpath(@OUTPUT, "example_18072810986697530659.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide