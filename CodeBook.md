# Variable Names

Each variable name is formed from 6 'tokens', of which two are optional:
1. **Signal domain**: ``t`` or ``f``, denoting a time-domain signal and frequency-domain signal respectively.
2. **Source of acceleration**: ``Body`` or ``Gravity``, denoting whether the acceleration/velocity signal was the result of bodily movement or gravity, respectively.
3. **Instrument**: ``Acc`` or ``Gyro`` refers to which instrument the signal was obtained from (or, by extension, whether the measurement is of linear acceleration or angular velocity): either the accelerometer or the gyroscope.
4. **Derived quantity** (optional): Some variables include the string ``Jerk`` or ``Mag`` or both. 
    * Variables that include ``Jerk`` are derived in time from the same variable without ``Jerk``. For example, ``tBodyGyroJerkStdY`` is the derivative of ``tBodyGyroStdY`` w.r.t. time.
    * Variables that include ``Mag`` denote the magnitudes of 3-dimensional signals without ``Mag``, calculated using the Euclidean norm. For example, ``tBodyAccMagMean`` is the mean of the magnitudes of the tBodyAcc vector, which consists of X, Y, and Z components.
5. **Statistic**: ``mean`` or ``std``, denoting the statistic that was calculated on the measurements to obtain the variable.
6. **Dimension** (optional): ``X``, ``Y``, or ``Z``, indicating the spatial dimension in which the signal was measured.

## Putting it all together

There are a few remaining caveats: note that acceleration due to gravity is never measured by the gyroscope, so the tokens ``Gravity`` and ``Gyro`` are mutually exclusive. Also, jerk due to gravity is not included in the dataset, so the tokens ``Gravity`` and ``Jerk`` are mutually exclusive as well. Because of the definition of magnitude, it's implicit that the token ``Mag`` and the dimension token(s) will be mutually exclusive. Finally, there are no ``fBodyGyroJerk`` variables that do not also include the token ``Mag``.

Keeping all this in mind, valid variable names would look something like ``tGravityMagAccstd`` and ``tBodyGyroJerkmeanY``.
