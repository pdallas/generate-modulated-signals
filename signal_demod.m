% The following function demodulates a singal, based on the modulation type.
% Supported modulations/MOD_TYPE; BPSK-QPSK-MPSK/MQAM/MPAM (FSK not supported)
% M; Modulation/Demodulated order 
% y; Transmitted modulated signal
% Switch function is not case sensitive
% https://nl.mathworks.com/help/comm/modulation.html?s_tid=CRUX_lftnav
function [demodulated_signal] = signal_demod(MOD_TYPE,M,y)

switch lower(MOD_TYPE)
    case {'bpsk'}   
        bpskdemod = comm.BPSKDemodulator;
        bpskdemod.PhaseOffset = 0;
        demodulated_signal = bpskdemod(y');
    case {'qpsk','mpsk','psk'}
        demodulated_signal = pskdemod(y,M);
    case {'mqam','qam'}
       demodulated_signal = qamdemod(y,M);
    case {'mpam','pam'}
        init_phase = pi/4;
        demodulated_signal = pamdemod(y,M,init_phase);
    otherwise
        disp 'singal_mod.m: Invalid modulation (MOD_TYPE) selected.'

end
end