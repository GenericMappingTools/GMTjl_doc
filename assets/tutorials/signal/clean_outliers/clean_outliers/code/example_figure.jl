# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT   # Hide
import Random   # Hide
Random.seed!(1243);   # Hide
x = -50.0:50;   # Hide
y = 4 * (x / 50) .^3 .+ 3 .+ 0.25 * rand(length(x));  # Hide
y[[15, 40, 90]] = [3, 4, 3];  # Hide

D2 = trend1d([x y], model=((polynome=0,single=1),(polynome=3,single=true)), out=:xr);
viz(D2, figsize=(15, 5))
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_6582988167620222446.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide