
#if macro
import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Type;
import haxe.macro.Expr;
#end

#if !macro @:build(Drylungs.build()) #end
class Drylungs {

	// Path to data files
	public static inline var DATA = 'data';

	#if macro

	static function build() : Array<Field> {

        var fields = Context.getBuildFields();
		var pos = Context.currentPos();

		var revision = Compiler.getDefine( 'revision' );
		var version = Compiler.getDefine( 'version' );
		var debug = Context.defined( 'debug' );

		fields.push({
			name: 'DEBUG',
			access: [AStatic,APublic,AInline],
			kind: FVar( macro : Bool, macro $v{debug} ),
			pos: pos
		});

		if( debug ) {
			fields.push({
				name: 'BUILDTIME',
				access: [AStatic,APublic,AInline],
				kind: FVar( macro : String, macro $v{Date.now().toString()} ),
				pos: pos
			});
			fields.push({
				name: 'GIT_COMMIT',
				access: [AStatic,APublic,AInline],
				kind: FVar( macro : String, macro $v{getGitCommitHash()} ),
				pos: pos
			});
		}

		if( revision != null ) {
			fields.push({
				name: 'REVISION',
				access: [AStatic,APublic,AInline],
				kind: FVar( macro : String, macro $v{revision} ),
				pos: pos
			});
		}

		if( version != null ) {
			fields.push({
				name: 'VERSION',
				access: [AStatic,APublic,AInline],
				kind: FVar( macro : String, macro $v{version} ),
				pos: pos
			});
		}

        return fields;
    }

	static function getGitCommitHash() : String {
		var git = new sys.io.Process( 'git', ['rev-parse', 'HEAD' ] );
		switch git.exitCode() {
		case 0:
			return git.stdout.readLine().toString();
		default:
			Context.warning( 'Failed to get git commit hash: '+git.stderr.readAll().toString(), Context.currentPos() );
			return null;
		}
	}

	#end

}
