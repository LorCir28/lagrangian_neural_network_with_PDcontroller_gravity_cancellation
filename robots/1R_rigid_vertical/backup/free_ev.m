function dataset = free_ev()
%
%   How system evolves without input
%
    syms q qd qdd u d g0 I m real
    rounds = 100;
    dataset = zeros(rounds,3);
    inputs = zeros(1,2);
    outputs = 0;

    for i=1:rounds
        q_i  = -pi + (pi+pi)*rand(1);    % q_i = Unif(-pi,pi)
        qd_i = -100 + (100+100)*rand(1); % qd_i = Unif(-100,100)
        qdd_i = subs((u - d*g0*cos(q))/(I + d^2*m),[u d g0 q m I],[0 1 9.81 q_i 1 0.5]);

        inputs(1) = q_i;
        inputs(2) = qd_i;
        outputs = qdd_i;

        dataset(i,1) = inputs(1);
        dataset(i,2) = inputs(2);
        dataset(i,3) = outputs;
    end

    fileID = fopen('dataset.txt','w');
    
    
    for i=1:rounds
        sample = num2str(dataset(i,1))+" "+num2str(dataset(i,2))+" "+num2str(dataset(i,3))+"\n";
        fprintf(fileID,sample);
    end
    fclose(fileID);
end

