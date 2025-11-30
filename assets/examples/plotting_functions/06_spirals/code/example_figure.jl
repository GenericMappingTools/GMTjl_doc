# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
angle = 137.5;	# Play with this angle between [137.0 138.0]. Amazing the effect, no?
alfa = 2pi * angle / 360;
n_seeds = 1500;
seeds = 0:n_seeds;
r = sqrt.(seeds);
ϕ = alfa * seeds;
C = makecpt(range=(1,sqrt(n_seeds),1), cmap=:buda);	# Color map to paint the seeds
scatter(r .* cos.(ϕ), r .* sin.(ϕ), marker=:point, cmap=C, zcolor=r,
        frame=(fill=20,), aspect=:equal, show=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_6047936830520035738.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide