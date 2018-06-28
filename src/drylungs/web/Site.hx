package drylungs.web;

class Site {

	var id : String;
	var site : Dynamic;

	function new( ?id : String ) {

		if( id == null ) {
			var cl = Type.getClassName( Type.getClass( this ) );
			id = cl.substr( cl.lastIndexOf( '.' )+1 ).toLowerCase();
		}

		this.id = id;
		this.site = {
			title: 'DLR',
			//keywords: [],
			//description: '',
			content: null,
			color: '#0c0c0c',
		};
	}

	function print( ctx : Dynamic ) {

		//if( ctx == null ) ctx = {};
		site.id = id;

		var res = File.getContent( 'html/site/$id.html' );
		var content = new Template( res ).execute( ctx );
		site.content = content;

		var tpl = new Template( Resource.get( 'index' ) );
		var html = tpl.execute( site );
		Sys.print( html );
	}

	/*
	public static inline function buildHTML( ctx : Dynamic ) {
		return tpl( Resource.get( 'index' ), ctx );
	}

	static inline function tpl( src : String, ?ctx : Dynamic ) {
		return new Template( src ).execute( (ctx==null) ? {} : ctx );
	}
	*/

}
