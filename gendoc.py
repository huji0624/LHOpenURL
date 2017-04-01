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

def nameToScheme(nam):
	return "scheme"

import sys
args = sys.argv

if len(args) == 3:
	dir_path = args[1]
	out_path = agrs[2]
else:
	error('gendoc.py proj_dir_path out_path')

#find all .h file
hfiles = openCMD("find %s -iname *\\.h" % (dir_path)).strip().split("\n")

#find all openurl handler
handlers = []
for f in hfiles:
	print '[FILE]'+f
	c = readFile(f)
	import re
	reobj = re.search(r'/\*\*([\s\S]*)\*/\s@interface\s(.*)\s:[\s\S]*<[\s\S]*LHOpenURLHandler[\s\S]*>',c)
	if reobj:
		one = {}
		info = reobj.group(1)
		className = reobj.group(2)
		scheme = nameToScheme(className)
		one['info'] = info
		one['scheme'] = scheme
		handlers.append(one)

import json
out = json.dumps(handlers)
f = file(out_path,'w')
f.write(out)
f.close()
