function [robot_model, robot_acc] = rigid_vertical_1R()
    %
    %   Compute the model of 1R robot with rigid joint
    %
    
    syms q qd qdd m d I g0 u real
    
    T = 1/2*(I+m*d^2)*qd^2;
    M = I + m*d^2;
    c = [0;0];
    U = -d*g0*sin(q);
    g = d*g0*cos(q);

    robot_model = M*qdd + g;
    robot_acc = inv(M)*(u-g);

    disp("I used this symbols: q qd qdd m d I g0 u")
    
end