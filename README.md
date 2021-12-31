# generate-modulated-signals
This repository contains many simulations for wireless communications in MATLAB. It focuses on the modulation and demodulation of digital signals, that are effected by the variety and the randomness of the channel. 

## Functionality Walkthrough:

There are some basic functions, such as signal_mod and signal_demod, that can modulate/demodulate a bitstream given a modulation type (BPSK-QPSK-MPSK/MQAM/MPAM supported).

There are also some functions that help us calculate the Symbol Error Rate, based on the channel case. Those functions are ser_rayleigh and ser_rician. Moreover, there is implementation for Maximum-Likelihood detection for both Rayleigh and Rician channel cases. The most important scripts are the gen_mod_awgn_xxx ripts, which can be used in order to generate simulated training and testing datasets for Machine Learning models. I've used those datasets to train and test some models, and the results are pretty amazing.

   ![CNN_Model_1vs2_rician](https://user-images.githubusercontent.com/64161512/147837017-1616bae1-3916-456f-8f75-266c195a4df8.png)
