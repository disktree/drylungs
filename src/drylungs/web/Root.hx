package drylungs.web;

class Root {

    public function new() {}

    function doDefault( ?path : String ) {
        switch path {
		case null,'','/','index.php','index','home':
            doRecords( drylungs.Web.dispatcher );
        default:
            Sys.print( HTML.build( path, null, { title: "DLR/"+path } ) );
        }
    }

    /*
    function doAdmin__( d : Dispatch ) {
        d.dispatch( new drylungs.web.Admin() );
    }
    */

    function doFeed( d : Dispatch ) {
        d.dispatch( new drylungs.web.Feed() );
    }

    function doAtom( d : Dispatch ) d.dispatch( new drylungs.web.Feed() );
    function doXml( d : Dispatch ) d.dispatch( new drylungs.web.Feed() );

    function doRecords( d : Dispatch ) {
        d.dispatch( new drylungs.web.Records() );
    }

    function doVersion__() {
        Sys.print( Web.VERSION );
    }

    function doRsh( d : Dispatch ) {
        d.dispatch( new drylungs.web.RSh() );
    }

    /*
    function doRecords( ?id : String ) {

        var records : Array<Dynamic> = Json.parse( File.getContent( drylungs.Web.SITE+'/records.json' ) );

        if( id == null ) {

            //for( r in records ) r.notes = r.notes.replace( '\n', '<br>' );
            records.reverse();
            printSite( 'records', {
                records: records
            } );

        } else {

            var record = null;
            /*
            if( ~/^(0|[1-9][0-9]*)$/.match( id ) ) {
                records = records[Std.parseInt(id)];
            } else {
                for( item in records ) if( item.id == id ) { record = item; break; }
            }
            * /
            for( item in records ) if( item.id == id ) { record = item; break; }

            if( record == null ) {
                printSite( 'error', { code : 404, message : 'not found' } );
            } else {
                printSite( 'record', { record: record }  );
                //printSite( 'record', { record: ctx, title: 'DLR·'+ctx.id } );
            }
        }
	}

	inline function doFeed() doAtom();
	inline function doXml() doAtom();

	function doAtom() {
		php.Web.setHeader( 'Content-Type', 'application/atom+xml' );
        var xml = new Template( Resource.getString( 'atom' ) ).execute( {
			records : Json.parse( File.getContent( drylungs.Web.SITE+'/records.json' ) )
		} );
        Sys.print( xml );
	}

    /*
	function doManifest() {
		php.Web.setHeader( 'Content-Type', 'application/application/manifest+json' );
		//printTemplate( Resource.getString( 'manifest' ) );
	}
	* /

    inline function printSite( id : String, ?context : Dynamic ) {
        Sys.print( buildSite( id, context ) );
    }

    function buildSite( id : String, ?context : Dynamic ) : String {

		if( id == null )
			return null;

		var ctx : Dynamic = {
            page: id
            //id: id,
		};

		if( context != null ) {
            //copyFields( context, ctx );
            for( f in Reflect.fields( context ) ) {
                //
                Reflect.setField( ctx, f, Reflect.field( context, f ) );
            }
        }

        var src = Resource.getString( id );
        if( src != null ) {
            ctx.content = new Template( src ).execute( ctx );
        } else {
            ctx.content = '404';
        }
		var html = new Template( Resource.getString( 'index' ) ).execute( ctx, macros );
		return html;
	}

    /*
    function executeTemplate( src : String, ?ctx : Dynamic ) : String {
        var tpl = new Template( src );
        var r = tpl.execute( ctx, new TemplateContext() );
        return r;
    }
    */
}

/*
@:keep
private class TemplateContext {

    public function new() {}

    public function html( resolve : String->Dynamic, id : String ) {
        return Resource.getString( 'tpl_$id' );
    }
}
*/
