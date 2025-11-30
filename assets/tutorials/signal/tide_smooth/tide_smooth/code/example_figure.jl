# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT         # Hide

Dfinal = sample1d(Dl, T="2025-03-05T13:26:00/2025-03-07T13:24:05/60s");       # Hide
plot(D, legend= "Raw data")
plot!(Dfinal, lc=:red, lt=1, legend="Smoothed data", show=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_14401690758803194346.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide