# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
resetGMT() # hide

dateline = [180 0; 180 -90];
point = [147.21667 -42.8 6000]

R = gmtinfo("@oz_quakes_24.txt", inc=10);
coast(region=R.text[1][3:end], land=:tan, water=:darkblue, shore=(:thin,:white),
      area=500, frame=(axes=:WeSn, annot=20, ticks=10, grid=10), proj=:Mercator)
plot!("@oz_quakes_24.txt", marker=:circle, ms=0.07, fill=:red)
t = gmtselect("@oz_quakes_24.txt", dist2line=(line=dateline, dist="1000k"), mask="k/s",
              dist2pt=(pts=point, dist="3000k"), colinfo=:g, reverse=:l)
plot!(t, marker=:circle, ms=0.07, fill=:green)

plot!(point, marker="Ellipse-", ml=(:thick, :white))
text!(mat2ds(point, "Hobart"), font=(14,"Helvetica-Bold",:white),
      justify=:LT, offset=(0.25, 0.25))
plot!(point, MarkerLine=(:fat, :white), marker=:plus, ms=0.4)
plot!(dateline, pen=(:thick, :white), straight_lines=true, show=1)
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_2832903023374150160.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide