package drylungs.web;

import haxe.web.Dispatch;

class Feed {

	public function new() {}

	function doDefault( ?id : String ) {

		var records = Json.parse( File.getContent( drylungs.Web.SITE+'/records.json' ) );

		var xml = new Template( Resource.getString( 'atom' ) ).execute( {
			records :  records
		} );
		php.Web.setHeader( 'Content-Type', 'application/atom+xml' );
        Sys.print( xml );
	}

}
