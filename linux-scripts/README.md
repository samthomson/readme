# linux-scripts

## Restart system monitor display

`dconf reset /de/mh21/indicator-multiload/general/indicator-expression-index`

## file stats

- list all files/dirs in human readable form: `du -sh *`
	- order by biggest first: `du -sh * | sort -rh`

Total size of files (inc subdirs) of a certain extension:
- all jpegs: `{ find . -type f -name "*.jpg" -printf "%s+"; echo 0; } | bc | numfmt --to=si`
- all mp4s `{ find . -type f -name "*.mp4" -printf "%s+"; echo 0; } | bc | numfmt --to=si`
- or of multiple extensions (eg video files; mp4/webm): `{ find . -type f \( -iname \*.mp4 -o -iname \*.webm \)  -printf "%s+"; echo 0; } | bc | numfmt --to=si`


Total files of a certain extension (recursive):
- all jpegs: `find . -type f -name *.jpg | wc -l`
- all webms: `find . -type f -name *.webm | wc -l`