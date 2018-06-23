package drylungs.web;

import sys.FileSystem;
import sys.io.File;

class Admin {

    public function new() {}

    function doDefault() {
		//Sys.println("not allowed");
		doVersion();
	}

    function doVersion() {
        Sys.print( drylungs.Web.VERSION );
    }

    function doBuildtime() {
        Sys.print( drylungs.Web.BUILDTIME );
    }

    function doUpdate() {

        //TODO download zip from github and update website
        /*
        try {
            var data = Json.parse( php.Web.getPostData() );

            var dir = '.update';
            var now = Date.now();

            if( !FileSystem.exists( dir ) ) FileSystem.createDirectory( dir );
            File.saveContent( '$dir/'+(now.getTime())+'.json', Json.stringify( data ) );

        } catch(e:Dynamic) {
            Sys.print('failed to update');
        }
        */

        var body = 'OIOIOI';

        /*
        trace( "<>>" );
        om.net.SMTP.send(
            'disktree.net',
            'tong@disktree.net',
            'tong.disktree@gmail.com',
            body,
            25,
            'tong@disktree.net',
            '4Jwg1G5xk2gVMa2L');
            trace( "<>>" );
            */

    }

}
