package drylungs;

import haxe.Json;
import haxe.Template;
import haxe.web.Dispatch;
import sys.FileSystem;
import sys.io.File;

class Web {

    //static inline var ROOT = '/project/drylungs.at/bin/';
    public static inline var HOST = '192.168.0.10';
    public static inline var PATH = '';
    public static inline var SITE = 'site';

    static function main() {

        try {


                    var uri = php.Web.getURI();
                    var path = php.Web.getURI().substr( PATH.length );
                    var params = php.Web.getParams();
                    var mobile = om.Runtime.isMobile();

                    var ctx = Json.parse( File.getContent( '$SITE/site.json' ) );
                    //ctx.path = path;

                    Template.globals = ctx;
                    Template.globals.path = path;
                    Template.globals.mobile = mobile;
                    Template.globals.device = mobile ? 'mobile' : 'desktop';


            var dispatcher = new Dispatch( path, params );
            dispatcher.onMeta = function(meta,value) {
                trace(meta,value);
            }
            try {
                dispatcher.dispatch( new drylungs.web.Root() );
            } catch(e:Dynamic) {
                trace(e);
                return;
            }
        } catch(e:Dynamic) {
            trace( e );
            //Sys.print( om.macro.FileSystem.getContent( 'res/html/fatal.html' ) );
        }
    }

}
