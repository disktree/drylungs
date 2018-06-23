
import haxe.web.Dispatch;
import haxe.Resource;
import haxe.Template;
import om.Json;
import om.Time;

#if sys
import sys.FileSystem;
import sys.io.File;
#end

#if js
import js.Browser.console;
import js.Browser.document;
import js.Browser.navigator;
import js.Browser.window;
#end
