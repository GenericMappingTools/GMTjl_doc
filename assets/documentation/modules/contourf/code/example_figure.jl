# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT

	d = [0 2 5; 1 4 5; 2 0.5 5; 3 3 9; 4 4.5 5; 4.2 1.2 5; 6 3 1; 8 1 5; 9 4.5 5];
	contourf(d, limits=(-0.5,9.5,0,5), pen=0.25, labels=(line=(:min,:max),), show=1)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * ".png"), joinpath(@OUTPUT, "example_7859536397131974778.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide