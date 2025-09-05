# Find Periodicity Using Autocorrelation

([Example](https://www.mathworks.com/help/signal/ug/find-periodicity-using-autocorrelation.html) from Matlab documentation)

The autocorrelation sequence of a periodic signal has the same cyclic characteristics as the signal itself. Thus, autocorrelation can help verify the presence of cycles and determine their durations.

Consider a set of temperature data collected by a thermometer inside an office building.
The device takes a reading every half hour for four months. Load the data and plot it.
Subtract the mean to concentrate on temperature fluctuations. Convert the temperature to degrees Celsius.
Measure time in days. The sample rate is thus 2 measurements/hour × 24 hours/day = 48 measurements/day.


\begin{examplefig}{}
```julia
using GMT

D = gmtread(TESTSDIR * "assets/temps.dat");
tempC = (D-32)*5/9;
tempnorm = tempC - mean(tempC);
fs = 2*24;
t = (0:length(tempnorm) - 1)/fs;
plot(t,tempnorm, xlabel="Time (days)", ylabel="Temperature (°C)", title="Temperature time series", figsize=(15, 6), show=true)
```
\end{examplefig}

The temperature does seem to oscillate, but the lengths of the cycles cannot be read out easily.

Compute the autocorrelation of the temperature such that it is unity at zero lag. Restrict the
positive and negative lags to three weeks. Note the double periodicity of the signal.


\begin{examplefig}{}
```julia
using GMT   # Hide
D = gmtread(TESTSDIR * "assets/temps.dat");	# Hide
tempC = (D-32)*5/9; # Hide
tempnorm = tempC - mean(tempC);# Hide
fs = 2*24;# Hide

lags = 0:3*7*fs;
ac = GMT.autocor(tempnorm, lags);
locs = findpeaks(ac);
plot(lags/fs, ac, figsize=(15, 7))
scatter!(lags[locs]/fs,ac[locs], show=1)
```
\end{examplefig}

Determine the short and long periods by finding the peak locations and determining the average time differences between them.

To find the long period, restrict findpeaks to look for peaks separated by more than the short period and with a minimum height of 0.3.

\begin{examplefig}{}
```julia
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
```
\end{examplefig}

To a very good approximation, the autocorrelation oscillates both daily and weekly.
This is to be expected, since the temperature in the building is higher when people
are at work and lower at nights and on weekends.

