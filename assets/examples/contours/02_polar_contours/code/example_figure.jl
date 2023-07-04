# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
GMT.resetGMT()  # hide

G = grdmath("-R0/360/2/4 -I6/0.1 X 4 MUL PI MUL 180 DIV COS Y 2 POW MUL");
grdcontour(G, proj=:polar, frame=(annot=30, axes=:Ns, fill=:honeydew),
           cont=2, smooth=4, par=(FORMAT_GEO_MAP="+ddd",), show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * ".png"), joinpath(@OUTPUT, "example_14089514837764860729.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide