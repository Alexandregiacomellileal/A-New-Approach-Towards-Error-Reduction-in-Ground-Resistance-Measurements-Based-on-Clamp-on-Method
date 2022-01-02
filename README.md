# A-New-Approach-Towards-Error-Reduction-in-Ground-Resistance-Measurements-Based-on-Clamp-on-Method


The first file contains the partition of the SBC Wind Park earthing system groups to apply the proposed method.

The second file contains all the equivalent circuit derived from the mathematical modeling of the SBC wind farm with the insertion of a source that represents the voltage injected by the clamp-on meter in the circuit  aiming to measure the OD1 wind turbine resistance.

The third contains the aterrad3.m file, function to calculate the values of the readings to be obtained using the clamp on the cable down to the WTG grounding system, from the values of the impedance of each ground loop and the WTG grounding resistances.

The last file, contains the proposed solution algoritm file that uses an artificial neural network (ANN) to estimate the WTG`s grounding resistance through the clamp-on meter readings values. For the ANN to perform as expected, it is trained through computer simulations of the clamp-on meter method on a wind park electrical circuit using the aterrad3 function.

End.
