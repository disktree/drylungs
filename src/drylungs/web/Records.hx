package drylungs.web;

class Records {

    var records : Array<Dynamic>;

    public function new() {
		records = Json.parse( File.getContent( drylungs.Web.SITE+'/records.json' ) );
    }

    function doList() {
		Sys.print( HTML.build( 'records', { records: records } ) );
	}

	inline function doAll() doList();

    function doFeed( d : Dispatch ) {
		d.dispatch( new drylungs.web.Feed() );
	}

    function doDefault( ?id : String ) {
		switch id {
		case null, '', '/','all','list','any':
			doList();
		default:
			var record = null;
			for( item in records ) if( item.id == id ) { record = item; break; }
			if( record == null ) {
				Sys.print('record not found ('+id+')');
				//printSite( 'error', { code : 404, message : 'not found' } );
			} else {
				Sys.print( HTML.build( 'record', { record: record }, { title: 'DLR.'+record.id } ) );
			}
		}
	}

}
