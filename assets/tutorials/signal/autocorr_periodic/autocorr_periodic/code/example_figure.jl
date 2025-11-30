# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT   # Hide

D = gmtread(TESTSDIR * "assets/temps.dat");	# Hide
tempC = (D-32)*5/9; # Hide
tempnorm = tempC-mean(tempC);# Hide
fs = 2*24;# Hide
lags = 0:3*7*fs;  # Hide
ac = GMT.autocor(tempnorm, lags);# Hide
locs = findpeaks(ac);# Hide

shortT = mean(diff(sort(locs))) / fs
locs_long = findpeaks(ac, min_dist=ceil(shortT)*fs, min_height=0.3);
longT = mean(diff(locs_long))/fs
plot(lags/fs, ac, figsize=(15, 7))
scatter!(lags[locs]/fs,ac[locs], fill=:red)
scatter!(lags[locs_long]/fs, ac[locs_long], fill=:blue, show=1)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_18212460617792455548.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide