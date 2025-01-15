# isodata

```julia
    level = isodata(I::GMTimage; band=1) -> Int
```

Compute global image threshold using iterative isodata method.

It can be used to convert
an intensity image to a binary image with \myreflink{binarize}. `level` is a normalized intensity value that lies
in the range [0 255]. This iterative technique for choosing a threshold was developed by Ridler and Calvard.
The histogram is initially segmented into two parts using a starting threshold value such as 0 = 2B-1, 
half the maximum dynamic range. The sample mean (mf,0) of the gray values associated with the foreground
pixels and the sample mean (mb,0) of the gray values associated with the background pixels are computed.
A new threshold value 1 is now computed as the average of these two sample means. The process is repeated,
based upon the new threshold, until the threshold value does not change any more.

Originaly from MATLAB http://www.mathworks.com/matlabcentral/fileexchange/3195 (BSD, Licenced)

### Args
- `I::GMTimage`: input image of type UInt8.

### Kwargs
- band: If the `I` image has more than one band, use `band` to specify which one to use.

### Returns
An integer value that lies in the range [0 255].

Example
-------

```jldoctest
I = gmtread(GMT.TESTSDIR * "assets/coins.jpg");
level = isodata(I, band=1)
119
```