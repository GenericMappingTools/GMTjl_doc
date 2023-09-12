# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT

x,y = GMT.meshgrid(-10:10);
u = 2 .* x .* y;
v = y .^2 - x .^ 2;
U = mat2grid(u, x[1,:], y[:,1]);
V = mat2grid(v, x[1,:], y[:,1]);
r,a = streamlines(U, V);
plot(r, decorated=(locations=a, symbol=(custom="arrow", size=0.3), fill=:black, dec2=true), show=1)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * "." * "png"), joinpath(@OUTPUT, "example_1498074747434166940.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide