# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
# Create a GMTdataset with named columns.
x = linspace(0, 4*pi, 50);
D = mat2ds([x sin.(x) cos.(x)], colnames=["x", "sin(x)", "cos(x)"]);
stairs(D, xvar=:x, yvar=["sin(x)", "cos(x)"], lw=0.5, marker=:circ, show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * "." * "png"), joinpath(@OUTPUT, "example_14131935523999683749.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide