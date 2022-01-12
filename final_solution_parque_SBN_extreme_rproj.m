%% Proposed solution algoritm.
%% Algorithm that uses an artificial neural network (ANN) to estimate the WTG's grounding resistance through the clamp-on meter readings values. 
%% For the ANN to perform as expected, it is trained through computer simulations of the clamp-on meter method on a wind park electrical circuit using the aterrad3 function.

%% Entries and settings:
disp('Settings');
disp('   ');
disp('SBC`s WTG group selection:   ');
disp('SB13 => 1   ');
disp('OD15 SB09 => 2   ');
disp('OD04 SB10 SB11 => 3   ');
disp('OD11 OD12 OD13 => 4   ');
disp('OD14 SB15 SB14 => 5   ');
disp('OD10 OD09 OD08 OD07 SB12 OD06 OD05 => 6   ');
disp('OD01 SB01 SB02 SB03 SB05 SB04 OD02 OD03 SB06 SB08 SB07 => 7   ');
disp('   ')
grupo=input('Enter the WTG group number:    ');
disp('   ');
taxa_erro_max=input('Enter the maximum allowable absolute percent error for the clamp-on meter readings:   ');
disp('   ');
disp('Generate random Rf values for final ANN`s check => 1   ');
disp('Generate random and fixed (max & min) Rf values for final ANN`s check => 2   ');
disp('   ');
tipo_teste=input('Enter sampling type for final ANN`s check ...:   ');

if      grupo==1  %WTG: SB13
        RW=[1.1123]; 
        Rshuntcaboprojeto=[68.105 143.34];
        Lseriecaboprojeto=[0.000849887396 0.00022409016];
        Rseriecaboprojeto=[0.069 0.0184];
        lim_inf_proj=0;
        lim_sup_proj=2.5;
        lim_inf_test=1;
        lim_sup_test=2.5;
        Numero_aerogeradores=1;
        Numero_treinamento=100;

elseif  grupo==2 %WTG: OD15; SB09
        RW=[3.1659  2.4319]; 
        Rshuntcaboprojeto=[17.92  46.78  17.74];
        Lseriecaboprojeto=[0.000206264806  0.000812326893 0.003852822862];
        Rseriecaboprojeto=[0.0184  0.0667  0.3128];
        lim_inf_proj=0;
        lim_sup_proj=2.5;
        lim_inf_test=1;
        lim_sup_test=2.5;
        Numero_aerogeradores=2;
        Numero_treinamento=100;
        
elseif grupo==3  %WTG: OD04; SB10; SB11
        RW=[17.598  1.3877  1.2352];
        Rshuntcaboprojeto=[19.99  25.415  5.68  143.34];
        Lseriecaboprojeto=[0.00469825392  0.000930738107 0.000773493023 0.00022409016 ];
        Rseriecaboprojeto=[0.3722  0.0782  0.069  0.0184];
        lim_inf_proj=0;
        lim_sup_proj=2.5;
        lim_inf_test=1;
        lim_sup_test=2.5;
        Numero_aerogeradores=3;
        Numero_treinamento=100;
        
elseif grupo==4  %WTG: OD11 OD12 OD13
        RW=[12.994  15.479  0.4231]; 
        Rshuntcaboprojeto=[51.46  13.32  6.43  1.12];
        Lseriecaboprojeto=[0.001632929716  0.000668450761 0.001469636745 0.000180800015];
        Rseriecaboprojeto=[0.1311  0.0575 0.1311  0.0184];
        lim_inf_proj=0;
        lim_sup_proj=2.5;
        lim_inf_test=1;
        lim_sup_test=2.5;
        Numero_aerogeradores=3;
        Numero_treinamento=100;
        
elseif grupo==5 %WTG: OD14 SB15 SB14
        RW=[27.66 0.7353 6.4363]; 
        Rshuntcaboprojeto=[39.84  39.83  90.81 68.105];
        Lseriecaboprojeto=[0.001558126893  0.002177239621 0.000859436693 0.000849887396];
        Rseriecaboprojeto=[0.1265 0.1748 0.069  0.069];
        lim_inf_proj=0;
        lim_sup_proj=2.5;
        lim_inf_test=1;
        lim_sup_test=2.5;
        Numero_aerogeradores=3;
        Numero_treinamento=100;
            
elseif grupo==6 %WTG: OD10; OD09; OD08; OD07; SB12; OD06; OD05 
        RW=[12.139 0.342 1.422 20.59 4.457 45.224 3.8429]; 
        Rshuntcaboprojeto=[27.03 8.515 44.11 10.44 35.225 32.38 96.49 143.34];
        Lseriecaboprojeto=[0.002408014288980 0.000787816968305 0.000868349369509 0.000882355004501 0.001120450799 0.001232495879304 0.000802140913183 0.000224090159873];
        Rseriecaboprojeto=[0.1955 0.069 0.0713 0.0759 0.092 0.1012 0.0644 0.0184];
        if          tipo_teste==1
                    lim_inf_proj=0.44;
                    lim_sup_proj=2.5;
                    lim_inf_test=0.44;
                    lim_sup_test=2.5;
        else
                    lim_inf_proj=0.3;%
                    lim_sup_proj=2.5;
                    lim_inf_test=1;
                    lim_sup_test=2.5;
        end
        Numero_aerogeradores=7;
        Numero_treinamento=100;
        
elseif grupo==7 %WTG: OD01; SB01; SB02; SB03; SB05; SB04; OD02; OD03; SB06; SB08; SB07 
        RW=[2.392 1.8808 5.7783	0.2221	1.0471	1.0138	4.0268	0.8332	3.5515	0.6498	3.176];%(2.7-0.1)-(2.5-0.7)
        Rshuntcaboprojeto=[35.84 5.68 12.385 10.81 6.095  8.515  55.84 88.22 75.48 32.145 34.05 71.67];
        Lseriecaboprojeto=[0.000213904 0.000773493 0.000930261 0.000799594 0.002151775 0.000787817 0.00148969 0.000888085 0.001059972 0.001983071 0.000830789 0.000218997];
        Rseriecaboprojeto=[0.0184 0.069 0.0805 0.0736 0.184 0.069 0.1196 0.0713 0.0851 0.161 0.069 0.0184];
        if          tipo_teste==1
                    lim_inf_proj=0.44;
                    lim_sup_proj=2.5;   
                    lim_inf_test=0.44;
                    lim_sup_test=2.5;
        else
                    lim_inf_proj=0.11;
                    lim_sup_proj=2.7;
                    lim_inf_test=1;
                    lim_sup_test=2.5;
        end
        Numero_aerogeradores=11;
        Numero_treinamento=100;
else disp('Group doesnt exist!')
end
ENTRADA_REDE_NEURAL=ones(Numero_aerogeradores,Numero_treinamento); 
SAIDA_REDE_NEURAL=ones(Numero_aerogeradores,Numero_treinamento); 
verif=0;
while verif==0
i=1;
while i<Numero_treinamento+1
Rwtgprojeto=[];
RW_sup=RW.*lim_sup_proj;
RW_inf=RW.*lim_inf_proj;
cont=1;
while cont<(Numero_aerogeradores+1) 
    Rwtgprojeto(cont)=RW_inf(cont) + (RW_sup(cont)-RW_inf(cont)).*rand(1);
    cont=cont+1;
end
Zdimensao=length(Rwtgprojeto)+2*length(Rshuntcaboprojeto);
a=1;
b=1;
while b<length(Rshuntcaboprojeto)
    Z(a)=Rshuntcaboprojeto(b)*2;
    a=a+1;
    Z(a)=Rshuntcaboprojeto(b)*2;
    a=a+1;
    Z(a)=Rwtgprojeto(b);
    b=b+1;
    a=a+1;
end
Z(a)=Rshuntcaboprojeto(b)*2;
a=a+1;
Z(a)=Rshuntcaboprojeto(b)*2;
LCdimensao=Zdimensao-1;
LC=zeros(1,LCdimensao);
a=1;
b=1;
while b<length(Lseriecaboprojeto)+1
    LC(a)=Lseriecaboprojeto(b);
    a=a+3;
    b=b+1;
end
RCdimensao=LCdimensao;
RC=zeros(1,RCdimensao);
a=1;
b=1;
while b<length(Rseriecaboprojeto)+1
    RC(a)=Rseriecaboprojeto(b);
    a=a+3;
    b=b+1;
end
v=0.056;
FREQ=1572; 
RAT=[aterrad3(Z,RC,LC,FREQ,v)];
RES_MED_CLAMP=[];
c=length(Z);
a=1;
b=3;
while b<(length(Z)+1);
    RES_MED_CLAMP(a)=RAT(b);
    a=a+1;
    b=b+3;
end
ENTRADA_REDE_NEURAL(1:Numero_aerogeradores,i)=RES_MED_CLAMP;
SAIDA_REDE_NEURAL(1:Numero_aerogeradores,i)=Rwtgprojeto;
i=i+1;
end
[ENTRADA_REDE_NEURAL_NORM,norm_e]=mapminmax(ENTRADA_REDE_NEURAL);
[SAIDA_REDE_NEURAL_NORM,norm_s]=mapminmax(SAIDA_REDE_NEURAL);
    net=newff(minmax(ENTRADA_REDE_NEURAL_NORM),[Numero_aerogeradores],{'purelin'}, 'trainlm')
    net.trainparam.epochs=1000;
    net.trainparam.goal=1e-10;
    net.trainparam.lr=0.01;
    net.divideFcn='dividerand'; 
    net=train(net, ENTRADA_REDE_NEURAL_NORM, SAIDA_REDE_NEURAL_NORM);
teste=round(Numero_treinamento*0.1);
i=1;%contador de teste
while i<teste+1
Rtwgprojeto=[];
RW_sup=RW.*lim_sup_test; 
RW_inf=RW.*lim_inf_test; 
cont=1;
if tipo_teste==2
        if i<teste-1
        while cont<(Numero_aerogeradores+1)
        Rwtgprojeto(cont)=RW_inf(cont) + (RW_sup(cont)-RW_inf(cont)).*rand(1);
        cont=cont+1;
        end
    elseif i<teste
        Rwtgprojeto=RW_sup;
    else Rwtgprojeto=RW_inf;
end
elseif tipo_teste==1
    while cont<(Numero_aerogeradores+1)
    Rwtgprojeto(cont)=RW_inf(cont) + (RW_sup(cont)-RW_inf(cont)).*rand(1);
    cont=cont+1;
    end
else disp('ERRO');
end
Zdimensao=length(Rwtgprojeto)+2*length(Rshuntcaboprojeto);
a=1;
b=1;
while b<length(Rshuntcaboprojeto)
    Z(a)=Rshuntcaboprojeto(b)*2;
    a=a+1;
    Z(a)=Rshuntcaboprojeto(b)*2;
    a=a+1;
    Z(a)=Rwtgprojeto(b);
    b=b+1;
    a=a+1;
end
Z(a)=Rshuntcaboprojeto(b)*2;
a=a+1;
Z(a)=Rshuntcaboprojeto(b)*2;
LCdimensao=Zdimensao-1;
LC=zeros(1,LCdimensao);
a=1;
b=1;
while b<length(Lseriecaboprojeto)+1
    LC(a)=Lseriecaboprojeto(b);
    a=a+3;
    b=b+1;
end
RCdimensao=LCdimensao;
RC=zeros(1,RCdimensao);
a=1;
b=1;
while b<length(Rseriecaboprojeto)+1
    RC(a)=Rseriecaboprojeto(b);
    a=a+3;
    b=b+1;
end
v=0.056; 
FREQ=1572; 
RAT=[aterrad3(Z,RC,LC,FREQ,v)];
 RES_MED_CLAMP=[];
c=length(Z);
a=1;
b=3;
while b<(length(Z)+1);
    RES_MED_CLAMP(a)=RAT(b);
    a=a+1;
    b=b+3;
end
ENTRADA_REDE_NEURAL_TESTE(1:Numero_aerogeradores,i)=RES_MED_CLAMP;
SAIDA_REDE_NEURAL_TESTE(1:Numero_aerogeradores,i)=Rwtgprojeto;
i=i+1;
end
    X_teste=ENTRADA_REDE_NEURAL_TESTE;
    X_teste_norm=mapminmax('apply',X_teste,norm_e);
    Y_teste_norm=net(X_teste_norm);
    Y_teste=mapminmax('reverse',Y_teste_norm,norm_s);
    Y_teste;
    SAIDA_REDE_NEURAL_TESTE;

Erro=100*((Y_teste-SAIDA_REDE_NEURAL_TESTE)./SAIDA_REDE_NEURAL_TESTE)
Erro_modulo=abs(Erro);
Y=find(Erro_modulo>taxa_erro_max); 
verif=isempty(Y);
err=immse(Y_teste,SAIDA_REDE_NEURAL_TESTE)%
end
disp('Best ANN found')

%% End of program
