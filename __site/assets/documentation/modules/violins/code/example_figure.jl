# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
vvv = [[randn(50), randn(30)], [randn(40), randn(48), randn(45)], [randn(35), randn(43)]];
violin(vvv, fill=true, boxplot=true, separator=(:red, :dash), scatter=true, outliers=true, show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_tmp.png"), joinpath(@OUTPUT, "example_10506072654613455058.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide