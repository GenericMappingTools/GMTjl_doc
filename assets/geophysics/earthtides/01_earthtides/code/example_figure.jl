# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
D = earthtide(range="2022-07-07T/2022-07-08T/1m", location=(-82,9));	# hide
plot(D[:Time, :Vertical], lc=:red, lw=1, legend=:Vertical,
     title="Earth tide components (m) at Panama Cannal")
plot!(D[:Time, :East],  lc=:green, lw=1, legend=:East)
plot!(D[:Time, :North], lc=:blue,  lw=1, legend=:North, show=1)
end # hide
mv(joinpath(tempdir(), "GMTjl_tmp.png"), joinpath(@OUTPUT, "example_306883020804158512.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide