% With the following function, we add white gaussian noise into our channel
function [added_awgn] = add_awgn(h,EsN0dB) 
% awgn(in,snr,signalpower) accepts an input signal power value in dBW. 
% To have the function measure the power of in before adding noise, specify signalpower as 'measured'.
added_awgn = awgn(h,EsN0dB,'measured');
end
