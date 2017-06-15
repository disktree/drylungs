
#if macro

import haxe.io.Bytes;
import haxe.macro.Context;
import sys.FileSystem.*;
import sys.io.File;
import om.io.FileSync.*;

using StringTools;
using haxe.io.Path;

class Build {

	static inline var out = 'bin';
	static inline var debug = true;

	//static inline var STYLEPATHS = ['/home/tong/dev/lib/om.style/res/style/'];

	static function website() {

		for( f in readDirectory( 'res/html' ) ) {
			if( f.startsWith( '_' ) )
				continue;
			var p = 'res/html/$f';
			addResource( f.withoutExtension(), File.getBytes( p ) );
		}

		addResource( 'atom', File.getBytes( 'res/web/atom.xml' ) );
		//addResource( 'rss', File.getBytes( 'res/web/rss.xml' ) );

		Context.onAfterGenerate( function() {

			for( platform in ['desktop','mobile'] ) {
				lessc( 'drylungs-$platform'  );
			}

			syncDirectory( 'res/font', '$out/font' );
			syncDirectory( 'res/image', '$out/image' );
			syncDirectory( 'res/script', '$out/script' );

			syncFile( 'res/web/htaccess', '$out/.htaccess' );
			syncFile( 'res/web/humans.txt', '$out/humans.txt' );
			syncFile( 'res/web/manifest.json', '$out/manifest.json' );
			syncFile( 'res/web/robots.txt', '$out/robots.txt' );
		});
	}

	static inline function addResource( id : String, data : Bytes ) {
		Context.addResource( id, data );
	}

	static function lessc( srcName : String, ?dstName : String ) {

		if( dstName == null ) dstName = srcName;

		var srcPath = 'res/style/$srcName.less';
        var dstPath = '$out/$dstName.css';
        //if( needsUpdate( srcPath, dstPath ) ) {
        var args = [ srcPath, dstPath, '--no-color', '--include-path=/home/tong/dev/lib/om.style/res/style/' ];
        if( !debug ) {
            args.push( '-x' );
            args.push( '--clean-css' );
        }
        var lessc = new sys.io.Process( 'lessc', args );
        var e = lessc.stderr.readAll().toString();
        if( e.length > 0 )
            Context.error( e.toString(), Context.currentPos() );
    }

}

#end
