
release:
	haxe build.hxml --no-traces
	mv bin drylungs_at
	zip -r drylungs_at.zip drylungs_at
	mv drylungs_at bin

clean:
	rm -f drylungs_at-*.zip
