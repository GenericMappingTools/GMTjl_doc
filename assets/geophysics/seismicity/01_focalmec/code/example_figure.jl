# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
resetGMT()	# hide

# Background map
grdimage("@earth_relief", region=[-74,-59,5,15], proj=:guess, figsize=10, shade=true)
coast!(shorelines=true, borders=((type=1, pen=0.8),(type=2, pen=0.1)), map_scale="-68.5/7.0/7.0/200")

# Epicenters
plot!(GMT.TESTSDIR * "mff_bb.txt", marker=:circ, ms=0.1, fill=:yellow, markerline=:black)
text!(txt="Mar Caribe", x=-68, y=13.5, font=(15, "Helvetica-Bold", :white), justify=:LM)

# Focal mechanisms
meca!(GMT.TESTSDIR * "mff_bb.txt", CMT=(scale=0.4, font=6), offset=true, fill=:black, show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * "." * "png"), joinpath(@OUTPUT, "example_633232793994698976.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide