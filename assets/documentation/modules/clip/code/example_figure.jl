# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
plot("@tut_data.txt", fill=:red, marker=:circ, ms=2, region=(0,6,0,6), clip=[0 0; 5 1; 5 5], show=true)
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_17652575680732058358.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide