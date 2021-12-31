% Generate modulated symbols effected by AWGN & Flat fading effect
% Comment the next line to get diffrent random symbols
rng default;
% Set modulation order
M = 16;
% Set the name of the dataset
filename = '16qam_train_dataset.txt';
% Set modulation M (FSK not supported) 
MOD_TYPE = 'QAM';
EbN0dB = -5:1:15;
% Number of symbols
SymNumber = 10^6;
columnsCell = {'label','real','imag'};
% Sampling rate
Nsamp = 4; 
k=log2(M);
% EsN0dB calculation
EsN0dB = 10*log10(k)+EbN0dB; 
% Uniform random symbols from 1:M
d=floor(M.*rand(1,SymNumber));
% Sample the original signal to extract the labels
labels =  rectpulse(d,Nsamp);
% Signal modulation
s=signal_mod(MOD_TYPE,M,d);
% Sample the modulated signal
sig_pulse = rectpulse(s,Nsamp);
legendString = cell(1,length(EbN0dB));
% for each EsN0(dB) noise level
writecell(columnsCell,filename);
for i=1:length(EsN0dB)
        ebno = ['EbN0_____ ',num2str(EsN0dB(i)-10*log10(k)),'dB ______'];
        disp(ebno)
        h = 1/sqrt(2)*(randn(1,SymNumber*Nsamp)+1i*randn(1,SymNumber*Nsamp)); %flat Rayleigh effect
        hs = abs(h).*sig_pulse; %flat fading effect on the modulated symbols (w/samples)
        r = add_awgn(hs,EsN0dB(i)); %additive noise for each EsN0dB value
        %-----------------Receiver----------------------
        % Extract the real part
        sigRealArray = real(r./abs(h)).';    
        % Extract the imaginary part
        sigImagArray = imag(r./abs(h)).'; 
        C = horzcat(labels.',sigRealArray,sigImagArray);
        writematrix(C,filename,'WriteMode','append');
        % Clear memory
        clear sigRealArray sigImagArray C;
        
end


