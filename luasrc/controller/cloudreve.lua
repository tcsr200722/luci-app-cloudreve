module("luci.controller.cloudreve", package.seeall)

local http = require "luci.http"
local api = require "luci.model.cbi.cloudreve.api"

function index()
	if not nixio.fs.access("/etc/config/cloudreve") then
		return
	end

	entry({"admin","nas","cloudreve"},cbi("cloudreve/settings"),_("cloudreve"),3).dependent=true
	
	entry({"admin","nas","cloudreve","check"},call("action_check")).leaf=true
	entry({"admin","nas","cloudreve","download"},call("action_download")).leaf=true
	entry({"admin","nas","cloudreve","status"},call("act_status")).leaf=true
end

local function http_write_json(content)
	http.prepare_content("application/json")
	http.write_json(content or { code = 1 })
end

function act_status()
	local e={}
	e.nginx_status=luci.sys.call("ps -w | grep nginx | grep cloudreve | grep -v grep > /dev/null") == 0
	e.php_status=luci.sys.call("ps -w | grep php | grep cloudreve | grep -v grep > /dev/null") == 0
	http_write_json(e)
end

function action_check()
	local json = api.to_check()
	http_write_json(json)
end

function action_download()
	local json = nil
	local task = http.formvalue("task")
	if task == "extract" then
		json = api.to_extract(http.formvalue("file"))
	elseif task == "move" then
		json = api.to_move(http.formvalue("file"))
	else
		json = api.to_download(http.formvalue("url"))
	end
	http_write_json(json)
end