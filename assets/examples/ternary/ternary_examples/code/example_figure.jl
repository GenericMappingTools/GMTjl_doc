# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
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
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * ".png"), joinpath(@OUTPUT, "example_11266880737500866102.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide