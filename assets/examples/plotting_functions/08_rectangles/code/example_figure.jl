# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
rect = [0.5 0.5; 0.5 7; 2.5 7; 2.5 0.5; 0.5 0.5];
plot(rect, region=[0 10 0 10], lw=0.5, fill=:blue, axes=:a, aspect=:equal)
plot!([3 0].+rect, lw=1, ls="--", fill=:blue, transparency=30)
plot!([6 0].+rect, lw=2, lc=:red, fill=:blue, transparency=70, show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * "." * "png"), joinpath(@OUTPUT, "example_16832277042100198791.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide