m = Map("cloudreve",translate("cloudreve"),translate("基于ThinkPHP构建的网盘系统，能够以较低成本快速搭建起公私兼备的网盘。快速对接多家云存储，支持七牛、又拍云、阿里云OSS、AWS S3、自建远程服务器，还有本地存储.可限制单文件最大大小、MIMEType、文件后缀、用户可用容量.图片、音频、视频、文本、Markdown、Ofiice文档 在线预览.文件、目录分享系统，可创建私有分享或公开分享链接."))
m:append(Template("cloudreve/status"))

s = m:section(TypedSection,"global",translate("Global Setting"))
s.anonymous = true
s.addremove = false

o = s:option(Flag,"enable",translate("Enable"))
o.rmempty = false

o = s:option(Value, "port", translate("Nginx监听端口"))
o.datatype="port"
o.default=443
o.rmempty = false

o = s:option(Value, "memory_limit", translate("内存最大使用"), translate("如果你的设备内存较大的话，可以适当增加。"))
o.default="8M"
o.rmempty = false

o = s:option(Value, "post_max_size", translate("POST最大容量"), translate("该值不能大于 内存最大使用"))
o.default="12M"
o.rmempty = false

o = s:option(Value, "upload_max_filesize", translate("上传文件最大使用内存"), translate("该值不能大于 POST最大容量"))
o.default="12M"
o.rmempty = false

o = s:option(Value, "storage_device_path", translate("存储设备路径"), translate("建议插入U盘或硬盘，然后输入路径。例如：/mnt/sda1/"))
o.default="/mnt/sda1/"
o.rmempty = false

o = s:option(Value, "project_directory", translate("项目存放目录"), translate("建议插入U盘或硬盘，然后输入路径。例如：/mnt/sda1/cloudreve"))
o.default="/mnt/sda1/cloudreve"
o.rmempty = false

o = s:option(Button, "_download", translate("手动下载"),
	translate("请确保具有足够的空间。<br /><font style='color:red'>第一次运行务必填好设备路径和存放路径，然后保存应用。再手动下载，否则无法使用！</font>"))
o.template = "cloudreve/download"
o.inputstyle = "apply"
o.btnclick = "downloadClick(this);"
o.id="download_btn"

return m