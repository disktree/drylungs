
#if macro

import haxe.macro.Context;
import sys.FileSystem.*;
import sys.io.File;
import om.io.FileSync.*;

using StringTools;
using haxe.io.Path;

class Build {

	static inline var out = 'web';
	static inline var debug = true;

	static function website() {

		for( f in readDirectory( 'res/html' ) ) {
			if( f.startsWith( '_' ) )
				continue;
			var p = 'res/html/$f';
			Context.addResource( f.withoutExtension(), File.getBytes( p ) );
		}

		Context.onAfterGenerate( function() {

			lessc( 'drylungs-desktop' );
			lessc( 'drylungs-mobile'  );

			syncDirectory( 'res/font', '$out/font' );
			syncDirectory( 'res/image', '$out/image' );
			syncFile( 'res/web/htaccess', '$out/.htaccess' );
			syncFile( 'releases.json', '$out/releases.json' );
		});
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
        //}
    }
}

#end
