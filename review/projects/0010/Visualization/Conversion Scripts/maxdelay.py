from array import array
array2=[]
for i in range(1,7):
	fname = raw_input("File Name")

	f = open(fname+'.txt', 'r')
	lines = f.readlines()
	#lines = lines.rstrip('\n')
	array = []
	
	for s in range(1,len(lines)):
		array.append(float(lines[s][:-1]))
#	print array
	array2.append(max(array))

print array2

#array2=[2.1,4.2,2.2,1.2]
#s = array('d', array2)
#print s
fw = open('delay.txt','w')
for j in range(0,len(array2)):
	fw.write(str(array2[j])+'\n')
fw.close()
