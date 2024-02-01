# A-New-Approach-Towards-Error-Reduction-in-Ground-Resistance-Measurements-Based-on-Clamp-on-Method

## Associated research paper
A New Approach for Ground Resistance Measurements in Onshore Wind Farms based on Clamp-On Meters and Artificial Neural Network

## Overview
This is the file folder for the article titled: A New Approach Towards Error Reduction in Ground Resistance Measurements Based on Clamp-on Method, recently submitted to the Electrical Power Systems Research journal (ELSEVIER).

The first file "SBC Wind Park`s grounding system partition to application of proposed method.pdf" contains the grounding sub-systems into which the SBC Wind Park grounding system was divided to apply the proposed solution.

The second file "SBC wind park grounding system. Clamp-on meter in OD01.jpg" contains the SBC wind farm equivalent circuit as one isolated section.

The third contains the "aterrad3.m" file, a function created in Matlab to calculate the values of the readings to be obtained using the clamp on the cable down to the WTG grounding systems, from the values of the impedance of each ground loop and the WTG grounding resistances.

The last file "final_solution_parque_SBN_extreme_rproj.m", contains the proposed solution algorithm file that uses an artificial neural network (ANN) to estimate the WTG's grounding resistance through the clamp-on meter readings values. For the ANN to perform as expected, it is trained through computer simulations of the clamp-on meter method on a wind park electrical circuit using the aterrad3 function.


