function free_ev(samples,u_val,d_val,g0_val,m_val,I_val)
%
%   How system evolves without input
%   In console, to run function, vals = [u_val,d_val,g0_val,m_val,I_val] = deal(0,1,9.81,1,0.5)
%
    syms q qd qdd u d g0 I m real
    fileID = fopen('dataset.txt','w');
    wait_bar = waitbar(0,'1','Name','Creating dataset','CreateCancelBtn','setappdata(gcbf,''canceling'',1)');

    for i=1:samples
        q_i  = double(-pi + (pi+pi)*rand(1));    % q_i = Unif(-pi,pi)
        qd_i = double(-100 + (100+100)*rand(1)); % qd_i = Unif(-100,100)
        qdd_i = double(subs((u - d*g0*cos(q))/(I + d^2*m),[u d g0 q m I],[u_val d_val g0_val q_i m_val I_val]));

        sample = num2str(q_i)+" "+num2str(qd_i)+" "+num2str(qdd_i)+"\n";
        fprintf(fileID,sample);

        % Check for clicked Cancel button
        if getappdata(wait_bar,'canceling')
            break
        end
    
        % Update waitbar and message
        waitbar(i/samples,wait_bar,sprintf('%d/%d',i,samples))
    end
    fclose(fileID);
    delete(wait_bar)
end

