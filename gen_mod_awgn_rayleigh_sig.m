% Generate modulated symbols effected by AWGN & Flat fading effect
% Comment the next line to get diffrent random symbols
rng default;
% Set modulation order
M = 64;
% Set the name of the dataset
filename = '64qamTrain.xlsx';
% Set modulation M(FSK not supported) 
MOD_TYPE = 'QAM';
% Set EbN0dB range (EbN0dB = -10:2:20 is slow)
EbN0dB = 12:2:20;
% Number of symbols
SymNumber = 10000;
%sigArray = cell(1, length(EbN0dB));
columnsCell = {'label','real','imag'};
Nsamp = 100; % Oversampling rate
k=log2(M); 
EsN0dB = 10*log10(k)+EbN0dB; % EsN0dB calculation
% SER_sim = zeros(1,length(EbN0dB));% simulated Symbol error rates
d=floor(M.*rand(1,SymNumber));% uniform random symbols from 1:M
% Oversample the original signal to extract the labels
labels =  rectpulse(d,Nsamp);
s=signal_mod(MOD_TYPE,M,d); % signal modulation
% Oversample the modulated signal
sig_pulse = rectpulse(s,Nsamp);
% for each EsN0(dB) noise level
legendString = cell(1,length(EbN0dB));

for i=1:length(EsN0dB)
        % Prepare the spreadsheet name 
        legendString{i} = [num2str(M),'-',MOD_TYPE,' ',num2str(EsN0dB(i)-10*log10(k)),'EbN0dB'];
        writecell(columnsCell,filename,'Sheet',char(legendString{i}),'Range','A1:C1');
        writematrix(labels.',filename,'Sheet',char(legendString{i}),'Range','A2:A1000001');
        disp(EsN0dB(i)-10*log10(k))
        h = 1/sqrt(2)*(randn(1,SymNumber*Nsamp)+1i*randn(1,SymNumber*Nsamp)); %flat Rayleigh effect
        hs = abs(h).*sig_pulse; %flat fading effect on the modulated symbols (w/samples)
        r = add_awgn(hs,EsN0dB(i)); %additive noise for each EsN0dB value
        %-----------------Receiver----------------------
        %sigArray{i} = (r./abs(h)).';
        % Extract the real part
        sigRealArray = real(r./abs(h)).';    
        writematrix(sigRealArray,filename,'Sheet',char(legendString{i}),'Range','B2:B1000001');
        % Extract the imaginary part
        sigImagArray = imag(r./abs(h)).';
        writematrix(sigImagArray,filename,'Sheet',char(legendString{i}),'Range','C2:C1000001');
        clear sigImagArray sigRealArray;
        
end


