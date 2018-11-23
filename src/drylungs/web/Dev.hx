package drylungs.web;

class Dev {

	public function new() {}

	function doDefault() {
		print( '<div><a href="dev/context">dev/context</a></div>' );
		print( '<div><a href="dev/version">dev/version</a></div>' );
		print( '<div><a href="dev/git">dev/git</a></div>' );
	}

	function doContext() {
		print( [Web.config,Template.globals].map( e->{
			return'<pre>'+haxe.format.JsonPrinter.print( e, '  ' )+'</pre>';
		}).join('') );
	}

	function doGit( d : Dispatch ) {
		om.Web.redirect( 'https://api.github.com/repos/disktree/drylungs/events' );
	}

	function doVersion( d : Dispatch ) {
		print('<pre>COMMIT: '+drylungs.macro.Build.getGitCommit()+'</pre>');
		print('<pre>TAG: '+drylungs.macro.Build.getGitTag()+'</pre>');
	}

}
