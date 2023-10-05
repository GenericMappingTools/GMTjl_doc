# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
resetGMT() # hide

Gwetdry = grdlandmask(region=:global360, inc="30m", res=:crude, area=500, N="-1/1/1/1/1", reg=true);
# Manipulate so -1 means ocean/ocean antipode, +1 = land/land, and 0 elsewhere
Gkey = gmt("grdmath -fg ? DUP 180 ROTX FLIPUD ADD 2 DIV =", Gwetdry);
# Calculate percentage area of each type of antipode match.
Gscale = gmt("grdmath -Rg -I30m -r Y COSD 60 30 DIV 360 MUL DUP MUL PI DIV DIV 100 MUL =");
Gtmp   = gmt("grdmath -fg ? -1 EQ 0 NAN =", Gkey);
Gtmp  *= Gscale;

key    = grd2xyz(Gtmp, skip_NaN=true, onecol=:TLf);
ocean  = gmt("gmtmath -bi1f -Ca -S ? SUM UPPER RINT =", key);
Gtmp   = gmt("grdmath -fg ? 1 EQ 0 NAN =", Gkey)
Gtmp  *= Gscale;
key    = grd2xyz(Gtmp, skip_NaN=true, onecol=:TLf)
land   = gmt("gmtmath -bi1f -Ca -S ? SUM UPPER RINT =", key)
Gtmp   = gmt("grdmath -fg ? 0 EQ 0 NAN", Gkey)
Gtmp  *= Gscale;
key    = grd2xyz(Gtmp, skip_NaN=true, onecol=:TLf)
mixed  = gmt("gmtmath -bi1f -Ca -S ? SUM UPPER RINT =", key)

# Generate corresponding color table
C = makecpt(color="blue,gray,red", range=(-1.5,1.5,1))
# But unfortunately this palette is not correct, so lets patch it
C.colormap[1,1:2] .= 0;   C.colormap[1,3] = 1;
C.colormap[3,2:3] .= 0;   C.colormap[3,1] = 1;

# Create the final plot and overlay coastlines
gmtset(FONT_ANNOT_PRIMARY="+8p", FORMAT_GEO_MAP=:dddF)
grdimage(Gkey, proj=(name=:EckertVI, center=180), frame=(axes=:WsNE, title="Antipodal comparisons"),
         xaxis=(annot=60,), yaxis=(annot=30,), yshift=3, interp=:n)
coast!(shore=:thinnest, area=500)

# Place an explanatory legend below
legend!(pos=(anchor=:BC, width=10), box=(pen=:thick,), yshift=-1.0, par=(:FONT_ANNOT_PRIMARY,7),
    text_record(["N 3"
    @sprintf("S 0.3 s 0.25 red  0.25p 0.5 Terrestrial Antipodes [%d %%]", land.data[1])
    @sprintf("S 0.3 s 0.25 blue 0.25p 0.5 Oceanic Antipodes [%d %%]", ocean.data[1])
    @sprintf("S 0.3 s 0.25 gray 0.25p 0.5 Mixed Antipodes [%d %%]", mixed.data[1])]), show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * "." * "png"), joinpath(@OUTPUT, "example_2262303985970576114.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide