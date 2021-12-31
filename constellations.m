% Set random generator
rng default
% Set Modulation Type
MOD_TYPE = 'QAM';
M = [16, 64, 128];
for i=1:length(M)
    M_iter = M(i);
    x = randi([0 M(i)-1],10^5,1)';
    signal_mod(MOD_TYPE,M_iter,x);
end
