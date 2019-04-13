close all;
clear all;
clc;
ds = tabularTextDatastore('house_prices_data_training_data.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',25000);
T = read(ds);
size(T);
m=length(T{:,1});
x=T{1:17999,4:21};
m=length(x(:,1));
features=length(x(1,:));
for w=1:features
    if max(abs(x(:,w)))~=0
        x(:,w)=(x(:,w)-mean((x(:,w))))./std(x(:,w));
    end
end
eps=0.0001;

anom=0;
for i=1:m
    result=1;
    for j=1:features
        if(qfunc(x(i,j))<eps || qfunc(x(i,j))>1-eps)
            result=result+1;
            anom=anom+1;
        end
       
    end
end