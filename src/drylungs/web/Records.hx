package drylungs.web;

class Records extends Site {

    var records : Array<Dynamic>;

    public function new() {
        super();
		records = Json.parse( File.getContent( drylungs.Web.SITE+'/records.json' ) );
    }

    function doDefault( ?id : String ) {
        switch id {
        case null, '', '/':
            doAll();
            //print( { records: records } );
        default:
            var record = getRecordById( id );
            if( record == null )
                throw DispatchError.DENotFound(  id );
            this.id = 'record';
            site.title = 'DLR.$id';
            //site.keywords.push( id );
            print( record );
        }

        /*
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
        */
	}

    function doFeed( d : Dispatch ) {
    	d.dispatch( new drylungs.web.Feed( records ) );
    }

    function doAll() {
        print( { records: records } );
    }

    inline function doList() doAll();

    function getRecordById( id : String ) {
        for( r in records ) if( r.id == id ) return r;
        return null;
    }

}
