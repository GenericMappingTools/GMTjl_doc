- **x** or **cores** : -- *cores=N*\
   Limit the number of cores used when making the individual frames. By default we try to use all available cores.
   Append *N* to only use *n* cores (if too large it will be truncated to the maximum cores available). Finally,
   give a negative *N* to select (all - *N*) cores (or at least 1 if *N* equals or exceeds all). The parallel
   processing does not depend on OpenMP.