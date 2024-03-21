# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
resetGMT() # hide

basemap(region=(0,360,-1.25,1.75), frame=(axes=:WS, title="Two Trigonometric Functions"), xaxis=(annot=90, ticks=30, suffix="@."), yaxis=(annot=1, grid=10), par=(MAP_FRAME_TYPE=:graph, MAP_VECTOR_SHAPE=0.5), figsize=(20,15), portrait=false)

# Draw sine an cosine curves
plot!(cosd.(linspace(0,360,360)), lw=3)
plot!(sind.(linspace(0,360,360)), pen="3p,0_6:0", par=(:PS_LINE_CAP,:round))

# Indicate the x-angle = 120 degrees
plot!([120 -1.25; 120 1.25], pen=(0.5, :dash))

T = mat2ds([360 1; 360 0; 120 -1.25; 370 -1.35; -5 1.85],
    ["18p,Times-Roman RB x = cos(@%12%a@%%)", "18p,Times-Roman RB y = sin(@%12%a@%%)", 
    "14p,Times-Roman LB 120@.", "24p,Symbol LT a", "24p,Times-Roman RT x,y"])

text!(T, offset=(away=true, shift=0.2), noclip=true, font="", justify="")

# Draw a circle and indicate the 0-70 degree angle
plot!([0 0], region=(-1,1,-1,1), proj=:linear, figscale=3.81, marker=:circle, ms=5.1, ml=1, noclip=true, xshift=9, yshift=7)
plot!(lw="",
    [NaN NaN
#     > x-gridline  -Wdefault
    -1 0
    1 0
    NaN NaN
#     > y-gridline  -Wdefault
    0 -1
    0 1
    NaN NaN
#     > angle = 0
    0 0
    1 0
    NaN NaN
#     > angle = 120
    0 0
    -0.5 0.866025])
plot!(lw=2,
    [NaN NaN
#     > x-gmt projection -W2p
    -0.3333 0
    0 0
    NaN NaN
#     > y-gmt projection -W2p
    -0.3333 0.57735
    -0.3333 0])

T = mat2ds([-0.16666 0 0; -0.3333 0.2888675 0; 0.22 0.27 -30; -0.33333 0.6 30],
    ["12p,Times-Roman CT x", "12p,Times-Roman RM y", "12p,Symbol CB a", "12p,Times-Roman LB 120@."])
text!(T, offset=(away=true, shift=0.1), font="", angle="", justify="")

plot!([0 0 1.25 0 120], marker=:matang, ms="0.4+e", ml=1, fill=:black, show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_2733267212985635290.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide