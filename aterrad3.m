function [RAT]=aterrad3(Z,RC,LC,FREQ,v)

%Fun��o para c�lculo dos valores de imped�ncia a serem obtidos atrav�s o uso do alicate terrometro
%junto ao cabo de descida do aterramento de cada malha do circuito de medi��o, a partir do fornecimento dos valores
%individuais de imped�ncia de cada malha de aterramento.

% Dados de entrada:
%Z = Vetor contendo todos os valores das imped�ncias individuais das
%malhas de aterramento e das imped�ncias shunt interligadas em cascata;
%LC= Vetor contendo todos os valores de indutancia dos cabos de
%interliga��o das malhas;
%RC= Vetor contendo todos os valores de resistencias serie dos cabos de
%interliga��o das malhas;

%v = Entrada do m�dulo da tens�o senoidal gerada (injetada) pelo instrumento(Vpp)no circuito de medi��o;
%FREQ = frequencia do sinal injetado pelo alicate terrometro no circuito de
%medi��o;


%% Inicio do programa:

nz=length(Z);%n�mero de malhas de corrente do circuito;elementos da matriz Z;

% Vetor LC deve conter 'nz'-1 elementos;
if length(LC)+1~=nz %condi��o para rodar function
    disp('N�mero de elementos do vetor LC tem que ser igual ao n�mero de elementos do vetor Z menos 1')
else
end
    
    % Vetor RC deve conter 'nz'-1 elementos;
if length(RC)+1~=nz %condi��o para rodar function
    disp('N�mero de elementos do vetor RC tem que ser igual ao n�mero de elementos do vetor Z menos 1')
else
end
    
    %evita erros com entrada de resist�ncias (parte real) negativas
    Z=abs(real(Z))+imag(Z)*i;
    RC=abs(RC);
    LC=abs(LC);

    %% CRIANDO O VETOR IMPEDANCIA DO CABO CONTRA PESO.
    ZC=ones(1,nz-1);
    x=1;
    while x<nz
        ZC(x)=RC(x)+2*pi*FREQ*LC(x)*i;
        x=x+1;
    end
    
    
%% C�lculo da diagonal principal da matriz imped�ncia;
ZD=ones(1,nz-1);
u=1;
while ZD(u)==1 && u<nz-1;
      ZD(u)=Z(u)+Z(u+1)+ZC(u);
      u=u+1;
end
ZD(nz-1)=Z(nz)+Z(nz-1)+ZC(nz-1);

%C�lculo das diagonais laterais (+-1) da matriz imped�ncia;
ZDL=ones(1,nz-2);
u=1;
while ZDL(u)==1 && u<nz-2;
      ZDL(u)=Z(u+1);
      u=u+1;
end
ZDL(nz-2)=Z(nz-1);

%Montagem da matriz imped�ncia
ZT=diag(ZD)+diag(-ZDL,1)+diag(-ZDL,-1);
ZTI=inv(ZT); %prepara��o para opera��o de divis�o com a tens�o da malha do circuito;


%Matriz Tens�o - Montagem da matriz
VD=ones(1,nz-1)*v; 
VDL=ones(1,nz-2)*-v;
V=diag(VD)+diag(VDL,1);
VT=zeros(nz-1,nz);
VT(1:nz-1,1:nz-1)=V;
VT(nz-1,nz)=-v;
V=VT;

% C�lculo das correntes de malha do circuito (vetor com nz elementos)
IS=ones(nz-1);
x=1;
V1=V(1:nz-1,x); %x=n�mero da coluna na matriz tens�o
while x~=nz-1;
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

%C�lculo das correntes que ser�o lidas pelo alicate terrometro
x=1;
y=1;
c1=IS(y,x);
C=ones(1,nz);
C(x)=c1;
x=2;
while x~=nz-1;
c=IS(y+1,x)-IS(y,x);
C(x)=c ;
x=x+1;
y=y+1;
end
c=IS(y+1,x)-IS(y,x);
C(x)=c ;
C(1,nz)=IS(nz-1,nz); %Vetor linha que cont�m as correntes que ser�o lidas nos pontos de medi��o;



%C�lculo das imped�ncias a serem medidas pelo alicate terr�metro (Z1 a Zn);
ZAT=v./C %Valor da imped�ncia lida pelo alicate terr�metro no ponto de medi��o de Z1 a Zn;
RAT=sqrt((real(ZAT)).^2+(imag(ZAT)).^2)% Valor do m�dulo da imped�ncia lida pelo alicate terr�metro; 
%ou seja a resist�ncia que aparecer� no display do equipamento em cada
%posi��o de medi��o de Z1 a Zn;

% Valores do m�dulo da imped�ncia das malhas de aterramento;
ZM=sqrt((real(Z)).^2+(imag(Z)).^2)

% %Etapa gr�fica
% bar(1:nz,RAT,0.5,'y'); 
% hold on;
% grid on;
% bar(1:nz,ZM,0.5,'b');
% xlabel({'Malha de aterramento'}); 
% ylabel({'|Z| (ohms)'});
% title({'Imped�ncias x Pto. medi��o'});
% legend('|Z| clamp-on','|Z| malha de aterramento ')
% hold off;


end
