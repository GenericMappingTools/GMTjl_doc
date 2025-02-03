- **G** or **save** or **outgrid** or **outfile** : -- *save=file_name.grd*\
    Write one or more fields directly to grids on disk or return them to the Julia REPL as grid objects.
    If more than one field is specified via **fields** then *file_name* must contain the format flag
    %s so that we can embed the field code in the file names.