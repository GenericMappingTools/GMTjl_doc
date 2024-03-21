# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
clip([0 0; 5 1; 5 5], region=(0,6,0,6), figscale=2.5, pen=(1,:blue))
plot!("@tut_data.txt", fill=:red, marker=:circ, ms=2, region=:same)
clip!(endclip=true, frame=:same, show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_16310888906255421354.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide