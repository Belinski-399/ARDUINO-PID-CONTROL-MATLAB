
%%Let's first look at the open loop step response.
s = tf('s');
P = 1/(0.22*s^2 + 2.52*s + 1);
step(P)

%{
 %%From the table shown above, we see that the proportional controller ( $K_p$) reduces the rise time, increases the overshoot and reduces the steady-state error.

%%The closed-loop transfer function of our unitary feedback system with a proportional controller is as follows, where X(s)is our output (equals Y(s)a ) and our reference R(s)is the input:
Kp = 300; 
C = pid(Kp) 
T = feedback(C*P,1) 

t = 0:0,01:2; 
passo(T,t)
%}
%{
%%Now, let's take a look at the PD control. From the table shown above, we see that the addition of the derivative control ( Kd) tends to reduce both the overshoot and the settling time. The closed loop transfer function of the given system with a PD controller is:
Kp = 300;
Kd = 10; 
C = pid(Kp,0,Kd) 
T = feedback(C*P,1) 

t = 0:0,01:2; 
passo(T,t)
%}
%{
%%Before proceeding with PID control
let's investigate the PI control.
From the table, we see that adding integral control (Ki) tends to decrease the rise time
  increase both overshoot and settling time and reduce steady-state error.
%%For the given system, the closed loop transfer function with a PI controller
Kp = 30; 
Ki = 70; 
C = pid(Kp,Ki) 
T = feedback(C*P,1) 

t = 0:0,01:2; 
passo(T,t)
%}

%%Now, let's examine the PID control. The closed loop transfer function of the given system with a PID controller
%%After several iterations of adjustment, the gains Kp= 350, Ki= 300 and Kd= 50 provided the desired answer.
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
