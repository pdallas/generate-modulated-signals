% Generate modulated symbols effected by AWGN & Flat fading effect
% Comment the next line to get diffrent random symbols
%rng default;
% Set modulation order
M = 16;
% Set the name of the dataset
filename = '16qamTest_rician_k_10.xlsx';
% Set modulation M (FSK not supported) 
MOD_TYPE = 'QAM';
EbN0dB = -5:1:15;
% K-factor 
K_dB = 10;
% Number of symbols
SymNumber = 10^6;
% sigArray = cell(1, length(EbN0dB));
columnsCell = {'label','real','imag'};
% Sampling rate
Nsamp = 1; 
k=log2(M);
% EsN0dB calculation
EsN0dB = 10*log10(k)+EbN0dB; 
% Uniform random symbols from 1:M
d=floor(M.*rand(1,SymNumber));
% Sample the original signal to extract the labels
labels = rectpulse(d,Nsamp);
% Signal modulation
s=signal_mod(MOD_TYPE,M,d);
% Sample the modulated signal
sig_pulse = rectpulse(s,Nsamp);
legendString = cell(1,length(EbN0dB));
%K factor in linear scale
K = 10.^(K_dB/10);
g1 = sqrt(K/(2*(K+1))); 
g2 = sqrt(1/(2*(K+1)));
for i=1:length(EsN0dB)
        % Prepare the spreadsheet name 
        legendString{i} = ['K=',num2str(K_dB),',',num2str(M),'-',MOD_TYPE,' ',num2str(EsN0dB(i)-10*log10(k)),'EbN0dB'];
        writecell(columnsCell,filename,'Sheet',char(legendString{i}),'Range','A1:C1');
        %writematrix(labels.',filename,'Sheet',char(legendString{i}),'Range','A2:A1000001');
        disp(EsN0dB(i)-10*log10(k))
        h = (g2*randn(1,SymNumber*Nsamp)+g1)+1i*(g2*randn(1,SymNumber*Nsamp)+g1);
        display(mean(abs(h).^2));%avg power of the fading samples
        % Rician fading effect on modulated symbols
        hs = abs(h).*sig_pulse;
        r = add_awgn(hs,EsN0dB(i));
        
        %-----------------Receiver----------------------

        % Extract the real part
        sigRealArray = real(r./abs(h)).';    
        %writematrix(sigRealArray,filename,'Sheet',char(legendString{i}),'Range','B2:B1000001');
        % Extract the imaginary part
        sigImagArray = imag(r./abs(h)).';
        %writematrix(sigImagArray,filename,'Sheet',char(legendString{i}),'Range','C2:C1000001');
        C = horzcat(labels.',sigRealArray,sigImagArray);
        writematrix(C,filename,'Sheet',char(legendString{i}),'WriteMode','append');
        % Clear memory
        clear sigRealArray sigImagArray C;
        
end