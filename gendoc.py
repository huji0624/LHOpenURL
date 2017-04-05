#!/usr/bin/python

def error(err):
	print "[ERROR]%s" % (err)
	exit(1)

def openCMD(cmd):
	import os
	print "[openCMD]" + cmd
	f = os.popen(cmd)
	res = f.read()
	f.close()
	return res

def readFile(path):
	f = file(path,"r")
	content = f.read()
	f.close()
	return content	

def nameToScheme(name):
	name = name.replace("Handler","")
	uri = ""
	import re
	reobj = re.findall(r'([A-Z][a-z0-9]*_?)',name)
	if reobj:
		i = 0
		for item in reobj:
			if i==0:
				scheme = item.lower()
				uri += scheme
				uri += "://"
			elif i==1:
				host = item.lower()
				host = host.replace("_",".")
				uri += host
			else:
				if not uri.endswith("."):
					uri += "/"
				uri += item.lower()
			i += 1
	else:
		print "the name of the handler is not valide."+name
	return uri

import sys
args = sys.argv
out_path = None
if len(args) == 3:
	dir_path = args[1]
	out_path = agrs[2]
elif len(args) == 2:
	dir_path = args[1]
else:
	error('gendoc.py proj_dir_path out_path')

#info
print "[INFO]This script can only generate document with one handler in one .h file."

#find all .h file
hfiles = openCMD("find %s -iname *\\.h" % (dir_path)).strip().split("\n")

#find all openurl handler
handlers = []
for f in hfiles:
	print '[FILE]'+f
	c = readFile(f)
	import re
	reobj = re.search(r'/\*\*([\s\S]*)\*/\s*@interface\s(.*)\s:[\s\S]*<[\s\S]*LHOpenURLHandler[\s\S]*>',c)
	if reobj:
		one = {}
		info = reobj.group(1)
		className = reobj.group(2).strip()
		scheme = nameToScheme(className)
		one['info'] = info
		one['scheme'] = scheme
		handlers.append(one)

if out_path:
	import json
	out = json.dumps(handlers)
	f = file(out_path,'w')
	f.write(out)
	f.close()
else:
	for h in handlers:
		print h
