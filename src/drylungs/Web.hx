package drylungs;

import haxe.Resource;
import haxe.Template;
import haxe.web.Dispatch;
import om.Json;
import php.Session;
import sys.FileSystem;
import sys.io.File;

class Web {

    //static inline var DB = 'content/site.db';
    //public static var db : sys.db.Connection;
    //public static var request(default,null) : Request;
    public static var context : Dynamic;
    //public static var response : String;
    //public static var user : User;

    static function main() {

        /*
        if( !FileSystem.exists( DB ) ) {
			try File.write( DB ).close() catch(e:Dynamic){
				Sys.println( 'fatal db error '+e );
                Sys.exit(1);
			}
		}
        
        //db = sys.db.Sqlite.open( DB );
		//sys.db.Manager.cnx = db;
		//sys.db.Manager.initialize();
        //if( !sys.db.TableCreate.exists( drylungs.db.Blog.Entry.manager ) ) sys.db.TableCreate.create( drylungs.db.Blog.Entry.manager );
        */

        Session.start();

        var uri = om.Web.getURI();
        var params = om.Web.getParams();

        context = Json.parse( File.getContent( 'content/context.json' ) );
        context.content = '';
        context.mobile = om.Web.isMobile();

        var dispatcher = new Dispatch( uri, params );

        try {

            dispatcher.dispatch( new drylungs.web.Router() );

            //var html = new Template( Resource.getString( 'site' ) ).execute( context );
            //Sys.print( html );

        } catch( e : om.error.NotFound ) {
            Sys.print( "NotFound: "+e );
            return;
        } catch( e : DispatchError ) {
            Sys.print( 'DispatchError '+e );
            return;
        } catch( e : Dynamic ) {
            Sys.print( "ERROR:"+e );
            return;
        }

        //sys.db.Manager.cleanup();
        //db.close();
    }

}
