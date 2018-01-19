package drylungs;

import haxe.Resource;
import haxe.Template;
import haxe.web.Dispatch;
import sys.FileSystem;
import sys.io.File;

class Web {

    static inline var ROOT = '/project/drylungs.at/bin/';

    function new() {}

    function doDefault( ?path : String ) {

        printHTML();
        
        /*
        if( path == null || path.length == 0 || path == 'index.php' ) {
            printHTML();
        } else {
            handleError( 404, 'not found' );
        }
        */
    }

    //function doStyle() {

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

    static function printHTML( id = 'index', ?ctx : Dynamic ) {
        Sys.print( executeTemplate( Resource.getString( id ), ctx ) );
    }

    static function executeTemplate( str : String, ?ctx : Dynamic ) {
        if( ctx == null ) ctx = {};
        return new Template( str ).execute( ctx );
    }

    static function handleError( code : Int, message = '') {
        printHTML( 'error', { code: code, message: message } );
    }

    static function main() {

        //Session.start();

        var uri = php.Web.getURI();
        var path = php.Web.getURI().substr( ROOT.length );
        var params = php.Web.getParams();
        var mobile = om.Runtime.isMobile();

        var releases = Json.parse( File.getContent( 'content/releases.json' ) );
        releases.reverse();

        Template.globals = Json.parse( File.getContent( 'content/site.json' ) );
        Template.globals.mobile = mobile;
        Template.globals.device = mobile ? 'mobile' : 'desktop';
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
