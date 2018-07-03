package drylungs.web;

typedef Record = Dynamic;

class Records {

    var records : Array<Record>;

    public function new() {
        records = Json.parse( File.getContent( Drylungs.DATA+'/records.json' ) );
        for( rec in records ) {
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
                record = records[ Std.parseInt( id )-1 ];
            } else {
                record = getRecordById( id );
            }
            if( record == null )
                throw DispatchError.DENotFound( id );
            Sys.print( new HTML( 'record', { title: 'Drylungs.$id' } ).build( record ) );
        }
    }

    function doAll() {
        Sys.print( new HTML( 'records' ).build( { records: records } ) );
    }

    inline function doList() doAll();

    function doFeed( d : Dispatch ) {
    	d.dispatch( new drylungs.web.Feed( records ) );
    }

    inline function doXml( d : Dispatch ) doFeed(d);

    function getRecordById( id : String ) : Record {
        for( r in records ) if( r.id == id ) return r;
        return null;
    }

}

/*
class Records extends Site {

    var records : Array<Record>;

    public function new() {
        super();
		records = Json.parse( File.getContent( Drylungs.DATA+'/records.json' ) );
    }

    function doDefault( ?id : String ) {
        switch id {
        case null, '', '/':
            doAll();
        default:

            var record = getRecordById( id );
            if( record == null )
                throw DispatchError.DENotFound(  id );

            this.id = 'record';
            site.title = 'Drylungs.$id';

            //TODO twitter:player card

            site.twitter = {
                title: site.title,
                description: record.description,
                image: 'image/record/$id.jpg',

            };
            //site.keywords.push( id );
            print( record );
        }
	}

    function doAll() {
        print( { records: records } );
    }

    inline function doList() doAll();

    function doFeed( d : Dispatch ) {
    	d.dispatch( new drylungs.web.Feed( records ) );
    }

    function getRecordById( id : String ) : Record {
        for( r in records ) if( r.id == id ) return r;
        return null;
    }

}

*/
