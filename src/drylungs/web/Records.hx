package drylungs.web;

using Lambda;

private typedef Link = {
	name: String,
	uri: String
}

private typedef Track = {
	position: String,
	name: String,
	duration: String
}

private typedef Record = {
    id: String,
    name: String,
    artists: Array<String>,
    date: String,
    year: Int,
    format: String,
    description: String,
    notes: String,
	tracks: Array<Track>,
	color: String,
	links: Array<Link>,
	credits: String,
	// added →
	i: Int,
	prev: String,
	next: String,
};

class Records {

	public static inline var DATAFILE = 'dat/records.json';

	public static function loadData() : Array<Record> {
		var list : Array<Record> = Json.parse( File.getContent( DATAFILE ) );
		for( i in 0...list.length ) {
			var rec = list[i];
			rec.i = (i+1);
			rec.prev = list[ (i==0) ? list.length-1 : i-1].id;
			rec.next = list[ (i==list.length-1) ? 0 : i+1].id;
			rec.description = formatText( rec.description );
			rec.notes = formatText( rec.notes );
			//rec.notes = rec.notes.split('\n').join('<br>');
			rec.year = Date.fromString( rec.date ).getFullYear();
			/*
            if( rec.date == null ) rec.date = '';
            if( rec.format == null ) rec.format = '';
            if( rec.description == null ) rec.description = '';
            if( rec.notes == null ) rec.notes = '';
			*/
        }
		list.reverse();
		return list;
	}

	static function formatText( text : String ) : String {
		if( text == null || text.length == 0 )
			return '–';
		return text.split('\n').join('<br>');
 		//return text.split( '\n' ).map( l -> return '<p>$l</p>' ).join('');
	}

	public var list(default,null) : Array<Record>;

	public function new() {
		list = loadData();
	}

	function get( id : String ) : Record {
		for( r in list ) if( r.id == id ) return r;
		return null;
	}

	function doDefault( ?id : String ) {
		switch id {
		case null,'':
			print( new Site( 'records', {
				title: 'Drylungs Records',
				page: 'DRYLUNGS™'
			} ).build( { records: list } ) );
		default:
			if( ~/^(0|[1-9][0-9]*)$/.match( id ) ) {
				var i = Std.parseInt( id );
				if( i < 1 || i > list.length )
					throw DENotFound( 'record not found' );
				else
					om.Web.redirect( list[list.length-i].id );
			} else {
				var record : Record = get( id );
				if( record == null )
					throw DENotFound( id );
				var site = new Site( 'record', {
					title: record.id,
					page: record.id
				} );
				site.context.keywords = site.context.keywords.concat([record.id]);
				site.context.twitter.card = 'summary_large_image';
				site.context.twitter.title = 'DRYLUNGS/'+record.id;
				site.context.twitter.description = record.name+' by '+record.artists.join('/');
				site.context.twitter.image = 'cover/1000/'+record.id+'.jpg';
				site.context.twitter.image_alt = record.id;
				site.context.music = {
					musician: record.artists.join(','),
					release_date: record.date
				};
				print( site.build( { record: record } ) );
			}
		}
	}

	function doYear( year : Int ) {
		print( new Site( 'records' ).build( { records: list.filter( r -> {
			return Date.fromString( r.date ).getFullYear() == year;
		}) } ) );
	}

	function doArtist( name : String ) {
		name = name.toLowerCase();
		print( new Site( 'records' ).build( { records: list.filter( r -> {
			return r.artists.map( a -> return a.toLowerCase() ).has( name );
		}) } ) );
	}

	/*
	function doArtists( ?name : String ) {
		if( name == null ) {
			var map = new Map<String,Dynamic>();
			for( r in list ) {
				for( a in r.artists ) {
					if( map.exists( a ) ) {
						map.get( a ).push( r.id );
					} else {
						map.set( a, [r.id] );
					}
				}
			}
			var artists = new Array<{name:String,records:Array<String>}>();
			for( k in map.keys() ) {
				artists.push( { name: k, records: map.get(k) } );
			}
			Sys.print( new Site( 'artists' ).build( { artists: artists } ) );
		} else {

		}
	}
	*/

	/*
	function doDiscogs( d : Dispatch ) {
		d.dispatch( new drylungs.web.Discogs() );
	}
	*/

}
