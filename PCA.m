clc
clear all
close all


ds = tabularTextDatastore('house_prices_data_training_data.csv','TreatAsmissing','NA',.....
    'missingValue',0,'ReadSize',25000);
T = read(ds);
x=T{1:17999,4:21};
n = length(x(1,:));
m=17999;
for w=1:n
    if max(abs(x(:,w)))~=0
    x(:,w)=(x(:,w)-mean((x(:,w))))./std(x(:,w));
    end
end
Corr_x = corr(x) ; 
x_cov=cov(x) ;
[U S V] =  svd(x_cov);
EigenValues=diag(S);
 m1 = length(EigenValues);
for i=1:1:length(EigenValues)
    Numerator = sum(EigenValues(1:i))
    Denem = sum(EigenValues);
    Alpha = 1- (Numerator/Denem) ;
    if ( Alpha <= 0.001)
        break
        end
end
minK=i;

R = (U(:,1:minK)')*(x');

Red = U(:,1:minK)*R;
x=x'
O=1
for i=1:1:18
    for j=1:1:17999
        meanError(O)=(x(i,j)-Red(i,j))^2;
        O=O+1;
    end
end

meanErrorF=(1/length(meanError))*(sum(meanError)) ;

% Linear Regression 
Alpha=0.1;
Y=T{1:17999,3}/mean(T{1:17999,3});
Theta=zeros(n+1,1);
k=1;
Ones=ones(m,1);
Red=Red'
Red=[Ones Red]

E(k)=(1/(2*m))*sum((Red*Theta-Y).^2);

R=1;
while R==1
Alpha=Alpha*1;
Theta=Theta-(Alpha/m)*Red'*(Red*Theta-Y);
k=k+1;
E(k)=(1/(2*m))*sum((Red*Theta-Y).^2);
if E(k-1)-E(k)<0
    break
end 
q=(E(k-1)-E(k))./E(k-1);
if q <.000001;
    R=0;
end
end
