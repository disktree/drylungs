package drylungs.web;

import om.http.StatusCode;

class Admin {

	public var nonce(default,null) = 'Fg0i5S49A'; //TODO admin nonce

	public function new() {}

	function doDefault() {
		var html = new HTML( 'login' ).build( {
			nonce: nonce,
			//username:
		} );
		Sys.print( html );
    }

	function doLogin() {

		var auth = php.Web.getAuthorization();
		var method = php.Web.getMethod();
		//var data = php.Web.getPostData();
		var data = php.Web.getParams();

        //Sys.print(auth);
        //Sys.print(method);
        //Sys.print(data);
		//for( k in data.keys() ) Sys.print( '###'+k+':'+data.get(k) );

		var username = data.get( 'username' );
		var password = data.get( 'password' );
		var nonce = data.get( 'nonce' );

		//trace(username,password,nonce);

		throw StatusCode.UNAUTHORIZED;
    }

	@admin function doLogout() {
		Sys.print( 'doLogout' );
	}

	@admin function doFuck() {
		Sys.print( 'FUCK' );
		throw StatusCode.UNAUTHORIZED;
	}

}
