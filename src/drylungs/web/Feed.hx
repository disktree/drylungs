package drylungs.web;

class Feed {

	var data : Dynamic;

	public function new( ?data : Dynamic ) {
		this.data = data;
	}

	function doDefault( ?id : String ) {
		switch id {
		case null,'' : doRecords();
		}
	}

	function doRecords() {
		if( data == null ) data = Json.parse( File.getContent( drylungs.Web.SITE+'/records.json' ) );
		print( { records: data } );
	}

	function print( data : Dynamic, type = 'atom' ) {
		var xml = new Template( Resource.getString( type ) ).execute( data );
		php.Web.setHeader( 'Content-Type', 'application/$type+xml' );
		Sys.print( xml );
	}

}
