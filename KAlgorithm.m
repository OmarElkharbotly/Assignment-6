clc
clear all
close all


ds = tabularTextDatastore('house_prices_data_training_data.csv','TreatAsmissing','NA',.....
    'missingValue',0,'ReadSize',25000);
T = read(ds);
x=T{1:17999,4:21};

n = length(x(1,:));
m=17999;
Matrix=zeros(100,17999);
for w=1:n
    if max(abs(x(:,w)))~=0
    x(:,w)=(x(:,w)-mean((x(:,w))))./std(x(:,w));
    end
end
 Centroids1=rand(18,100);
i=2;

for i=2:1:3
    XFinal=0;
    Ko=0;
    Centroids=rand(18,i);
    while Ko==0
    
   
    Matrix=zeros(100,17999);
    
    
    for O=1:1:i
    for i1=1:1:17999
      Means(O,i1)  =mean((Centroids(:,O)-(x(i1,:))').^2);
      
    end
    end
    for O1=1:1:i
    for k=1:1:17999
        SubMeans=Means(:,k);
       Index =find(SubMeans==min(SubMeans));
       Matrix(Index,k)=k;
       
    end
    end
    
    for P=100:-1:1
        if mean(Matrix(P,:))==0
            Matrix(P,:)=[];
        end
    end
    
    
    XNew=[];
    for F=1:1:i
        
        SubFinal=Matrix(F,:);
        SubFinal(find(SubFinal==0))=[];
        XNew(F,:)=sum(x(SubFinal,:));
        XNew(F,:)=XNew(F,:)/length(SubFinal);
    end
    if Centroids==XNew'
       Ko=-90;
    else
        XNew=XNew';
        Centroids=XNew;
       
    end
    XNew=XNew';
    
    end
    for Tarek=1:1:i
        Final=Matrix(Tarek,:);
        Final(find(Final==0))=[];
        Size=length(Final)
        XFF=(sum(x(Final,:)));
        XFF=XFF/Size ;
        
        XFinal=(1/m)*sum((XFF-Centroids(:,Tarek)').^2)+XFinal;
        
    end
    J(i)=XFinal;
end

plot(J)