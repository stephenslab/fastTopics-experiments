load('dat100x200.mat');
[W H obj time] = KLnmf(X,3,40,L0',F0',1);
W = W';
obj = obj/(100*200);
save('ccd100x200.mat','-v4','W','H','obj');