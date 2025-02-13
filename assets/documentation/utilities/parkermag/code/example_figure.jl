# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

m = zeros(Float32, 64,64);  m[32:40,32:40] .= 10;
h = fill(-2.0f0, 64,64);
Gm = mat2grid(m, hdr=[30., 30.32, 30., 30.32]);
Gh = mat2grid(h, hdr=[30., 30.32, 30., 30.32]);
f3d = parkermag(Gm,  Gh, "dir", year=2000, thickness=1, pct=0);
m3d = parkermag(f3d, Gh, "inv", year=2000, thickness=1, pct=0);

grdimage(f3d, figsize=6, title="Field (nT)", colorbar=true)
C = makecpt(m3d);		# Need a different colormap for the magnetization
grdview!(f3d, figsize=6, zsize=4, view=(210, 40), title="Magnetization (A/m)", cmap=C, surf=:image, B=:za, xshift=8, show=true)
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_7505024757121987360.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide