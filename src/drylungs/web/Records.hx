package drylungs.web;

typedef Record = {
    id: String,
    name: String,
    ?date: String,
    ?format: String,
    ?description: String,
    ?notes: String,
};

class Records {

    public var list(default,null) : Array<Record>;

    public function new() {
        list = Json.parse( File.getContent( Drylungs.DATA+'/records.json' ) );
        for( rec in list ) {
            if( rec.date == null ) rec.date = '';
            if( rec.format == null ) rec.format = '';
            if( rec.description == null ) rec.description = '';
            if( rec.notes == null ) rec.notes = '';
        }
    }

    function doDefault( ?id : String ) {
        switch id {
        case null, '', '/':
            doAll();
        default:
            var record : Dynamic = null;
            if( ~/^(0|[1-9][0-9]*)$/.match( id ) ) {
                record = list[ Std.parseInt( id )-1 ];
            } else {
                record = getRecordById( id );
            }
            if( record == null )
                throw DispatchError.DENotFound( id );
            Sys.print( new HTML( 'record', { title: 'Drylungs.$id' } ).build( record ) );
        }
    }

    function doAll() {
        Sys.print( new HTML( 'records' ).build( { records: list } ) );
    }

    inline function doList() doAll();

    function doFeed( d : Dispatch ) {
    	d.dispatch( new drylungs.web.Feed( list ) );
    }

    inline function doXml( d : Dispatch ) doFeed(d);

    public function getRecordById( id : String ) : Record {
        for( r in list ) if( r.id == id ) return r;
        return null;
    }

}
