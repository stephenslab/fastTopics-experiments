% Run 40 CCD updates on 100 x 200 simulated data set.
% The MEX file was built using gcc 4.8.5 in MATLAB R2016a (9.0.0.341360)
% 64-bit (glnxa64). In other setups, you may need to rebuild the MEX file.
load('dat100x200.mat');
[W H obj time] = KLnmf(X,3,40,L0',F0',1);
W = W';
obj = obj/(100*200);
save('ccd100x200.mat','-v4','W','H','obj');