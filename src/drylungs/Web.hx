package drylungs;

import Drylungs;
import drylungs.Style;
import drylungs.web.HTML;
import om.http.StatusCode;

typedef Site = Dynamic;

class Web {

    public static var isMobile(default,null) : Bool;
    public static var site(default,null) : Site;

    public static function sendResponse( str : String, ?code : Int ) {
        if( code != null ) php.Web.setReturnCode( code );
        Sys.print( str );
    }

    static function run() {

        site = Json.parse( File.getContent( Drylungs.DATA+'/site.json' ) );

        var uri = php.Web.getURI();
        var params = php.Web.getParams();
        var isMobile = om.System.isMobile();
        var ip = php.Web.getClientIP();

        Template.globals = {

            BUILD: Drylungs.BUILD,

            desktop: !isMobile,
            mobile: isMobile,
            device : isMobile ? 'mobile' : 'desktop',
            language: site.language,
            //platform: 'php',

            site: site,
            theme: site.color.theme,
            //color: site.color.theme,
        };
        for( f in Reflect.fields( site ) )
            Reflect.setField( Template.globals, f, Reflect.field( site, f ) );

        /*
        var testfile = 'data/test';
        try {
            var f =  if( FileSystem.exists( testfile )) File.append( testfile ) else File.write( testfile );
            f.writeString( now+' - '+ip+ ' - '+php.Web.getClientHeaders()+'\n' );
            f.close();
        } catch(e:Dynamic) {
            trace(e);
            return;
        }
        */

        var dispatcher = new Dispatch( uri, params );
        dispatcher.onMeta = function(meta,value) {
            switch meta {
            case 'admin':
                //TODO
                //throw StatusCode.UNAUTHORIZED;
            }
        }
        try {
            dispatcher.dispatch( new drylungs.web.Root() );
        } catch( e : DispatchError ) {
            switch e {
            case DENotFound(part):
                var code = StatusCode.NOT_FOUND;
                var message = 'Not Found';
                sendResponse( new HTML( 'error', { title: 'DLR - $message' } ).build( { code: code, message: message } ), code );
                return;
            case DEInvalidValue:
            case DEMissing:
            case DEMissingParam(p):
            case DETooManyValues:
            }
            trace("TODO "+e );
        }
    }

    static function main() {
        try {
            run();
        } catch(code:Int) {
            php.Web.setReturnCode( code );
            Sys.print( code );
        } catch(e:Dynamic) {
            php.Web.setReturnCode( StatusCode.INTERNAL_SERVER_ERROR );
            if( Drylungs.BUILD.debug ) {
                Sys.print( e );
            } else {
                Sys.print( 'ERROR' );
            }
        }
    }

}
