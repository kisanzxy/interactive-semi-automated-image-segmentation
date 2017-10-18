close all
I1=load('BW123.mat');
I2=load('BW124.mat');
% response1=logical(I1);
% response2=logical(I2);
response1=I1.I;
response2=I2.I;
A1=load('Map123.mat');
A2=load('Map124.mat');
X1=A1.SRDistMap;
X2=A2.SRDistMap;
X=[X1;X2];
Y=[response1(:);response2(:)];
SVMModel= fitcsvm(X,Y,'ClassNames',[false true],'Standardize',true,...
        'KernelFunction','rbf','BoxConstraint',1);
[label,score] = predict(SVMModel,SRDistMap);
I=dicomread('4626.0125.dcm');
BW1=reshape(label,size(I));
BW1=imfill(BW1,'holes');
figure;
imshow(imoverlay(uint8(I),BW1,'cyan'),'InitialMagnification',300)
%calculate the area of the result
Num=length(find(BW1>0));
