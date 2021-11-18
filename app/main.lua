
local fs = require("fs");
local utf8 = utf8 or require("utf8");
local prettyPrint = require("pretty-print");
local stdout = prettyPrint.stdout;
local dump = prettyPrint.dump;

local this = {};
this.__index = this;

local function out(thing)
	local thingType = type(thing);
	if thingType == "string" then
		thing = {thing};
	elseif thingType ~= "table" then
		thing = {dump(thing,nil,true)};
	end
	return stdout:write(thing);
end

local whitelist = {
	"%.lua$";
	"%.moon$";
	"%.c$";
	"%.h$";
	"%.cpp$";
	"%.go$";
	"%.py$";
	"%.cmd$";
	"%.sh$";
	"%.js$";
};

---@return number lines how much lines of there str
---@return number length how much characters in there in utf8 formatting
function this.count(str)
	if not str then
		return 0;
	end
	local lines = 1;
	str:gsub("\n",function ()
		lines = lines + 1;
	end);
	return lines,utf8.len(str);
end

function this:scan(path,handler)
	out{"Scaning ",path,"\n"};
	if path == "./" then
		path = ".";
	end
	for fname,ftype in handler do
		local file = path .. "/" .. fname;
		if ftype == "file" then -- if it is file, read and count that on to self object
			local isWhiteitem;
			for _,whtieitem in ipairs(whitelist) do
				isWhiteitem = fname:match(whtieitem);
				if isWhiteitem then
					break;
				end
			end
			if isWhiteitem then
				local str = fs.readFileSync(file);
				local lines,length = self.count(str);
				self.files  = self.files  + 1;
				self.lines  = self.lines  + lines;
				self.length = self.length + length;
			end
		elseif ftype == "directory" then
			self.directorys = self.directorys + 1;
			self:scan(file,fs.scandirSync(file));
		end
	end
end

function this:path(path) -- scan dir and pass result into self:scan();
	self:scan(path,fs.scandirSync(path));
end

function this:print()
	local lines      = self.lines;
	local files      = self.files;
	local length     = self.length;
	local directorys = self.directorys;

	return out {
		("%d lines in there\n"):format(lines);
		("%d files in there\n"):format(files);
		("%d length of all files in there\n"):format(length);
		("%d directorys in there\n"):format(directorys);
	};
end

function this:init() -- init object status
	self.files      = 0;
	self.lines      = 0;
	self.length     = 0;
	self.directorys = 1;
end

function this.new() -- make new object and init it
	local object = {};
	setmetatable(object,this);
	object:init();
	return object;
end

local path = args[1];
if (not path) or path == "." or path == "" then
	path = "./";
end
local new = this.new();
new:path(path);
new:print();
