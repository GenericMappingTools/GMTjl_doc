- **T** or **range** : -- *range=(min,max,inc[,:number,:log2,:log10])* **|** *range=[list]* **|** *range=file*\
    Defines the range of the new CPT by giving the lowest and highest z-value (and optionally an interval). If **range**
    is not given, the existing range in the master CPT will be used intact. The values produces defines the color
    slice boundaries. If *:number* is added as a fourth element then *inc* is meant to indicate the number of
    equidistant coordinates instead. Use *:log2* if we should take log2 of min and max, get their nearest integers,
    build an equidistant log2-array using inc integer increments in log2, then undo the log2 conversion. Same for *:log10*.
    For details on array creation, see `Generate 1D Array`.