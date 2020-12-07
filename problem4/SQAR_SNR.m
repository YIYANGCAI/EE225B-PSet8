% Calculate the square of Signal Noise Ratio
function out=SQAR_SNR(in1,in2)
[a,b]=size(in1);
in1=double(in1);
in2=double(in2);
den = 0;
num = 0;
for i=1:a
    for j=1:b
        num = num + (in1(i,j) ^ 2);
        den = den + (in1(i,j) - in2(i,j)) ^ 2;
    end
end
out = (num / den)^(1/2);