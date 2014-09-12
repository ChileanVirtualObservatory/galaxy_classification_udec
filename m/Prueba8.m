
%    Código generado para trabajo de memoria de título
%  "Clasificacion de Galaxias mediante Machine Learning"
%    por Gabriel Salazar Vergara <lsalazarv@udec.cl>

clc; clear all;

file='MainSample.csv';
M=csvread(file);  %%M matriz de los datos csv


%%%%%FIJOS%%%%%%
objID = M(:,1)';
[f, c] = size(M);

for i=1:f
    if M(i,34) >= 0.8 %%espiral
        B(i,1)=1;
    else B(i,1)=0;
    end
    if M(i,31) >= 0.8 %%eliptica
        B(i,2)=1;
    else B(i,2)=0;
    end
    if M(i,32) >= 0.8 %%uncertain/dont known
        B(i,3)=1;
    else B(i,3)=0;
    end
end
        
espiral = B(:,1)';
eliptica = B(:,2)';
uncertain = B(:,3)';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
u_g = M(:,2) - M(:,3);
g_r = M(:,3) - M(:,4);
r_i = M(:,4) - M(:,5);
i_z = M(:,5) - M(:,6);

ug = (u_g)';
gr = (g_r)';
ri = (r_i)';
iz = (i_z)';

%%%%%%%%%%%%%%Concentracion Petrosian%%%%%%%%%%%%%%%%%%
ConcPetro_u = M(:,8)./M(:,7);
ConcPetro_r = M(:,20)./M(:,19);

Conc_u = (ConcPetro_u)';
Conc_r = (ConcPetro_r)';

%%%%%%%%%%%%%%%%%Elipticidad%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a_u= (1 - sqrt((M(:,9).^2)+(M(:,10).^2)));
b_u = (1 + sqrt((M(:,9).^2)+(M(:,10).^2)));
c_u= a_u./b_u;
d_u = c_u.^(1/2);
e_u= real(d_u);
aE_u= 1 - e_u;

a_r= (1 - sqrt((M(:,21).^2)+(M(:,22).^2)));
b_r = (1 + sqrt((M(:,21).^2)+(M(:,22).^2)));
c_r= a_r./b_r;
d_r = c_r.^(1/2);
e_r= real(d_r);
aE_r= 1 - e_r;

a_Eu = (aE_u)';
a_Er = (aE_r)';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


deVAB_u = M(:,11)';
expAB_u = M(:,12)';
lnLExp_u = M(:,13)';
lnLDeV_u = M(:,14)';
lnLStar_u = M(:,15)';
mRrCc_u = M(:,16)';
mCr4_u = M(:,17)';
texture_u = M(:,18)';

deVAB_r = M(:,23)';
expAB_r = M(:,24)';
lnLExp_r = M(:,25)';
lnLDeV_r = M(:,26)';
lnLStar_r = M(:,27)';
mRrCc_r = M(:,28)';
mCr4_r = M(:,29)';
texture_r = M(:,30)';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Y_u = [gr; ri; deVAB_r; expAB_r; lnLExp_r; lnLDeV_r; lnLStar_r; Conc_r; mRrCc_r; a_Er; mCr4_r];

Y_salida = [espiral; eliptica; uncertain];

csvwrite('completotext_r.csv',Y_u');
csvwrite('salida.csv',Y_salida');
