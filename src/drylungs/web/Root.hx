package drylungs.web;

import om.http.StatusCode;

class Root {

	public function new() {}

	function doDefault( d : Dispatch ) {
		var id = d.parts[0];
		var title = 'Drylungs – '+id.capitalize();
		var site = new Site( id, { title: title, page: id } );
		print( site.build() );
	}

	function doArtists( d : Dispatch ) {
		d.dispatch( new drylungs.web.Artists() );
	}

	function doAscii() {
		print( '<pre>'+Resource.get( 'ascii' )+'</pre>' );
	}

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
			var xml = new Template( File.getContent( path ) ).execute( {
				updated: updated,
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

	function doSitemap( d : Dispatch ) {
		om.Web.setHeader( 'Content-Type', 'application/xml' );
		print( File.getContent( 'web/sitemap.xml' ) );
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
