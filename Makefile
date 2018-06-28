
build:
	haxe web.hxml --no-traces
	haxe app.hxml --no-traces

release:
	rm -rf bin
	haxe web.hxml --no-traces
	haxe app.hxml --no-traces
	mv bin drylungs_at
	zip -r drylungs_at.zip drylungs_at -x drylungs_at/dev/**\*
	mv drylungs_at bin

deploy:
	scp -r bin/. weownt@weownthenite.org:public_html/disktree.net/_/drylungs

clean:
	rm -rf bin
	rm -f drylungs_at-*.zip
