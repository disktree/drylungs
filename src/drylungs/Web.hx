package drylungs;

import haxe.Resource;
import haxe.Template;
import haxe.web.Dispatch;
import sys.FileSystem;
import sys.io.File;

class Web {

    static inline var ROOT = '/project/drylungs.at/bin/';

    public static var site(default,null) : Dynamic;

    function new() {}

    function doDefault( ?path : String ) {
        switch path {
        case null,'','/','start':
            printSite( path );
        default:
            printSite( 'error', { code: 404, message: 'not found' } );
        }
    }

    function doAtom() {
        php.Web.setHeader( 'Content-Type', 'application/atom+xml' );
        //printTemplate( Resource.getString( 'atom' ) );
    }

    function doRss() {
        php.Web.setHeader( 'Content-Type', 'application/rss+xml' );
        //printTemplate( Resource.getString( 'rss' ) );
    }

    function doManifest() {
        php.Web.setHeader( 'Content-Type', 'application/application/manifest+json' );
        //printTemplate( Resource.getString( 'manifest' ) );
    }

    static function printSite( id : String, ?context : Dynamic ) {

        var ctx : Dynamic = {};
        for( f in Reflect.fields( site ) ) {
            Reflect.setField( ctx, f, Reflect.field( site, f ) );
        }
        copyFields( site, ctx );
        if( context != null ) {
            copyFields( context, ctx );
        }

        var body = executeTemplate( Resource.getString( id ), ctx );
        ctx.body = body;

        var html = executeTemplate( Resource.getString( 'index' ), ctx );
        Sys.print( html );
    }

    static function executeTemplate( str : String, ?ctx : Dynamic ) : String {
        if( ctx == null ) ctx = {};
        return new Template( str ).execute( ctx );
    }

    static function copyFields<A,B>( src : A, dst : Dynamic ) {
        for( f in Reflect.fields( src ) ) {
            Reflect.setField( dst, f, Reflect.field( src, f ) );
        }
    }

    static function main() {

        //Session.start();

        site = Json.parse( File.getContent( 'content/site.json' ) );

        var uri = php.Web.getURI();
        var path = php.Web.getURI().substr( ROOT.length );
        var params = php.Web.getParams();
        var mobile = om.Runtime.isMobile();

        if( path.length == 0 ) path = 'start';

        Template.globals = site;
        Template.globals.path = path;
        Template.globals.mobile = mobile;
        Template.globals.device = mobile ? 'mobile' : 'desktop';

        site.path = path;

        var releases = Json.parse( File.getContent( 'content/releases.json' ) );
        releases.reverse();
        Template.globals.releases = releases;

        var dispatcher = new Dispatch( path, params );
    	dispatcher.onMeta = function(meta,value) {
            trace(meta,value);
        }
        try {
            dispatcher.dispatch( new Web() );
        } catch(e:Dynamic) {
            Sys.print(e);
        }
        /*
        } catch( e : om.error.NotFound ) {
            Sys.print( "NotFound: "+e );
            return;
        } catch( e : DispatchError ) {
            Sys.print( 'DispatchError: '+e );
            return;
        } catch( e : Dynamic ) {
            Sys.print( "ERROR:"+e );
            return;
        }
        */
    }

}
