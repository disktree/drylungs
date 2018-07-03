package drylungs.macro;

#if macro

import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Type;
import haxe.macro.Expr;
import sys.io.Process;

using haxe.macro.ExprTools;

class Build  {

	public static function complete() : Array<Field> {

		var fields = Context.getBuildFields();
		var pos = Context.currentPos();

		//trace(">>>");

		/*
		var debug = Context.defined( 'debug' );
		var revision = Compiler.getDefine( 'revision' );
		var version = Compiler.getDefine( 'version' );
		var defines = Context.getDefines();

		var info = {
			revision: revision,
			version: version,
			debug: debug,
			time: Date.now().toString()
			//defines: defines.toString(),
		};

		fields.push({
			name: 'BUILD',
			access: [AStatic,APublic],
			kind: FVar( macro : Dynamic, macro $v{info} ),
			meta: [ { name: ':keep', pos: pos } ],
			pos: pos
		});

		fields.push({
			name: 'VERSION',
			access: [AStatic,APublic],
			kind: FVar( macro : String, macro $v{version} ),
			meta: [ { name: ':keep', pos: pos } ],
			pos: pos
		});
		*/

		/*
		var hash = getGitCommitHash();
		fields.push({
			name: 'GIT_COMMIT',
			access: [AStatic,APublic],
			kind: FVar( macro : String, macro $v{hash} ),
			meta: [ { name: ':keep', pos: pos } ],
			pos: pos
		});
		*/

		return fields;
	}

	//TODO
	public static function style( ?file : String ) {

		var fields = Context.getBuildFields();
		//var pos = Context.currentPos();
		//var site = Json.parse( File.getContent( Drylungs.DATA+'/site.json' ) );

		var src = '';
		for( f in fields ) {
			switch f.kind {
			case FVar(t,e):
				var color : Dynamic = e.getValue();
				//trace(color);
				for( f in Reflect.fields( color ) ) {
					src += '@'+f+': '+Reflect.field( color, f )+';\n';
				}
			case _:
			}
		}

		var f = File.write( 'res/style/style.less' );
		f.writeString( src );
		f.close();

		return fields;
	}

	public static function getGitCommitHash() : String {
		var git = new Process( 'git', ['rev-parse', 'HEAD' ] );
		switch git.exitCode() {
		case 0:
			return git.stdout.readLine().toString();
		default:
			Context.warning( 'Failed to get git commit hash: '+git.stderr.readAll().toString(), Context.currentPos() );
			return null;
		}
	}

	/*
	//TODO
	macro public static function icons() {

		var path = 'res/icon';
		var svg = '$path/drylungs-icons.svg';
		var svgModtime = FileSystem.stat( svg ).mtime.getTime();

		for( id in [16,32,48,72,96,144,192,512,1024] ) {
			var dst = '$path/icon-$id.png';
			if( !FileSystem.exists( dst ) || FileSystem.stat( dst ).mtime.getTime() < svgModtime ) {
				Sys.command( 'inkscape --without-gui $svg --export-png $dst --export-id=icon-$id' );
			}
		}

		return macro null;
	}
	*/

}

#end
