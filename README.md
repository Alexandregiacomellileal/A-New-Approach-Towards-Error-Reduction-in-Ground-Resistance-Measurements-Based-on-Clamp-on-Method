# A-New-Approach-Towards-Error-Reduction-in-Ground-Resistance-Measurements-Based-on-Clamp-on-Method

This is the file folder for the article titled: A New Approach Towards Error Reduction in Ground Resistance Measurements Based on Clamp on Method.

The first file contains the grounding sub-systems into which the SBC Wind Park grounding system was divided for the application of the proposed solution.

The second file contains the SBC wind farm equivalent circuit as one.

The third contains the aterrad3.m file, function created in Matlab to calculate the values of the readings to be obtained using the clamp on the cable down to the WTG grounding system, from the values of the impedance of each ground loop and the WTG grounding resistances.

The last file, contains the proposed solution algoritm file that uses an artificial neural network (ANN) to estimate the WTG`s grounding resistance through the clamp-on meter readings values. For the ANN to perform as expected, it is trained through computer simulations of the clamp-on meter method on a wind park electrical circuit using the aterrad3 function.

End.
