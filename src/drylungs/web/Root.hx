package drylungs.web;

class Root {

    @:allow(drylungs.Web) function new() {}

	function doDefault( d : Dispatch ) {
        switch d.url {
        case '','index','start': doRecords( d );
        default:
            var id = d.parts[0];
            if( !HTML.siteExists( id ) )
                throw DENotFound( d.url );
            else
                new HTML( id ).print();
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

	function doVersion__() {
		Sys.print( Drylungs.BUILD.version );
	}

    function doBuild__() {
        Sys.print( Drylungs.BUILD );
    }

    function doRadio( d : Dispatch ) {
        d.dispatch( new drylungs.web.Radio() );
    }

    function doLogin( d : Dispatch ) {
        d.dispatch( new drylungs.web.Admin() );
    }

    function doAdmin( d : Dispatch ) {
        d.dispatch( new drylungs.web.Admin() );
    }

}
