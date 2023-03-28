1. Use `map=(lon,lat)` for map coordinates. Requires both **region** and **proj** to be set.
2. Use `inside=code` or `outside=code` for setting the refpoint via a 2-char justification code that refers to
       the (invisible) projected map bounding box. Requires both **region** and **proj** to be set.
3. Use `norm=(x,y)` for normalized bounding box coordinates (0-1). Requires both **region** and **proj** to be set.
4. Use `paper=(x,y)` for plot coordinates (append cm, inch, or point).