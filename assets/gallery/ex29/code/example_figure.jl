# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
resetGMT() # hide

# Make Mars PROJ_ELLIPSOID given their three best-fitting axes:
a = 3399.472; b = 3394.329; c = 3376.502;
Gproj_ellipsoid = gmt("grdmath -Rg -I4 -r X COSD " * "$a" * " DIV DUP MUL X SIND " * "$b" * 
                      " DIV DUP MUL ADD Y COSD DUP MUL MUL Y SIND " * "$c" * " DIV DUP MUL ADD SQRT INV =")
#  Do both Parker and Wessel/Becker solutions (tension = 0.9975)
Gmars  = greenspline("@mars370.txt", region=:global360, inc=4, reg=true,  grid=true, mode=4, splines=:p)
Gmars2 = gmt("greenspline -R? @mars370.txt -D4 -Sq0.9975 -G", Gproj_ellipsoid);
# Scale to km and remove PROJ_ELLIPSOID
Gmars  = Gmars  / 1000 - Gproj_ellipsoid
Gmars2 = Gmars2 / 1000 - Gproj_ellipsoid
mars_cpt = makecpt(cmap=:rainbow, range=(-7,15));

grdimage(Gmars2, region=:global360, shade=(azim=45, norm="e0.75"),
frame=(axes=:Wsne, annot=30, grid=30), proj=(name=:Hammer, center=0), xshift=2)
grdcontour!(Gmars2, cont=1, annot=5, labels=(line="z+/z-",))
plot!("@mars370.txt", marker=:circle, ms=0.1, fill=:black)
text!(mat2ds([0 90], "b)"), noclip=true, offset=(-9, -0.5), font=(14,"Helvetica-Bold"), justify=:LB)

grdimage!(Gmars, frame=:same, shade=(azim=45, norm="e0.75"), yshift=9, dpi=200)
grdcontour!(Gmars, cont=1, annot=5, labels=(line="z+/z-",))
plot!("@mars370.txt", marker=:circle, ms=0.1, fill=:black )
colorbar!(pos=(anchor=:BC, offset=(0,0.4), length=(12, 0.25), horizontal=true),
          shade=true, frame=(annot=2, ticks=1), ylabel=:km)
text!(text_record([0 90], "a)"), noclip=true, offset=(-9, -0.5),
      font=(14,"Helvetica-Bold"), justify=:LB, show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_9876273883333797457.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide