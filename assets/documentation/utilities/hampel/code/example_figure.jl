# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

t = (1:50) / 10;
x = [1:2:40; 5t + (@. 6cos(t + 0.5(t)^2)); fill(40,20)];
x[12] = -10; x[50:52] .= -12; x[79:82] .= [-5, 50, 55, 0];
m = hampel(x, 4, threshold=0);
y = hampel(x, 4);

plot(x, marker=:point, mc=:blue, lc=:blue, label="Original", xlabel="k", ylabel="x_k")
scatter!(m, ms="2p", mc=:red, MarkerEdgeColor=true, label="Median filter")
scatter!(y, ms="2p", mc=:green, MarkerEdgeColor=true, label="Hampel filter", show=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_3649320973332272706.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide