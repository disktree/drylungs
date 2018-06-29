package drylungs.web;

class Root {

    @:allow(drylungs.Web) function new() {}

	function doDefault( d : Dispatch ) {
        switch d.url {
        case '':
            doRecords( d );
        default:
            var id = d.parts[0];
            var tpl = 'html/site/$id.html';
            if( FileSystem.exists( tpl ) ) {
                var content = new Template( File.getContent( tpl ) ).execute( {} );
                var ctx = {
                    id: id,
                    title: 'Drylungs.$id',
                    //keywords: [],
                    //description: '',
                    content: content,
                    //color: '#0c0c0c',
                };
                var tpl = new Template( Resource.get( 'index' ) );
                var html = tpl.execute( ctx );
                Sys.print( html );
            } else {
                throw DENotFound( d.url );
            }
        }
    }

	function doRecords( d : Dispatch ) {
		d.dispatch( new drylungs.web.Records() );
	}

    function doXml( d : Dispatch ) d.dispatch( new drylungs.web.Feed() );
	inline function doFeed( d : Dispatch ) doXml(d);
	inline function doAtom( d : Dispatch ) doXml(d);
	inline function doSyndicate( d : Dispatch ) doXml(d);
	inline function doSyndication( d : Dispatch ) doXml(d);

	function doAscii() {
		Sys.print( '<pre>${Resource.get("ascii")}</pre>' );
	}

	function doVersion() {
		Sys.print( Drylungs.REVISION + ' - ' + Drylungs.VERSION );
	}

}
