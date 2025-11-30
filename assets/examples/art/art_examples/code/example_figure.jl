# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
function mandelbrot(z)
    w = z
    for n in 1:74
        abs2(w) < 4 ? w = w^2 + z : return n
    end
    75
end
x, y = range(-0.65, -0.45; length=1600), range(0.51, 0.71; length=1600);
imshow(-log.(mandelbrot.(x' .+ y .* im)), frame=:none, title="Mandelbrot painting", figsize=8)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_12871770366070556564.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide