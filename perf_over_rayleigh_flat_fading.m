%Perf. of PSK/QAM/PAM over Rayleigh flat fading(complex baseband)
%---------Input Fields------------------------
rng default % Default seed for pseudorandom bitstreams
nSym=10^6;%Number of symbols to transmit
EbN0dB = -10:1:20; % Eb/N0 range in dB for simulation
MOD_TYPE='QAM'; %Set PSK or QAM or PAM (FSK not supported)
switch lower(MOD_TYPE)
    case {'mpsk','psk','mpam','pam'}
        arrayOfM=[2,4,8,16,32];
    case {'mqam','qam'}
        arrayOfM=[16, 64, 128];
    otherwise
        disp 'perf_over_rayleigh_flat_fading.m: Invalid modulation (MOD_TYPE) selected.'
end
plotColor =['b','g','r','c','m','k']; 
p=1; % plot colors
legendString = cell(1,length(arrayOfM)*2); %for legend entries
for M = arrayOfM
    %-----Initialization of various parameters----
    k=log2(M); 
    EsN0dB = 10*log10(k)+EbN0dB; %EsN0dB calculation
    SER_sim = zeros(1,length(EbN0dB));%simulated Symbol error rates
    d=floor(M.*rand(1,nSym));%uniform random symbols from 1:M
    s=signal_mod(MOD_TYPE,M,d); %signal modulation
    % mean(abs(s).^2)
    for i=1:length(EsN0dB)
        h = 1/sqrt(2)*(randn(1,nSym)+1i*randn(1,nSym));%flat Rayleigh
        hs = abs(h).*s; %flat fading effect on the modulated symbols
        r = add_awgn(hs,EsN0dB(i)); %additive noise
        %---------------- Receiver ---------------------
        y = r./abs(h); %decision vector
        dCap = signal_demod(MOD_TYPE,M,y); %demodulation
        SER_sim(i) = sum((d~=dCap))/nSym;%SER computation
    end
    SER_theory = ser_rayleigh(EbN0dB,MOD_TYPE,M); %theoretical SER
    semilogy(EbN0dB,SER_sim,[plotColor(p) '*']); hold on;
    semilogy(EbN0dB,SER_theory,plotColor(p));
    legendString{2*p-1}=['Sim ' ,num2str(M),'-',MOD_TYPE];
    legendString{2*p}=['Theory ' ,num2str(M),'-',MOD_TYPE]; p=p+1;
end
grid on;
legend(legendString);xlabel('Eb/N0(dB)');ylabel('SER (Ps)');
title(['Probability of Symbol Error for M-',MOD_TYPE,' over Rayleigh flat fading channel']);
