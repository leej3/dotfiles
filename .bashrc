#[ -n "$PS1" ] && source ~/.bash_profile;

for file in ~/.{path,exports,extra,extras}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

