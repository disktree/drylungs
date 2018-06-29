package drylungs.web;

class Records extends Site {

    var records : Array<Dynamic>;

    public function new() {
        super();
		records = Json.parse( File.getContent( Drylungs.DATA+'/records.json' ) );
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
            site.title = 'Drylungs.$id';
            //site.keywords.push( id );
            print( record );
        }
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
