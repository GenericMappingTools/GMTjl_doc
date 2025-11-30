# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
x = GMT.linspace(0, 2pi, 180);	y = sin.(x/0.2)*45;
coast(region=:global, proj=(name=:ortho, center=(300,15)), frame=:g,
      land=:navy, title="Hello Round World")
plot!(x*60, y, lw=1, lc=:red, marker=:circle, size=0.2,
      markeredgecolor=0, markerfacecolor=:cyan, show=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_9050909409146819876.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide