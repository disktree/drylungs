package drylungs.web;

class HTML {

	public var id(default,null) : String;
	public var ctx(default,null) : Dynamic;
	public var macros(default,null) : MacroContext;

	var tpl : Template;

	public function new( id : String, ?ctx : Dynamic, index = 'index' ) {
		this.id = id;
		if( ctx == null ) {
			this.ctx = { id: id };
		} else {
			this.ctx = ctx;
			this.ctx.id = id;
		}
		tpl = new Template( Resource.get( index ) );
		macros = new MacroContext();
	}

	public inline function print( ?data : Dynamic ) {
		Sys.print( build( data ) );
	}

	public function build( ?data : Dynamic ) : String {
		if( data == null ) data = {};
		ctx.content = getSiteTemplate( id ).execute( data, macros );
		return tpl.execute( ctx, macros );
	}

	public inline function getSiteTemplate( id : String ) : Template {
		return new Template( getSiteContent( id ) );
	}

	public function getSiteContent( id : String, path = "html/site" ) : String {
		return File.getContent( '$path/$id.html' );
	}

	public static function siteExists( id : String, path = "html/site" ) : Bool {
		return FileSystem.exists( '$path/$id.html' );
	}
}

@:keep
private class MacroContext {

    public function new() {}

	//public function constant
	//public function color
	//public function style
	//public function theme

    public function res( resolve : String->Dynamic, id : String ) {
        return Resource.get( id );
    }

	public function log( resolve : String->Dynamic, msg : Dynamic ) {
		haxe.Log.trace( msg );
		return '';
	}

	/*
	public function base64( resolve : String->Dynamic, str : String ) {
		return om.crypto.Base64.encodeString( str );
	}
	*/

}
