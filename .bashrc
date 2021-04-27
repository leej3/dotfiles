#[ -n "$PS1" ] && source ~/.bash_profile;

for file in ~/.{path,exports,extra}; do
    ([ -r "$file" ] && [ -f "$file" ] && source "$file";) || true
done;
unset file;

