from bs4 import BeautifulSoup as bs
import re
import os
'''
# Finally pulled my memos from the cracked SSG
adb pull /storage/emulated/legacy/ShareMemo ~/Documents/memos/
Those memos were old?? literally not in my actual memos anymore, stuff I had ALREADY uploaded
# Except they are in an obscure .memo format
# Double clicking causes Engrampa to try to browse the .memo as an archive
# the only files within are an empty folder named 'media' and
# 'memo_content.xml' I only need to get that XML file and convert it to text

Right-Click and Extract Here does exactly what one would expect it to, this may be a shell project rather than python
'''
#BASH
#engrampa -h ShareMemo/Memo_20*
#rm ShareMemo/*.memo
'''
Nevermind, parsing XML is a job for BeautifulSoup
'''

def parseHeader(header):
	pieces = (header.findAll('meta')) # , name=re.compile(r'^title')))
	dict = {}
	for part in pieces:
		dict.update ( part.attrs )
	return dict	#return dictionary of meta data
def parseXML(xmlFile):
	content = []
	with open(xmlFile, 'r') as file:
		content = file.readlines()
		content = "".join(content)
		bs_content = bs(content, "lxml")
	head = parseHeader(bs_content.header)
	content = []
	content.append(head)
	for line in bs_content.find_all("content"):
		parsedLine = (line.get_text().replace('</p>', '\n').replace('<p>', '').replace('<p value="memo2" >', '').replace('&nbsp;', '')) # Use end of p tag as new line and remove start tag
		content.append(parsedLine)
	return content
def doTheThing(folder):
	os.chdir(folder)
	file = "memo_content.xml"
	return (parseXML(os.getcwd()+'/'+file))
def getFolders():
	root = os.getcwd()
	beegListo = os.listdir(root)
	for folder in beegListo:
		txtOfXML = doTheThing(folder)
		os.chdir(root)
		txtName = folder.split('_',1)[1].split('.')[0]
		print ("use FolderName for file-- ie: "+ txtName+ ".txt")
		os.chdir('../text')
		print (os.getcwd())
		#print (txtOfXML[0])
		#print (txtOfXML[1])
		with open(txtName+".txt", "w") as file:
			file.write(str(txtOfXML[0]))
			file.write('\n'+txtOfXML[1])
		os.chdir(root)
os.chdir('ShareMemo')
getFolders()
