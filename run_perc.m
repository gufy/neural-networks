p=[1 3 -1];
xpos=[1 2 3; 1 3 1];
xneg=[3 4 4; 4 2 4];
x=[xpos xneg];
perm=[1 4 6 2 3 5];
x=x(:,perm)
c=[ones(1,3) zeros(1,3)];
c=c(perm)
xr=0:5;
%manually initialized perceptron
%training positive inputs, desired output 1
%training negative inputs, desired output 0
%permute the training smaples
%permute also the desired outputs
%plot the samples and the separating
%hyperplane of the perceptron
figure;
plot(xpos(1,:),xpos(2,:),'+r',xneg(1,:),xneg(2,:),'xb',xr,-(p(1)*xr+p(3))/p(2),'g');
[pn, num_epochs]=perc_learn(p,x,c,0.5,100);  %learn the perceptron and depict the result
figure;
plot(xpos(1,:),xpos(2,:),'+r',xneg(1,:),xneg(2,:),'xb',xr,-(pn(1)*xr+pn(3))/pn(2),'g');

fprintf('Minimum epochs: %d\n', num_epochs);
