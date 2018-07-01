package drylungs.web;

class Root {

    @:allow(drylungs.Web) function new() {}

	function doDefault( d : Dispatch ) {
        switch d.url {
        case '','index','start':
            doRecords( d );
        default:
            var id = d.parts[0];
            var tpl = 'html/site/$id.html';
            if( !FileSystem.exists( tpl ) ) {
                throw DENotFound( d.url );
            }
            Sys.print( new HTML( id ).build( {
                content: new Template( File.getContent( tpl ) ).execute( {} ),
            } ) );
        }
    }

	function doRecords( d : Dispatch ) {
		d.dispatch( new drylungs.web.Records() );
	}

    inline function doReleases( d : Dispatch ) doRecords(d);

    function doXml( d : Dispatch ) d.dispatch( new drylungs.web.Feed() );
	inline function doFeed( d : Dispatch ) doXml(d);
	inline function doAtom( d : Dispatch ) doXml(d);
	inline function doSyndicate( d : Dispatch ) doXml(d);
	inline function doSyndication( d : Dispatch ) doXml(d);

	function doAscii() {
		Sys.print( '<pre>${Resource.get("ascii")}</pre>' );
	}

	function doVersion() {
		Sys.print( Drylungs.BUILDINFO.version );
	}

    function doBuildinfo() {
        Sys.print( Drylungs.BUILDINFO );
    }

    function doRadio( d : Dispatch ) {
        d.dispatch( new drylungs.web.Radio() );
    }

    @admin function doAdmin() {
        Sys.print( Drylungs.BUILDINFO );
    }

}
