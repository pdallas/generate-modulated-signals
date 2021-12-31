% Generate modulated symbols effected by AWGN & Flat fading effect
% Comment the next line to get diffrent random symbols
rng default;
% Set modulation order
M = 16;
% Set the name of the dataset
filename = '16qam_train_dataset_rician.txt';
% Set modulation M (FSK not supported)
MOD_TYPE = 'QAM';
% K-factor 
K_dB = [3,7,10];
% EbN0dB levels
EbN0dB = -5:1:15;
% Number of symbols
nSym = 10^6;
columnsCell = {'label','real','imag'};
% Sampling rate
Nsamp = 4;
% Bits per symbol
k=log2(M);
% EsN0dB calculation
EsN0dB = 10*log10(k)+EbN0dB;
% Uniform random symbols from 1:M
d=floor(M.*rand(1,nSym));
% Sample the original signal to extract the labels
labels =  rectpulse(d,Nsamp);
% Signal modulation
s=signal_mod(MOD_TYPE,M,d);
% Sample the modulated signal
sig_pulse = rectpulse(s,Nsamp);
legendString = cell(1,length(EbN0dB));
% for each EsN0(dB) noise level
writecell(columnsCell,filename);
for j = 1:length(K_dB)
    %K factor in linear scale
    K = 10.^(K_dB(j)/10);
    g1 = sqrt(K/(2*(K+1))); 
    g2 = sqrt(1/(2*(K+1)));
    for i=1:length(EsN0dB)
            ebno = ['EbN0_____ ',num2str(EsN0dB(i)-10*log10(k)),'dB ______'];
            disp(ebno)
            h = (g2*randn(1,nSym*Nsamp)+g1)+1i*(g2*randn(1,nSym*Nsamp)+g1);
            display(mean(abs(h).^2));%avg power of the fading samples
            %Rician fading effect on modulated symbols
            hs = abs(h).*sig_pulse;
            r = add_awgn(hs,EsN0dB(i));
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
end





