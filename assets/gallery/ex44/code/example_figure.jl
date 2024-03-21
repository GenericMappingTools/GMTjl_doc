# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
resetGMT() # hide

coast(region="110E/170E/44S/9S", proj=:merc, figsize=15, shore=:faint, borders=(type=2, pen=1),
      DCW=(country="AU", fill=:bisque), land=:brown, water=:azure1)
basemap!(inset=(inside=true, anchor=:TR, width=3.8, offset=(0.4, 0.25), save="xx000.dat"),
         box=(fill=:white, pen=1, clearance=0.1, shaded=true))
t = gmtread("xx000.dat").data	# x0 y0 w h

coast!(region=:global360, proj=(name=:ortho, center=(120,-30), parallel=t[3]),
       land=:brown, area=5000, frame=(grid=:auto,), shore=:faint, DCW=(country="AU", fill=:bisque),
       xshift=t[1], yshift=t[2]);

# Determine size of insert map of Europe
tt = mapproject(region=(-15,35,30,48), proj=:merc, figsize=5, map_size=true); # w h
mapW = tt.data[1];   mapH = tt.data[2]
coast!(region=(-10,5,35,44), proj=:merc, figsize=15, frame=(axes=:WSne, annot=:auto, ticks=:auto),
       DCW=(country="ES", fill=:bisque), land=:brown, shore=:faint, borders=(type=1,pen=1),
       water=:azure1, res=:full, xshift=-t[1], yshift=11.5-t[2], par=(:FORMAT_GEO_MAP, :dddF))
basemap!(inset=(inside=true, anchor=:TR, size=(mapW, mapH), offset=(0.4, 0.25), save="xx000.dat"),
         box=(fill=:white, pen=1, clearance=0.1, shaded=true))
t = gmtread("xx000.dat").data	# x0 y0 w h
coast!(region=(-15,35,30,48), proj=:merc, figsize=t[3], land=:brown, frame=:bare,
       DCW=(country="ES", fill=:bisque), par=(:MAP_FRAME_TYPE, :plain),
       xshift=t[1], yshift=t[2], show=true)
rm("xx000.dat")
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_11329782002574721413.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide