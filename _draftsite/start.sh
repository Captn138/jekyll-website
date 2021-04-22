draft() {
	JEKYLL_ENV=production bundle exec jekyll serve -w --host=192.168.0.100 -D -P 8000 -d _draftsite
}

prod() {
	JEKYLL_ENV=production bundle exec jekyll serve -w --host=192.168.0.100
}

if [ -n "$1" ]; then
        case "$1" in
                --draft	) draft;;
                --prod	) prod;;
        esac
fi
