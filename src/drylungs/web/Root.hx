package drylungs.web;

import om.http.StatusCode;

class Root {

	public function new() {}

	function doDefault( d : Dispatch ) {
		var id = d.parts[0];
		//var title = 'Drylungs – '+id.capitalize();
		var title = 'DRYLUNGS.'+id.toUpperCase();
		var site = new Site( id, {
			title: title,
			page: (id=="root") ? null : id
		} );
		print( site.build() );
	}

	function doArtists( d : Dispatch ) {
		d.dispatch( new drylungs.web.Artists() );
	}

	/*
	function doAscii() {
		print( '<pre>'+Resource.get( 'ascii' )+'</pre>' );
	}
	*/

	function doDev( d : Dispatch ) {
		d.dispatch( new drylungs.web.Dev() );
	}

	function doFeed( ?file : String ) {
		//TODO
		var type = 'atom';
		var updated = FileSystem.stat( Records.DATAFILE ).mtime; //TODO
		var path = 'web/$type.xml';
		if( !FileSystem.exists( path ) ) {
			om.Web.setReturnCode( NOT_FOUND );
			print('404');
		} else {
			var context = Json.parse( File.getContent( 'dat/context.json' ) );
			var xml = new Template( File.getContent( path ) ).execute( {
				updated: updated,
				site: context,
				records: Records.loadData()
			} );
			om.Web.setHeader( 'Content-Type', 'application/xml' );
			//om.Web.setHeader( 'Content-Type', 'application/$type+xml' );
			print( xml );
		}
	}

	function doRecords( d : Dispatch ) {
		d.dispatch( new drylungs.web.Records() );
	}

	function doSearch( d : Dispatch ) {
		trace(d);
		d.dispatch( new drylungs.web.Search() );
	}

	function doSitemap( d : Dispatch ) {
		om.Web.setHeader( 'Content-Type', 'application/xml' );
		var file = 'web/sitemap.xml';
		if( FileSystem.exists( file ) ) {
			print( File.getContent( 'web/sitemap.xml' ) );
		} else {
			//TODO
			/*
			var sitemap = new om.web.Sitemap( 'http://drylungs.at', [
				{ loc: '', lastmod: '2018-05-23' },
				{ loc: 'records' },
			]);
			print( sitemap.toString() );
			*/
		}
	}

	/*
	function doSites( d : Dispatch ) {
		var sites = FileSystem.readDirectory('htm')
			.filter( s -> return s.extension() == 'html' && !s.startsWith('_') )
			.map( s -> return s.withoutExtension() );
		sites.sort( (a,b) -> return (a>b)?1:(a<b)?-1:0 );
		print( new Site( 'sites' ).build( { sites : sites } ) );
	}
	*/

}
