# This file was generated, do not modify it. # hide
using GMT
using PrettyTables   # hide
io = IOBuffer() # hide
earthregions("Mainlands")
pato = joinpath(dirname(pathof(GMT))[1:end-4], "share", "named_regions", "") # hide
D = gmtread(pato * "Mainlands_collection.txt")      # hide
pretty_table(io, ["-85.9506" "-82.5561" "8.0329" "11.2167" "CRC" "Continental Costa Rica" "Mainlands";   # hide
"-81.0788" "-75.1848" "-4.99882" "1.43894" "ECC" "Continental Ecuador" "Mainlands"; # hide
"-9.56" "-6.18" "36.955" "42.16" "PTC" "Continental Portugal" "Mainlands";   # hide
"-9.29092" "4.31502" "35.1852" "43.7915" "ESC" "Continental Spain" "Mainlands"];    # hide
header=["W(lon)","E(lon)","S(lat)","N(lat)","Code","Region","Ref"], backend=Val(:html))	# hide
println("~~~" * String(take!(io)) * "~~~") # hide