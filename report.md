# Estimation of Direction of Arrival Using Information Theory

## Introduction

Time delay estimation (TDE) algorithms are popularly employed for the estimation of Direction of Arrival (DoA) of an acoustic source. The most popular approach relies on defining the relative delay between a pair of microphones by getting a peak in the comparing function at the correct DoA of the source.

The most common method applied for TDE is the generalized cross-correlation (GCC) algorithm with its numerous variants. But in reverberant environments its practical usefulness is severely restricted.

In our framework, we use the concept of mutual information to create a new comparing function that calculates the correct TDE by maximizing information that one microphone has about the other, assuming Gaussian distributions.

In the following sections, we describe the theory and implementation of this method and show the comparative results with (GCC-PHAT) in the result section.

## Theory

### GCC-PHAT

### Information Theoretic Delay Estimation

## Implementation

Simulations involved a single source and two microphone system. The relative sample delay estimate varies according to $d$. Moreover, the system can find only integer delays, so optimally it should estimate the delay to the nearest integer.

--------------                 ------------------------
Variable                       Value
--------------                 ------------------------
Speech duration                5 s

Sampling Frequency, $f_s$      44.1 kHz

Distance between source        2.23
& mid-point of receivers
Actual delay (samples)         6.89

Expected delay (samples)       7

$T_{60}(s)$                    0.15, 0.30, 0.50

Length of $h(k)$ (samples)     6615, 13230, 22050
--------------------------     ------------------------



## Results
