#!/bin/sh

command -v pandoc >/dev/null 2>&1 || { echo >&2 "pandoc is required but it's not installed. Aborting."; exit 1; }

header='<!DOCTYPE html>
<html>
<title>my gay website</title>
<head>
    <link rel="stylesheet" href="/style.css">
    <script src="/script.js"></script>
</head>
<body>

'

footer='
</body>
</html>
'

compile() {
    printf '%s' "$header" > "$1.html"
    pandoc -f markdown "$1.md" >> "$1.html"
    printf '%s' "$footer" >> "$1.html"
}

recurse() {
    for file in ./*.md; do
        if [ -f "$file" ]; then
            compile "${file%.*}"
            rm "$file"
        fi
    done
    for folder in ./*; do
        if [ -d "$folder" ]; then
            cd "$folder" || exit 1
            recurse
            cd ..
        fi
    done
}

rm -rf build
cp -a src build && cd build || exit 1
recurse
cd ..
[ "$1" = "install" ] && sudo -- sh -c 'rm -rf /srv/http/* && cp -a build/* /srv/http/ && chown -R root:root /srv/http'
