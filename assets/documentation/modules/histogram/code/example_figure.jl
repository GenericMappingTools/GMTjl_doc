# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
histogram("@v3206_06.txt", bin=250, center=true, pen="0.5p", show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * ".png"), joinpath(@OUTPUT, "example_9882309136842291859.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide