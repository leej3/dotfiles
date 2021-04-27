#[ -n "$PS1" ] && source ~/.bash_profile;
for file in ~/.{path,exports,extra}; do
    if [ -r "$file" ] && [ -f "$file" ]; then
	 source "$file" || true
    fi
done;
unset file;

echo .bashrc sourced.
