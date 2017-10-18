close all
clear all
import imroi.*
% G:\RA\SegeSamplePr\4631_original_labeled\4631.0117.dcm
filename=input('input the image name','s');
flag=input('0 as train data,1 as new input');
I1=dicomread(filename);
I=uint8(I1);
%use threshold
range=(I<15);
I(range)=0;
range=(I>180);
I(range)=255;
%**********************
figure;
imshow(uint8(I),[50,225],'InitialMagnification' ,300);
h=imfreehand;
BW=createMask(h);
% [x1, y1, BW, xi, yi]=roipoly;
SR=zeros(size(I));
% SRmean=zeros(size(I));
% SRstd=zeros(size(I));
SR(BW>0)=I(BW>0);
%Calculate mean and std of the Seed Region
% [L1,N1]=superpixels(SR,4000);
% IndexList = label2idx(L1);
% for labval=1:N1
%     idx2=IndexList{labval};
%     if SR(idx2)>0
%         SRmean(idx2)=mean(SR(idx2));
%         SRstd(idx2)=std(SR(idx2));
%     end
% end
% 
if flag==0
    IThresh=multithresh(SR,6);
%     IThresh=multithresh(SR,5);
else    
  IThresh=multithresh(SR,6);
  %     IThresh=multithresh(SR,6);
end
Iquant=imquantize(SR,IThresh);
%Initial maps
SRcolormap=zeros(size(I));
% Meanmap=zeros(size(I));
% stdmap=zeros(size(I));
GeoDistMap=true(size(I));
SRcolormap=Iquant;

figure;
imshow(uint8(I),[100,190],'InitialMagnification' ,300);
% 
% [x1, y1, BW2, xi, yi]=roipoly;
h2=imfreehand;
BWG=createMask(h);

GeoDistMap=double(bwdistgeodesic(GeoDistMap,BWG));

SRDistMap=[SRcolormap(:),GeoDistMap(:),SR(:)];
% SRDistMap=[SRcolormap(:)];
