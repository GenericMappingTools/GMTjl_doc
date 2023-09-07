# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
radar([10.5 20.5 30.6 40.9 46], axeslimts=[15, 25, 50, 90, 50],
      labels=["Spoons","Forks","Knifes","Dishes","Oranges"],
      annotall=true, marker=:circ, fill=true, show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * "." * "png"), joinpath(@OUTPUT, "example_10428633530349332120.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide