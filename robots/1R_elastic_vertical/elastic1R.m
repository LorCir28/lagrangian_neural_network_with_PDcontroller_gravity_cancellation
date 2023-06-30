% Based on:
%   dynamic model of 1R robot with joint elasticity
%   Lagrangian formulation in symbolic form
%   A. De Luca
%   23 March 2010

function [mdl,acc] = elastic1R()
    syms m d Im I k q th dq dth g0 tau ddq real

    % Dynamic model of 1R robot with elastic joint in the vertical plane **')

    % Kinetic energy of motor
    Tm=(1/2)*Im*dth^2;

    % Kinetic energy of link
    Tl=(1/2)*(I+m*d^2)*dq^2;

    % Robot kinetic energy
    T=simplify(Tm+Tl);
    T=collect(T,I+m*d^2);

    % Robot inertia matrix
    M(1,1)=diff(T,dth,2);
    M(2,2)=diff(T,dq,2);
    TempM12=diff(T,dq);
    M(1,2)=diff(TempM12,dth);
    M(2,1)=M(1,2);
    M=simplify(M);

    % Christoffel matrices
    qt=[th;q];
    m1=M(:,1);
    C1=(1/2)*(jacobian(m1,qt)+jacobian(m1,qt).'-diff(M,th));
    m2=M(:,2);
    C2=(1/2)*(jacobian(m2,qt)+jacobian(m2,qt).'-diff(M,q));

    % Robot Coriolis and centrifugal term
    dqt=[dth;dq];
    c1=dqt.'*C1*dqt;
    c2=dqt.'*C2*dqt;
    c=[c1;c2];

    % Potential (gravitational) energy of motor
    Um=0;

    % Potential (gravitational) energy of link
    Ul=-m*g0*d*cos(q);

    % Potential elastic energy (of joint)
    Ue=(1/2)*k*(q-th)^2;

    % Robot total potential energy
    U=simplify(Um+Ul+Ue);

    % Robot gravity+elasticity term
    G=jacobian(U,qt).';
    G=collect(G,k);
    G=simplify(G);

    % Robot external (rhs) torques**')
    u=[tau;0];

    disp("Intertia matrix");
    M
    disp("Coriolis and Centrifugal terms");
    c
    disp("Potential term");
    G
    disp("Commands");
    u

    disp("Model")
    mdl = M*ddq + c + G

    disp("Acceleration")
    acc = inv(M)*(-c-G)
end