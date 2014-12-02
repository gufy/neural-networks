format short

w_i_h = [ 1.40000 0.40000
        -2.00000 0.80000];

w_h_o = [2.30000 -1.00000];

b_h = [ 0.00000
        -0.50000];

b_o = 0.40000;

w_i_hb=[w_i_h b_h]

w_h_ob=[w_h_o b_o]

p1=[-1; 1];

p2=[1; -1];

out2 = w_i_hb * [p1; 1];
out1 = logsig(out2);
o1 = logsig(w_h_ob * [out1; 1])
y = o1;

%out1 = logsig(w_i_hb * [p2; 1])
%o2 = logsig(w_h_ob * [out1; 1])

%%


e = (1/2)*(y - 0.9)^2;
e

%%

lambda = 0.2;
d = 0.9;

delta_o = (d - y) * y * (1 - y)
delta_h = (delta_o * w_h_ob) .* ([out1; 1] .* (1 - [out1; 1]))'

w_h_ob = w_h_ob + lambda*delta_o*[out1; 1]';
display(w_h_ob);

w_i_hb = w_i_hb + lambda*delta_h(1:2)'*[p1; 1]';
display(w_i_hb);


%%

out1_2 = logsig(w_i_hb * [p1; 1])
o1_2 = logsig(w_h_ob * [out1_2; 1])
y2 = o1_2;

e = (1/2)*(y2 - 0.9)^2;
e

y - y2


%%

lambda = 0.2;
max_it = 1000;
X = [p1, p1, p1];
outputs = [0.9, 0.9, 0.9];

for i = 1:max_it
    for k = 1:size(X,2)
        
        x = X(:,k);
        output = outputs(k);
        
        out2 = w_i_hb * [x; 1];
        out1 = logsig(out2);
        o1 = logsig(w_h_ob * [out1; 1]);
        y = o1;

        e = (1/2)*(y - output)^2;

        delta_2 = (output - y) * y * (1 - y);
        delta_1 = (delta_2 * w_h_ob) .* ([out1; 1] .* (1 - [out1; 1]))';
        
        w_h_ob = w_h_ob + lambda*delta_2*[out1; 1]';
        w_i_hb = w_i_hb + (lambda*out2*delta_1);
        
    end
end

out1 = logsig(w_i_hb * [p1; 1]);
o1 = logsig(w_h_ob * [out1; 1]);
y = o1;

e = (1/2)*(y - 0.9)^2;

fprintf('Final error: %d\n', e);
