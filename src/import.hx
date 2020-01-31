
import om.Json;
import om.Resource;
import om.Time;

using Lambda;
using om.ArrayTools;
using om.StringTools;

#if (sys||macro)
import sys.FileSystem;
import sys.io.File;
import Sys.print;
import Sys.println;
using om.Path;
#end

#if php
import om.Template;
import om.web.Dispatch;
#end

#if js
import om.Browser.console;
import om.Browser.document;
import om.Browser.navigator;
import om.Browser.window;
import js.html.AnchorElement;
import js.html.DivElement;
import js.html.Element;
#end
