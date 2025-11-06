# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
x = 0:0.01:20;
y1 = 200 * exp.(-0.05x) .* sin.(x);
y2 = 0.8 * exp.(-0.5x)  .* sin.(10x);
plotyy([x[:] y1[:]], [x[:] y2[:]], title="Vibrating dishes",
       ylabel=:Knifes, xlabel="2000 Forks", seclabel=:Spoons, show=1)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_998738906292174928.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide