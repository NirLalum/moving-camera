 %% define parameters
clc; clear all;
m = 0.1*10^(-3); %[kg]
Tem = 10^(-4); %[N/V] 
k= 1*10^3; %[N/m]
c= 1*10^(-2); %[Ns/m]
Vmax= 100; %[V]
l= 280*10^(-6); %[m]
J= 0.1*10^(-3); %[km*m^2]
ca= 5*10^(-3); %[Nm/(rad/sec)]
N = 5;
%%
A=[0 0 0 0 0 1 0 0 0 0;
   0 0 0 0 0 0 1 0 0 0;
   0 0 0 0 0 0 0 1 0 0;
   0 0 0 0 0 0 0 0 1 0;  
   0 0 0 0 0 0 0 0 0 1;
   (-2*k/m) k/m 0 0 0 (-2*c/m) c/m 0 0 0;
   k/m (-2*k/m) k/m 0  0 c/m (-2*c/m) c/m 0 0;
   0 k/m (-2*k/m) k/m 0 0 c/m (-2*c/m) c/m 0;
   0 0 k/m (-2*k/m) k/m 0 0 c/m (-2*c/m) c/m;
   0 0 0 k/m -k/m 0 0 0 c/m -c/m];
B=[0 0;0 0;0 0;0 0;0 0;0 0;0 0;0 0;0 0;Tem/m -1/m];
C=[0 0 0 0 1 0 0 0 0 0];
D=[0 0];



% u1=V
% u2=F
I=eye(10);
s=tf('s');
P=C*inv(s*I-A)*B+D
%sysr = minreal(P)
Pv_x=P([1,;]); % V -> X
Pf_x=P([2,;]); % F -> X
bode(Pv_x)
grid on

Px_f = -(2*ca*s+2*J*s^2)/l^2;
Pf_tot = Px_f*Pf_x;

Pv_theta = (Pv_x)*(N/(1-N*Pf_tot))*(1/l);

bode(Pv_theta)
grid on


