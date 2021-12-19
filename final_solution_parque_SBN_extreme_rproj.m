%% Solução final do mestrado. Avalia um grupo de X aerogeradores do parque eólico São Bento.
%% Entra com o número de ciclos para geração de valores aleatórios de entrada Rproj na solução analitica desenvolvida ATERRAD3, calculando para cada conjunto de entrada aleatórios os valores Rmed a serem medidos com o alicate terrômetro.
%% Utiliza o banco de dados gerados anteriormente (Rmed) para entrada de uma rede neural executando seu treinamento
%% Utiliza o banco de dados resultante da solução analitica (Rprojs) como as saídas para treinamento de uma rede neural 
%% Ao final realiza um teste sob dados Reais de projeto do grupo 1 de 5 aerogeradores do Parque São Bento e Olho Dagua


%% Limpeza
clc
clear all


%% Cabeçalho e configuração:

%Dados de projeto de aerogeradores do Parque Eólico São Bento do Sul

disp('Configurações');
disp('   ');
disp('Grupo de aerogeradores do Parque São Bento do Norte:   ');
disp('SB13 => 1   ');
disp('OD15 SB09 => 2   ');
disp('OD04 SB10 SB11 => 3   ');
disp('OD11 OD12 OD13 => 4   ');
disp('OD14 SB15 SB14 => 5   ');
disp('OD10 OD09 OD08 OD07 SB12 OD06 OD05 => 6   ');
disp('OD01 SB01 SB02 SB03 SB05 SB04 OD02 OD03 SB06 SB08 SB07 => 7   ');
disp('   ')
grupo=input('Entre com o número do grupo de aerogeradores:    ');
disp('   ');
taxa_erro_max=input('Entre com a percentagem máxima para o erro de medição:    ');
disp('   ');
disp('Teste 100% aleatório Rf (distribuição uniforme) => 1   ');
disp('Teste aleatório Rf (distribuição uniforme) + valores extremos Rf (melhor e pior caso) => 2   ');
disp('   ');
tipo_teste=input('Entre com o tipo de teste final da rede neural    ');

%% Etapa de escolha do grupo de aerogeradores
if      grupo==1  %WTG: SB13
        RW=[1.1123]; %start inicial de valores usamos as resistencias de projeto dos aerogeradores .
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
        RW=[3.1659  2.4319]; %start inicial de valores usamos as resistencias de projeto dos aerogeradores .
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
        RW=[17.598  1.3877  1.2352]; %start inicial de valores usamos as resistencias de projeto dos aerogeradores .
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
        RW=[12.994  15.479  0.4231]; %start inicial de valores usamos as resistencias de projeto dos aerogeradores .
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
        RW=[27.66 0.7353 6.4363]; %start inicial de valores usamos as resistencias de projeto dos aerogeradores .
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
        RW=[12.139 0.342 1.422 20.59 4.457 45.224 3.8429]; %start inicial de valores usamos as resistencias de projeto dos aerogeradores .
        Rshuntcaboprojeto=[27.03 8.515 44.11 10.44 35.225 32.38 96.49 143.34];
        Lseriecaboprojeto=[0.002408014288980 0.000787816968305 0.000868349369509 0.000882355004501 0.001120450799 0.001232495879304 0.000802140913183 0.000224090159873];
        Rseriecaboprojeto=[0.1955 0.069 0.0713 0.0759 0.092 0.1012 0.0644 0.0184];
        if          tipo_teste==1
                    lim_inf_proj=0.44;%valor mínimo das amostras para treinamento RNA
                    lim_sup_proj=2.5;%valor máximo das amostras para treinamento RNA    
                    lim_inf_test=0.44;%valor mínimo das amostras de teste
                    lim_sup_test=2.5;%valor máximo das amostras de teste
        else
                    lim_inf_proj=0.3;%valor mínimo das amostras para treinamento RNA
                    lim_sup_proj=2.5;%valor máximo das amostras para treinamento RNA 
                    lim_inf_test=1;%valor mínimo das amostras de teste
                    lim_sup_test=2.5;%valor máximo das amostras de teste
        end
        Numero_aerogeradores=7;
        Numero_treinamento=100;
        
elseif grupo==7 %WTG: OD01; SB01; SB02; SB03; SB05; SB04; OD02; OD03; SB06; SB08; SB07 
        RW=[2.392 1.8808 5.7783	0.2221	1.0471	1.0138	4.0268	0.8332	3.5515	0.6498	3.176];%(2.7-0.1)-(2.5-0.7)
        Rshuntcaboprojeto=[35.84 5.68 12.385 10.81 6.095  8.515  55.84 88.22 75.48 32.145 34.05 71.67];
        Lseriecaboprojeto=[0.000213904 0.000773493 0.000930261 0.000799594 0.002151775 0.000787817 0.00148969 0.000888085 0.001059972 0.001983071 0.000830789 0.000218997];
        Rseriecaboprojeto=[0.0184 0.069 0.0805 0.0736 0.184 0.069 0.1196 0.0713 0.0851 0.161 0.069 0.0184];
        if          tipo_teste==1
                    lim_inf_proj=0.44;%valor mínimo das amostras para treinamento RNA 
                    lim_sup_proj=2.5;%valor máximo das amostras para treinamento RNA         
                    lim_inf_test=0.44;%valor mínimo das amostras de teste 
                    lim_sup_test=2.5;%valor máximo das amostras de teste
        else
                    lim_inf_proj=0.11;%valor mínimo das amostras para treinamento RNA
                    lim_sup_proj=2.7;%valor máximo das amostras para treinamento RNA
                    lim_inf_test=1;%valor mínimo das amostras de teste
                    lim_sup_test=2.5;%valor máximo das amostras de teste
        end
        Numero_aerogeradores=11;
        Numero_treinamento=100;
else disp('Este grupo não existe')
end
    
ENTRADA_REDE_NEURAL=ones(Numero_aerogeradores,Numero_treinamento); %matriz que armazenará os resultados do treinamento;
SAIDA_REDE_NEURAL=ones(Numero_aerogeradores,Numero_treinamento); %matriz que armazenará os resultados do treinamento;

verif=0;

while verif==0
    
i=1;%contador de treinamento
while i<Numero_treinamento+1
Rwtgprojeto=[];
RW_sup=RW.*lim_sup_proj; %limite superior sensibilidade
RW_inf=RW.*lim_inf_proj; %limite inferior sensibilidade
cont=1;
while cont<(Numero_aerogeradores+1) %gera um array com  valores aleatórios para as Resistências de projeto;
    Rwtgprojeto(cont)=RW_inf(cont) + (RW_sup(cont)-RW_inf(cont)).*rand(1);
    cont=cont+1;
end
    
%% Preenchimento do vetor Z para entrada na função ATERRAD3
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

%% Preenchimento do vetor LC para entrada na função ATERRAD3
LCdimensao=Zdimensao-1;
LC=zeros(1,LCdimensao);
a=1;
b=1;
while b<length(Lseriecaboprojeto)+1
    LC(a)=Lseriecaboprojeto(b);
    a=a+3;
    b=b+1;
end

%% Preenchimento do vetor RC para entrada na função ATERRAD3
RCdimensao=LCdimensao;
RC=zeros(1,RCdimensao);
a=1;
b=1;
while b<length(Rseriecaboprojeto)+1
    RC(a)=Rseriecaboprojeto(b);
    a=a+3;
    b=b+1;
end

v=0.056; % definição da tensão do alicate terrometro
FREQ=1572; % definição da frequencia de injeção do sinal do alicate terrometro

%% Function aterrad 3
RAT=[aterrad3(Z,RC,LC,FREQ,v)];

%% Etapa de extração das resistências de aterramento que serão medidas nos aerogeradores
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
%% Normalização dos dados entre -1 e 1 para insersão na rede neural;

[ENTRADA_REDE_NEURAL_NORM,norm_e]=mapminmax(ENTRADA_REDE_NEURAL);
[SAIDA_REDE_NEURAL_NORM,norm_s]=mapminmax(SAIDA_REDE_NEURAL);

%% Etapa de programação da rede neural:
    net=newff(minmax(ENTRADA_REDE_NEURAL_NORM),[Numero_aerogeradores],{'purelin'}, 'trainlm')
    net.trainparam.epochs=1000;
    net.trainparam.goal=1e-10;
    net.trainparam.lr=0.01;
    net.divideFcn='dividerand'; 
    
    net=train(net, ENTRADA_REDE_NEURAL_NORM, SAIDA_REDE_NEURAL_NORM); %treinamento rede


%% Etapa de teste da rede neural.

teste=round(Numero_treinamento*0.1);% Teste com 10% do número de ciclos de treinamento da rede neural.
i=1;%contador de teste
while i<teste+1

  
%% Geração de valores teste variando em de -56% a +150% o valores das Resis. aterra. do projeto - quanto um projeto é confiavel 
Rtwgprojeto=[];

RW_sup=RW.*lim_sup_test; %limite superior dos valores de projeto - estudo de sensibilidade
RW_inf=RW.*lim_inf_test; %limite inferior dos valores de projeto - estudo de sensibilidade
cont=1;

%Escolha do tipo de teste: 1- 100% amostras aleatórias  -----   2- Amostas
%aleatórias + limite superior e limite inferior de todas as resistências
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

%% Preenchimento do vetor Z para entrada na função ATERRAD3
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

%% Preenchimento do vetor LC para entrada na função ATERRAD3
LCdimensao=Zdimensao-1;
LC=zeros(1,LCdimensao);
a=1;
b=1;
while b<length(Lseriecaboprojeto)+1
    LC(a)=Lseriecaboprojeto(b);
    a=a+3;
    b=b+1;
end

%% Preenchimento do vetor RC para entrada na função ATERRAD3
RCdimensao=LCdimensao;
RC=zeros(1,RCdimensao);
a=1;
b=1;
while b<length(Rseriecaboprojeto)+1
    RC(a)=Rseriecaboprojeto(b);
    a=a+3;
    b=b+1;
end

v=0.056; % definição da tensão do alicate terrometro
FREQ=1572; % definição da frequencia de injeção do sinal do alicate terrometro

%% Function aterrad 3
RAT=[aterrad3(Z,RC,LC,FREQ,v)];

%% Etapa de extração das resistências de aterramento que serão medidas nos aerogeradores
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
Y=find(Erro_modulo>taxa_erro_max); %Aqui coloca a maxima taxa de erro permitida 
verif=isempty(Y);%enquanto tiver algum erro acima disso na matriz, verif assume 0
%std(Erro(:));
err=immse(Y_teste,SAIDA_REDE_NEURAL_TESTE)%calcula o erro quadrático médio (MSE) entre os arrays
end
disp('Erros de medição abaixo de 10% - Rede Neural encontrada')
