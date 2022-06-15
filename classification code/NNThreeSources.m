%%%%%%%Organizing data
clear,clc
load('photon_count.mat')


Observations=1e3;  %Observations for training
ObserT=1e3;         %Observations for testing
Perc_test=0.15;     %Percentage of Test Data
MM=100:100:4000;    %Number of bins to build histogram
nn=8;              %Photon number for histograms

Photons=[thth;cohth;thcohth];
[ren1,col1]=size(Photons);
index=randperm(col1);

SampleTest=ceil(col1*Perc_test);
SampleTrain=col1-SampleTest;

PhotonCount=zeros(ren1,SampleTrain);
PhotonCountT=zeros(ren1,SampleTest);
for n=1:ren1
    PhotonCount(n,:)=Photons(n,index(1,1:SampleTrain));
    PhotonCountT(n,:)=Photons(n,index(1,SampleTrain+1:end));
end

%parpool
%% %%%%%%%%%%%%%%%% Training %%%%%%%%%%%%%%%%%%%%%%%%%
[ren,col]=size(PhotonCount);

for rrr=1:length(MM)
    rrr
    M=MM(1,rrr);
    %Constructing vector de M-bins
    MBins=randi(col,[M,Observations]);
    MPhotonCount=[];
    Target=zeros(ren,ren*Observations);

    for r=1:ren
        aux=PhotonCount(r,:);
        MP=aux(MBins);
        MPhotonCount=[MPhotonCount,MP];
        Target(r,1+(r-1)*Observations:r*Observations)=ones(1,Observations);
    end

    %Conteo de fotones
    Prob=zeros(nn+1,ren*Observations);
    for n=0:nn
        Prob(n+1,:)=sum(MPhotonCount==n)./M;
    end

    %Neural network
    Net = patternnet(5);
    [NetTrained,tr]= train(Net,Prob,Target,'useParallel','yes');

    %%%%%%%%%%%%%%%%%% Test %%%%%%%%%%%%%%%%%%%%%%%%%
    parfor m=1:10
        [ren2,col2]=size(PhotonCountT);

        %Constructing vector de M-bins
        MBinsT=randi(col2,[M,ObserT]);
        MPhotonCountT=[];
        TargetT=zeros(ren2,ren2*ObserT);

        for r=1:ren2
            aux=PhotonCount(r,:);
            MP=aux(MBinsT);
            MPhotonCountT=[MPhotonCountT,MP];
            TargetT(r,1+(r-1)*ObserT:r*ObserT)=ones(1,ObserT);
        end


        ProbT=zeros(nn+1,ren2*ObserT);
        for n=0:nn
            ProbT(n+1,:)=sum(MPhotonCountT==n)./M;
        end

        y = NetTrained(ProbT);
        class= vec2ind(y);
        T=vec2ind(TargetT);
        R=T-class;
        [ren3,col3]=size(T);
        A(m,rrr)=(sum(R==0)/col3)*100;
    end
end
errorbar(MM,mean(A),std(A))
xlabel('Number of Data Points')
ylabel('Accuracy %')
%save('performance.mat','A','MM')