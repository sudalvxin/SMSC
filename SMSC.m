function [y_idx, Tobj] = SMSC(Ss,Fs,opts)

k = opts.k; % clusters

v = length(Ss);
[n, ~] = size(Ss{1});


for idx = 1:v
    Rs{idx} = Fs{idx}; 
    p(idx) = 1;
end

max_iter = 60;

for iter = 1:max_iter
    
    % Update Y
    T = zeros(n,k);
    for idx = 1:v
        Rt = Rs{idx};
        St = Ss{idx};
        temp = St*Rt;
        pt = p(idx)/sum(p);
        T = T + pt*temp;
    end
    Y = max(T/v,0);
    % Update R
    for idx = 1:v
        St = Ss{idx};
        temp = St'*Y;
        [Ur, ~, Vr] = svds(temp,k);
        Rs{idx} = Ur*Vr';   
    end
  % objective function
    obj = 0;
    for idx = 1:v
        Rt = Rs{idx};
        St = Ss{idx};
        temp = St - Y*Rt';
        p(idx) = 1/norm(temp,'fro');
        obj = obj + norm(temp,'fro')^2;
    end
    Tobj(iter) = obj;
    
    % convergence checking
    if iter>1
        temp_obj = Tobj(iter -1);
    else
        temp_obj = 0;
    end
    if abs(obj - temp_obj)/temp_obj <1e-8
        break;
    end
end
[non ,y_idx] = max(Y,[],2);
plot(Tobj)

