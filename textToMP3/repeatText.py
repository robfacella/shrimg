times = 130
phrase = "Around the World"
i = 0
lines = []
for i in range(times):
	print (str(i)+" "+phrase)
	lines.append(phrase+"\n")
with open('aroundTheWorld.txt', 'w') as file:
	file.writelines(lines)
