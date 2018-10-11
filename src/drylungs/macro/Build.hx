package drylungs.macro;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import om.git.Repository;
#end

class Build {

	macro public static function getGitCommit() : ExprOf<String> {
		return macro $v{Repository.getCommit()};
	}

	macro public static function getGitTag() : ExprOf<String> {
		return macro $v{Repository.getTag()};
	}

	/*
	#if macro

	static var debug = Context.defined( 'debug' );

	static function app() {
		if( Context.defined( 'display' ) )
			return;
		Context.onAfterGenerate( function() {
			icons();
			//style( 'desktop', {} );
			//style( 'mobile', {} );
		});
	}

	static function icons() {
		var srcDir = 'res/icon';
		var dstDir = 'bin/ico';
		var expr = ~/^icon-([0-9]+).svg$/;
		if( !FileSystem.exists( dstDir ) ) FileSystem.createDirectory( dstDir );
		for( f in FileSystem.readDirectory( srcDir ) ) {
			if( expr.match( f ) ) {
				var size = expr.matched(1) ;
				var src = '$srcDir/$f';
				var dst = '$dstDir/icon-$size.png';
				if( !FileSystem.exists( dst ) || FileSystem.stat( dst ).mtime.getTime() < FileSystem.stat( src ).mtime.getTime() ) {
					Sys.command( 'inkscape --without-gui $src --export-png $dst' );
				}

			}
		}
		Sys.command( 'convert $dstDir/icon-32.png bin/favicon.ico' );
		/*
		var svgFile = 'res/icon/drylungs-icons.svg';
		var dstDir = 'bin/ico';
		if( !FileSystem.exists( dstDir ) ) FileSystem.createDirectory( dstDir );
		var svgFileModtime = FileSystem.stat( svgFile ).mtime.getTime();
		for( id in [16,32,48,72,96,144,192,512] ) {
			var dst = '$dstDir/icon-$id.png';
			if( !FileSystem.exists( dst ) || FileSystem.stat( dst ).mtime.getTime() < svgFileModtime ) {
				Sys.command( 'inkscape --without-gui $svgFile --export-png $dst --export-id=icon-$id' );
			}
		}
		* /
	}

	static function style( device : String, config : Dynamic ) {

		var srcDir = 'res/style';
		var dstDir = 'bin/css';

		var lessFile = '$srcDir/index-$device.less';
		var cssFile = '$dstDir/style-$device.css';

		/*
		if( !needsBuild( srcDir, cssFile ) ) {
			return;
		}
		* /

		var params : om.less.Lessc.Params = {
			source_map: true,
			no_color: true,
			global_var: [
				{ name: 'device', value: device },
			]
		};

		//var args = ['--clean-css'];

		var r = Lessc.compileFile( lessFile, cssFile, params );
		if( r.code == 0 ) {
			if( debug && r.out.length > 0 ) Sys.println( r.out );
		} else {
			Context.error( r.err, Context.currentPos() );
		}
	}

	static function needsBuild( src : String, dst : String ) : Bool {
		if( !FileSystem.exists( dst ) )
			return true;
		var mdst = FileSystem.stat( dst ).mtime.getTime();
		if( FileSystem.isDirectory( src ) ) {
			for( f in FileSystem.readDirectory( src ) ) {
				var p = '$src/$f';
				if( FileSystem.stat( p ).mtime.getTime() > mdst )
					return true;
			}
		}
		return false;
	}

	#end

	#if sys

	public static function getIconFiles( path : String, ext = 'png' ) : Array<String> {
		var expr = new EReg( '^icon-([0-9]+).$ext$', '' );
		return FileSystem.readDirectory( path ).filter( f -> return expr.match( f ) );
	}

	public static function getIconSizes( path : String, ext = 'png' ) : Array<Int> {
		var expr = new EReg( '^icon-([0-9]+).$ext$', '' );
		var sizes = [for(f in FileSystem.readDirectory( path )) if( expr.match(f) ) Std.parseInt( expr.matched(1) ) ];
		return sizes.sorted( (a,b) -> return (a>b)?1:(a<b)?-1:0 );
	}

	#end
	*/

}
