package drylungs.web;

import haxe.Resource;
import haxe.Template;
import om.Json;
import om.ReflectTools.*;
import sys.FileSystem;
import sys.io.File;

class Root {

    //var context = {};
    var macros : TemplateContext;

    public function new() {
        macros = new TemplateContext();
    }

    function doDefault( ?path : String ) {
		switch path {
		case null,'','/','index.php':
			doRecords();
		default:
            printSite( path );
		}
    }

	function doStart() {
        printSite( 'start' );
    }

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
            */
            for( item in records ) if( item.id == id ) { record = item; break; }

            if( record == null ) {
                printSite( 'error', { code : 404, message : 'not found' } );
            } else {
                printSite( 'record', { record: record }  );
                //printSite( 'record', { record: ctx, title: 'DLR·'+ctx.id } );
            }
        }
	}

    /*
	function doRecord( ?id : String ) {

		if( id == null ) {
			doRecords();
			return;
        }

        var record = null;
        var records : Array<Dynamic> = Json.parse( File.getContent( drylungs.Web.SITE+'/records.json' ) );
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
    */

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
	*/

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

@:keep
private class TemplateContext {

    public function new() {}

    public function html( resolve : String->Dynamic, id : String ) {
        return Resource.getString( 'tpl_$id' );
    }
}
