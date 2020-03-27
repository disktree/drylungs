package drylungs;

#if php

import haxe.CallStack;
import om.http.StatusCode;

typedef Device = {
	var desktop: Bool;
	var mobile: Bool;
	var type: String;
}

//TODO
typedef Config = Dynamic;

//TODO
typedef Context = Dynamic;

//TODO
//typedef Request = Dynamic;

//@:keep
class Web {

	public static var config(default,null) : Config;
	public static var device(default,null) : Device;
	//public static var context(default,null) : Context;
	//public static var request(default,null) : Request;

	static function error( code : StatusCode = INTERNAL_SERVER_ERROR, ?info : String, stack = false ) {
		om.Web.setReturnCode( code );
		//print( '<style>html{background:red;color:red;}pre{padding:10px;border:1px solid red;background:black;}</style>' );
		if( info != null ) print( '<pre>$info</pre>' );
		if( stack ) print( '<pre>'+haxe.CallStack.toString( haxe.CallStack.exceptionStack() ) +'</pre>' );
		Sys.exit(1);
	}

	static function main() {

		var date = Date.now();
		//trace(Sys.getCwd());
		//return;
		var host = om.Web.getHostName();
		var uri = om.Web.getURI();
		var path = uri.removeTrailingSlashes();
		var params = om.Web.getParams();
		var baseURI = '';

		var isMobile = om.System.isMobile();
		device = { desktop: !isMobile, mobile: isMobile, type : isMobile ? 'mobile' : 'desktop' };

		try {
			var configName = File.getContent( 'cfg/active' ).trim();
			var configPath = 'cfg/$configName.json';
			if( !FileSystem.exists( configPath ) ) configPath = 'cfg/default.json';
			config = Json.parse( File.getContent( configPath ) );
			//TODO custom host/basepath configs
			//var basepath = if( host == 'localhost' || host.startsWith( '192.168' ) ) '/pro/drylungs/bin/';
			//else config.basepath;
		} catch(e:Dynamic) {
			error( Std.string(e) );
		}

		var rootpath : String = config.rootpath;
		if( rootpath != null ) {
			//if( !rootpath.startsWith( '/' ) ) rootpath = '/'+rootpath;
			//if( !rootpath.endsWith( '/' ) ) rootpath = rootpath+'/';
			path = path.substr( rootpath.length );
			//baseURI = baseURI
		}
		var basepath : String = config.basepath;
		if( basepath != null ) {
			if( !basepath.startsWith( '/' ) ) basepath = '/'+basepath;
			if( !basepath.endsWith( '/' ) ) basepath = basepath+'/';
			path = path.substr( basepath.length );
			baseURI += basepath;
		}
		if( config.remap != null ) {
			for( remap in cast(config.remap,Array<Dynamic>) ) {
				for( src in cast(remap.src,Array<Dynamic>) ) {
					if( src == path ) {
						path = remap.dst;
					}
				}
			}
		}

		var theme = params.exists( 'theme' ) ? params.get( 'theme' ) : config.theme;
		if( theme == 'random' ) {
			var files = FileSystem.readDirectory('css/theme');
			theme = files[Std.int(files.length*Math.random())].withoutExtension();
		}

		//context = Json.parse( File.getContent( 'dat/context.json' ) );

		Template.globals = {
			host: host,
			baseURI : baseURI,
			date: { year: date.getFullYear(), month: date.getMonth(), day: date.getDay() },
			device: device,
			//icons: drylungs.Build.getIconSizes('ico'),
			icons: [48,96,192,512],
			theme: theme,
			theme_color: config.color,
			pages: config.pages,
			//page: path,
			debug: #if debug true #else false #end
		};

		var root = new drylungs.web.Root();
		var router = new Dispatch( path, params );
		/*
		router.onMeta = function(m,v){
			trace(m,v);
			switch m {
            case 'admin':
                //TODO
                //throw StatusCode.UNAUTHORIZED;
            }
		}
		*/
		try router.dispatch( root ) catch( e : DispatchError ) {
			switch e {
			case DENotFound(s):
				om.Web.setReturnCode( NOT_FOUND );
				print( File.getContent( 'htm/404.html' ) );
			default:
				error( Std.string(e) );
			}
		}
	}

}

#end
