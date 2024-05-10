# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
x = -2π:0.1:2π
lines(x, sin.(x), limits=(-2π, 2π, -1,1), lc="#56B4E9", lw=2, label="sin(x)",
      xaxis=(label="x",annot=5, grid=5), ylabel="f(x)", grid=(pen=(:red,:dash),), theme=("A2"))
lines!(x, cos.(x), lw=2, linestyle=:dash, legend=(label="cos(x)", pos=:BL), show=true)
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_15419422063187536479.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide