function [RAT]=aterrad3(Z,RC,LC,FREQ,v)

% Function created in Matlab to calculate the values of the readings to be obtained using the clamp on the cable down to the WTG grounding systems, 
% from the values of the impedance of each ground loop and the WTG grounding impedances;

% Input parameters:
%Z = Vector containing the grounding impedances of the measuring circuit;
%LC= Vector containing the horizontal electrodes self inductances of the measuring circuit;
%RC= Vector containing the horizontal electrodes self resistances of the measuring circuit;
%v = Voltage amplitude injected by the clamp-on in the measurement circuit;
%FREQ = Clamp-on meter operation frequency;

% Output parameter:
% RAT = Clamp-on meter readings on the cable down to the WTGs groundings of the measuring circuit;

%% Program start:
nz=length(Z);
if  length(LC)+1~=nz 
    disp('LC ERROR')
    else
end
if  length(RC)+1~=nz 
    disp('RC ERROR')
    else
end
Z=abs(real(Z))+imag(Z)*i;
RC=abs(RC);
LC=abs(LC);
ZC=ones(1,nz-1);
x=1;
while   x<nz
        ZC(x)=RC(x)+2*pi*FREQ*LC(x)*i;
        x=x+1;
end
ZD=ones(1,nz-1);
u=1;
while   ZD(u)==1 && u<nz-1;
        ZD(u)=Z(u)+Z(u+1)+ZC(u);
        u=u+1;
end
ZD(nz-1)=Z(nz)+Z(nz-1)+ZC(nz-1);
ZDL=ones(1,nz-2);
u=1;
while   ZDL(u)==1 && u<nz-2;
        ZDL(u)=Z(u+1);
        u=u+1;
end
ZDL(nz-2)=Z(nz-1);
ZT=diag(ZD)+diag(-ZDL,1)+diag(-ZDL,-1);
ZTI=inv(ZT);
VD=ones(1,nz-1)*v; 
VDL=ones(1,nz-2)*-v;
V=diag(VD)+diag(VDL,1);
VT=zeros(nz-1,nz);
VT(1:nz-1,1:nz-1)=V;
VT(nz-1,nz)=-v;
V=VT;
IS=ones(nz-1);
x=1;
V1=V(1:nz-1,x); 
while   x~=nz-1;
        I=ZTI*V1;
        IS(1:nz-1,x)=I;
        x=x+1;
        V1=V(1:nz-1,x);
end
x=nz-1;
I=ZTI*V1;
IS(1:nz-1,x)=I;
x=nz;
V1=V(1:nz-1,x);
I=-(ZTI*V1);
IS(1:nz-1,x)=I;
x=1;
y=1;
c1=IS(y,x);
C=ones(1,nz);
C(x)=c1;
x=2;
while   x~=nz-1;
        c=IS(y+1,x)-IS(y,x);
        C(x)=c ;
        x=x+1;
        y=y+1;
end
c=IS(y+1,x)-IS(y,x);
C(x)=c ;
C(1,nz)=IS(nz-1,nz); 
ZAT=v./C %;
RAT=sqrt((real(ZAT)).^2+(imag(ZAT)).^2);
end
%% Program end;
