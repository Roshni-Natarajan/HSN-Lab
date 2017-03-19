array=[]
for i in range(1,7):
	fname = raw_input("File Name")
	#f = open('packet_loss_0.1mb_que.csv', 'r')
	f = open(fname+'.csv', 'r')
	lines = f.readlines()
	
	data = lines[10].split()
	d = data[len(data)-1]
	#print 
	array.append(d[1:len(d)-2])
print array
fw = open('plosspercentage.txt','w')
for j in range(0,len(array)):
	fw.write(str(array[j])+'\n')
fw.close()
