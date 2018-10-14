package drylungs;

#if php

import haxe.CallStack;
import om.http.StatusCode;

typedef Device = {
	var desktop: Bool;
	var mobile: Bool;
	var type: String;
}

class Web {

	public static var config(default,null) : Dynamic;

	static function error( code : StatusCode = INTERNAL_SERVER_ERROR, ?info : String, stack = false ) {
		om.Web.setReturnCode( code );
		//print( '<style>html{background:red;color:red;}pre{padding:10px;border:1px solid red;background:black;}</style>' );
		if( info != null ) print( '<pre>$info</pre>' );
		if( stack ) print( '<pre>'+haxe.CallStack.toString( haxe.CallStack.exceptionStack() ) +'</pre>' );
		Sys.exit(1);
	}

	static function main() {

		var date = Date.now();
		var isMobile = om.System.isMobile();
		var host = om.Web.getHostName();
		var uri = om.Web.getURI();
		var path = uri.removeTrailingSlashes();
		var params = om.Web.getParams();
		var baseURI = '';
		//var baseURI = 'http://$host';
		//var device = { desktop: !isMobile, mobile: isMobile, type : isMobile ? 'mobile' : 'desktop' };

		try {
			config = Json.parse( File.getContent( 'dat/config.json' ) );
			if( config.basepath != null ) {
				var basepath : String = config.basepath;
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
		} catch(e:Dynamic) {
			error( Std.string(e) );
		}

		//var theme = params.exists( 'theme' ) ? params.get( 'theme' ) : 'default';
		var theme = config.theme;
		if( theme == null ) theme = 'default';

		/*
		switch path {
        case null,'','/','index','home','start':
			path = config.start;
			//om.Web.redirect( path );
		default:
		}
		*/

		Template.globals = {
			host: host,
			baseURI : baseURI,
			date: { year: date.getFullYear(), month: date.getMonth(), day: date.getDay() },
			device: { desktop: !isMobile, mobile: isMobile, type : isMobile ? 'mobile' : 'desktop' },
			//icons: drylungs.Build.getIconSizes('ico'),
			icons: [16,24,32,48,72,96,144,192,512],
			theme: theme,
			theme_color: '#101111',
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
