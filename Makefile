
release:
	haxe build.hxml --no-traces
	mv bin drylungs_at
	zip -r drylungs_at.zip drylungs_at
	mv drylungs_at bin

deploy:
	scp -r bin/. weownt@weownthenite.org:public_html/disktree.net/_/drylungs

clean:
	rm -f drylungs_at-*.zip
