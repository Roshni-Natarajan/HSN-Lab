fname = raw_input("File Name")

f = open(fname+'.csv', 'r')
lines = f.readlines()
array = []
for s in range(1,len(lines)):
	
	data = lines[s].split()
	array.append(data[len(data)-2][5:])
with open(fname+'.txt', 'w') as fw:
	for j in array:
		fw.write(j + '\n')
