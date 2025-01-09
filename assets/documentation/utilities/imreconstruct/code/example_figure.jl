# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

text(["Hello World"], region=(1.92,2.08,1.97,2.02), x=2.0, y=2.0,
     font=(30, "Helvetica-Bold", :white),
     frame=(axes=:none, bg=:black), figsize=(6,0), name="tmp.png")

# Read only one band (althouh gray scale, the "tmp.png" is actually RGB)
I = gmtread("tmp.png", band=1);

# Create a marker image that identifies the object in the image you want to extract through segmentation.
# For this example, identify the "W" in the word "World".
marker = fill(UInt8(0),(size(I)));
marker[390,130] = UInt8(255);

# Perform segmentation of the mask image using the marker image.
Ir = imreconstruct(marker, I);
grdimage(I, figsize=8)
grdimage!(Ir, figsize=8, yshift=-2.57, show=true)
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_14589124174112577337.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide