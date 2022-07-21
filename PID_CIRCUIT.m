
%%Vamos primeiro ver a resposta ao degrau em malha aberta.
s = tf('s');
P = 1/(0.22*s^2 + 2.52*s + 1);
step(P)

%{
 partir da tabela mostrada acima, vemos que o controlador proporcional ( $K_p$) reduz o tempo de subida, aumenta o overshoot e reduz o erro em regime permanente.

A função de transferência de malha fechada do nosso sistema de feedback unitário com um controlador proporcional é a seguinte, onde X(s)é nossa saída (igual Y(s)a ) e nossa referência R(s)é a entrada:
Kp = 300; 
C = pid(Kp) 
T = feedback(C*P,1) 

t = 0:0,01:2; 
passo(T,t)
%}
%{
Agora, vamos dar uma olhada no controle PD. A partir da tabela mostrada acima, vemos que a adição do controle derivativo ( $K_d$) tende a reduzir tanto o overshoot quanto o tempo de acomodação. A função de transferência em malha fechada do sistema dado com um controlador PD é:
Kp = 300; 
Kd = 10; 
C = pid(Kp,0,Kd) 
T = feedback(C*P,1) 

t = 0:0,01:2; 
passo(T,t)
%}
%{
Antes de prosseguir com o controle PID
vamos investigar o controle PI. 
A partir da tabela, vemos que a adição de controle integral ( Ki) tende a diminuir o tempo de subida
 aumentar tanto o overshoot quanto o tempo de estabilização e reduzir o erro em regime permanente. 
Para o sistema dado, a função de transferência em malha fechada com um controlador PI
Kp = 30; 
Ki = 70; 
C = pid(Kp,Ki) 
T = feedback(C*P,1) 

t = 0:0,01:2; 
passo(T,t)
%}

%%Agora, vamos examinar o controle PID. A função de transferência em malha fechada do sistema dado com um controlador PID
%%Após várias iterações de ajuste, os ganhos Kp= 350, Ki= 300 e Kd= 50 forneceram a resposta desejada.
Kp = 350;
Ki = 300;
Kd = 50;
C = pid(Kp,Ki,Kd)
T = feedback(C*P,1);

t = 0:0.01:2;
step(T,t)
pidTuner(P,C)
opts = pidtuneOptions( 'CrossoverFrequency' ,32, 'PhaseMargin' ,90); 
[C, info] = pidtune(P, 'pid' , opts)
