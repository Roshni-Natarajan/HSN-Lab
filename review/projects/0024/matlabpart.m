x= [100,500,1000]
y1=[11700.3,58496.4,114881.9]
y2=[9751.6,16457.4,16561.3]
y3=[9726.2,7766.1,20370.0]
z1=[55.3685,124.242,901.044]
z2=[8.62283,25.8559,24.1]
z3=[55.8998,119.188,661.447]
%   The numbers in y1,y2,y3,z1,z2 and z3 are the date we get from the geni
% part. We conducted each transmission 5 times and each number here is the
% average value.
plot(x,y1,'b',x,y2,'g',x,y3,'r')
xlabel('bandwidth')
ylabel('throughput')
title('TCP')
legend('no delay no loss','no delay 0.01 loss','50ms delay no loss')
plot(x,z1,'b',x,z2,'g',x,z3,'r')
xlabel('bandwidth')
ylabel('throughput')
title('UDP')
legend('no delay no loss','no delay 0.01 loss','50ms delay no loss')