
build:
	haxe web.hxml
	haxe app.hxml

release: clean build
	mv bin drylungs_at
	zip -r drylungs_at.zip drylungs_at -x drylungs_at/dev/**\*
	mv drylungs_at bin

deploy:
	scp -r bin/. weownt@weownthenite.org:public_html/disktree.net/_/drylungs

clean:
	rm -f drylungs_at-*.zip
