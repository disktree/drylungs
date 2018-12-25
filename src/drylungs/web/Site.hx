package drylungs.web;

class Site {

	public static final TPL_PATH = 'htm';
	public static final TPL_EXTS = ['html','htm'];

	public var id(default,null) : String;
	public var context(default,null) : Dynamic;

	public function new( id : String, ?context : Dynamic ) {
		this.id = id;
		this.context = Json.parse( File.getContent( 'dat/context.json' ) );
		if( context != null ) {
			for( f in Reflect.fields( context ) ) {
				Reflect.setField( this.context, f, Reflect.field( context, f ) );
			}
		}
		this.context.id = id;
		this.context.stylesheets = [];
		/*
		for( f in FileSystem.readDirectory( 'css' ) ) {
			var p = 'css/$f';
			if( !FileSystem.isDirectory( p ) ) {
				this.context.stylesheets.push( p );
			}
		}
		*/
		/*
		var path = 'css/page/$id.css';
		if( FileSystem.exists( path ) ) {
			this.context.stylesheets.push( path );
		}
		*/
	}

	public function build( ?data : Dynamic ) : String {
		var tpl = getTemplate( id );
		if( tpl == null )
			throw DENotFound( id );
		var ctx : Dynamic = { site: context };
		if( data != null ) {
			for( f in Reflect.fields( data ) ) {
				Reflect.setField( ctx, f, Reflect.field( data, f ) );
			}
		}
		var html = getTemplate( 'index' ).execute( {
			site: context,
			content: tpl.execute( ctx )
		} );
		return html;
	}

	public static function getTemplate( id : String, ?ext : String ) : Template {
		var path : String = null;
		if( ext != null ) {
			path = '$TPL_PATH/$id.$ext';
			if( !FileSystem.exists( path ) )
				return null;
		} else {
			for( ext in TPL_EXTS ) {
				var p = '$TPL_PATH/$id.$ext';
				if( FileSystem.exists( p ) ) {
					path = p;
					break;
				}
			}
		}
		if( path == null )
			return null;
		return new Template( File.getContent( path ) );
	}
}

/*
@:keep
private class MacroContext {

	public function new() {}

	function test( resolve : String->Dynamic, msg : Dynamic ) {
		//haxe.Log.trace( msg );
		Sys.print( "RESOLVE: "+resolve("A") );
		return '';
	}

	function log( resolve : String->Dynamic, msg : Dynamic ) {
		haxe.Log.trace( msg );
		return '';
	}
}
*/
