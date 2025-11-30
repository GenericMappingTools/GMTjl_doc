# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

b = 0:0.01:0.3
c1 = (1 .- b).^3 .- 0.7^3
c2 = (1 .- 2*b).^2 .- 0.4^2

# Generate the coordinates of two lines.
t1 = tern2cart([(1 .- b .- c1) b c1])    # Note that GMT.jl function expects a Mx3 matrix
t2 = tern2cart([(1 .- b .- c2) b c2])

ternary(labels=("A", "B", "C"))

plot!(t1, lw=2, lc=:red, ls="line& (a) &")	# line style -> fancy stuff
plot!(t2, lw=2, lc=:blue)
text!(tern2cart([0.3 0.4 0.3]), text="Umbilicus", font=18, show=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_4844438575782619428.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide