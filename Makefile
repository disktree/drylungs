
OUT=bin

bin/css/app.css:
	lessc res/style/index.less bin/css/app.css --include-path=($DEV)/lib/enron/src --no-color --source-map

icons:
	inkscape -e $(OUT)/ico/icon-512.png res/icon/icon-512.svg
	inkscape -e $(OUT)/ico/icon-192.png res/icon/icon-192.svg
	inkscape -e $(OUT)/ico/icon-96.png res/icon/icon-96.svg
	inkscape -e $(OUT)/ico/icon-48.png res/icon/icon-48.svg
	convert -resize x32 -gravity center -crop 32x32+0+0 $(OUT)/ico/icon-48.png -colors 256 -background transparent $(OUT)/favicon.ico

release: clean
	haxe app.hxml --no-traces -dce full
	closure-compiler $(OUT)/scr/app.js --js_output_file $(OUT)/scr/app.min.js
	mv $(OUT)/scr/app.min.js $(OUT)/scr/app.js
	rm $(OUT)/scr/app.js.map
	haxe web.hxml --no-traces -dce full
	lessc res/style/index.less $(OUT)/css/app.css --include-path=$(DEV)/lib/enron/src --clean-css="--advanced"

clean:
	rm -rf $(OUT)/lib
	rm -f $(OUT)/index.php
	rm -f $(OUT)/css/app.css*
	rm -f $(OUT)/scr/app.js*

.PHONY: icons release clean
