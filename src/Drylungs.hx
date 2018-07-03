
@:keep
#if !macro @:build(drylungs.macro.Build.complete())#end
class Drylungs {

	/** Path to data files */
	public static inline var DATA = 'data';

	public static var BUILD(default,null) = getBuildInfo();

	macro static function getBuildInfo() {
		var info = {
			version : haxe.macro.Compiler.getDefine( 'version' ),
			revision : haxe.macro.Compiler.getDefine( 'revision' ),
			debug : haxe.macro.Context.defined( 'debug' ),
			git: drylungs.macro.Build.getGitCommitHash()
			//defines : haxe.macro.Context.getDefines(),
		};
		return macro $v{info};
	}

}
