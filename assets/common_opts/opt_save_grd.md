- **G** or **save** or **outgrid** or **outfile** : -- *save=file_name.grd*\
    Write one or more fields directly to grids on disk; no data is returned to the Julia REPL.
    If more than one fields are specified via **fields** then *file_name* must contain the format flag
    %s so that we can embed the field code in the file names.