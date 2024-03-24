# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT

x = 10.0:110;
y = (x / 50) .^2 .+ x/60 .+ 4 .+ cos.(2pi * x/25) .+ 0.25 * rand(length(x));
D = trend1d([x y], model=((polynome=2,),(fourier=1,single=true, origin=0, length=25)), out=:xm);
plot(x,y, region=(0,120,0,15), marker=:point)
plot!(D, lc=:blue, show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_8388350272490064278.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide