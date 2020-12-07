% Calculate the root of mean square errors
function out=RMSE(in1,in2)
[a,b]=size(in1);
in1=double(in1);
in2=double(in2);
out=0;
for i=1:a
    for j=1:b
        out=out+(in1(i,j)-in2(i,j))^2;
    end
end
out=(out/(a*b))^(1/2);