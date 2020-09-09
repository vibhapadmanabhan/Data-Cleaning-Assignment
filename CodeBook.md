# Codebook
This codebook discusses the dimensions and variables of the output file ``tidyData.txt`` from the script ``run_analysis.r``.
# Data Shape
The dimensions of the data as provided in the downloaded files are available on the ``README.txt`` associated with this repo. Here, the shape of the output file is discussed. 

The downloaded data were transformed to a 180 x 68 dataframe called ``tidyData``. The columns in ``tidyData`` were named ``subjectNo``, ``activity``, ``tBodyAccmeanX``, and so on (see the discussion on variable names below). The last 66 columns of ``tidyData`` are derived from the original list of 561 features that was downloaded. Specifically, the 66 columns correspond to the means of the variables that measured means and standard deviations (std) in the original set of features. 

Each observation (row) in the data table corresponds to a unique subject-activity pair and the average measurements per variable associated with this pair, for example, row 12 corresponds to subjectNo 2, laying. 

### The meaning of mean
The instruction to extract only the measurements on mean and standard deviation for each measurement was open to interpretation. I decided not to include features such as ``angle(X,gravityMean)`` and ``fBodyAcc-meanFreq()-X`` in my output file since the first was simply an angle between two vectors and in no way related to the mean, while the second was a 'weighted average of frequency components', which does not correspond strictly to an arithmetic mean. These decisions resulted in only 66 columns/features being selected.

# Original Variable Names
The ``features_info.txt`` file, provided with the original dataset says the following about variable names:
>The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
>
>Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
>
>Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
>
>These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

## Considerations
The original variable names, explained individually in a codebook, could be considered descriptive enough (albeit a mouthful). It would be nice to get rid of the parentheses and hyphens from the names, though. Also, in the tidy dataset, we are calculating the *means* of particular features, so there should be something in the new variable names that emphasises this.

# New Variable Names

Each variable name is formed from 7 'tokens', of which two are optional:<sup>1</sup>
1. **Prefix**: Since all the variables in the tidy dataset are meant to be means of measurements, each of them are prefixed with the string ``mean``.
1. **Signal domain**: ``t`` or ``f``, denoting a time-domain signal and frequency-domain signal respectively.
2. **Source of acceleration**: ``Body`` or ``Gravity``, denoting whether the acceleration/velocity signal was the result of bodily movement or gravity, respectively.
3. **Instrument**: ``Acc`` or ``Gyro`` refers to which instrument the signal was obtained from (or, by extension, whether the measurement is of linear acceleration or angular velocity): either the accelerometer or the gyroscope. In the variable explanations, I refer to linear acceleration/angular velocity rather than the instrument used since the former terms make it easier to understand measurements.
4. **Derived quantity** (optional): Some variables include the string ``Jerk`` or ``Mag`` or both. 
    * Variables that include ``Jerk`` are derived in time from the same variable without ``Jerk``. For example, ``tBodyGyroJerkStdY`` is the derivative of ``tBodyGyroStdY`` w.r.t. time.
    * Variables that include ``Mag`` denote the magnitudes of 3-dimensional signals without ``Mag``, calculated using the Euclidean norm. For example, ``tBodyAccMagMean`` is the mean of the magnitudes of the tBodyAcc vector, which consists of X, Y, and Z components.
5. **Statistic**: ``mean`` or ``std``, denoting the statistic that was calculated on the measurements to obtain the variable.
6. **Dimension** (optional): ``X``, ``Y``, or ``Z``, indicating the spatial dimension in which the signal was measured.

<sup>1</sup>Huge thanks to course mentor Len Greski who shared the concept of breaking down names into tokens in a course [forum post](https://www.coursera.org/learn/data-cleaning/discussions/weeks/4/threads/YKDgWSmzEee7-ArL2SqqXA/replies/ouO59iohEee6ugr9raNa5A) and whose answers have been super helpful overall.
## Putting it all together

There are a few remaining caveats: note that acceleration due to gravity is never measured by the gyroscope, so the tokens ``Gravity`` and ``Gyro`` are mutually exclusive. Also, jerk due to gravity is not included in the dataset, so the tokens ``Gravity`` and ``Jerk`` are mutually exclusive as well. Because of the definition of magnitude, it's implicit that the token ``Mag`` and the dimension token(s) will be mutually exclusive. Finally, there are no ``fBodyGyroJerk`` variables that do not also include the token ``Mag``.

Keeping all this in mind, valid variable names would look something like ``tGravityMagAccstd`` and ``tBodyGyroJerkmeanY``.

## Variables in ``tidyData.txt``
### Units
Units for quantities in the variables: 
* Linear acceleration: m/s<sup>2</sup>
* Jerk: m/s<sup>3</sup>
* Angular velocity: rad/s
* Angular acceleration: rad/s<sup>2</sup>

Magnitudes of quantities have the same units as the quantity.

### Names
1. ``subjectNo``: Numeric variable between 1 and 30, indicating the person who carried out the experiment.            

2. ``activity``: A character vector equal to ``WALKING``, ``SITTING``, ``STANDING``, ``WALKING_UPSTAIRS``, ``LAYING``, or ``WALKING_DOWNSTAIRS`` indicating the activity performed.   

In the variables that follow (3-68), the dimensions are w.r.t. the orientation of the phone. According to the ``README.txt`` in the dataset, values are normalised between -1 and 1. 

3. ``meantBodyAccmeanX``: Numeric variable which is the mean of the mean of the time-domain signal from body acceleration in the X dimension.

4. ``meantBodyAccmeanY``: Numeric variable which is the mean of the mean of the time-domain signal from body acceleration in the Y dimension.         
5. ``meantBodyAccmeanZ``: Numeric variable which is the mean of the mean of the time-domain signal from body acceleration in the Z dimension.         
6. ``meantBodyAccstdX``: Numeric variable which is the mean of the standard deviation of the time-domain signal from body acceleration in the X dimension.          
7. ``meantBodyAccstdY``: Numeric variable which is the mean of the standard deviation of the time-domain signal from body acceleration in the Y dimension.          
8. ``meantBodyAccstdZ``: Numeric variable which is the mean of the standard deviation of the time-domain signal from body acceleration in the Z dimension.          
9. ``meantGravityAccmeanX``: Numeric variable which is the mean of the mean of the time-domain signal from gravitational acceleration in the X dimension.    
10. ``meantGravityAccmeanY``: Numeric variable which is the mean of the mean of the time-domain signal from gravitational acceleration in the Y dimension.   
11. ``meantGravityAccmeanZ``: Numeric variable which is the mean of the mean of the time-domain signal from gravitational acceleration in the Z dimension.        
12. ``meantGravityAccstdX``: Numeric variable which is the mean of the standard deviation of the time-domain signal from gravitational acceleration in the X dimension.         
13. ``meantGravityAccstdY``: Numeric variable which is the mean of the standard deviation of the time-domain signal from gravitational acceleration in the Y dimension.      
14. ``meantGravityAccstdZ``: Numeric variable which is the mean of the standard deviation of the time-domain signal from gravitational acceleration in the Z dimension.      
15. ``meantBodyAccJerkmeanX``: Numeric variable which is the mean of the mean of the time-domain signal from body jerk in the X dimension.   
16. ``meantBodyAccJerkmeanY``: Numeric variable which is the mean of the mean of the time-domain signal from body jerk in the Y dimension.    
17. ``meantBodyAccJerkmeanZ``: Numeric variable which is the mean of the mean of the time-domain signal from body jerk in the Z dimension.    
18. ``meantBodyAccJerkstdX``: Numeric variable which is the mean of the standard deviation of the time-domain signal from body jerk in the X dimension.    
19. ``meantBodyAccJerkstdY``: Numeric variable which is the mean of the standard deviation of the time-domain signal from body jerk in the Y dimension.    
20. ``meantBodyAccJerkstdZ``: Numeric variable which is the mean of the standard deviation of the time-domain signal from body jerk in the Z dimension.      
21. ``meantBodyGyromeanX``: Numeric variable which is the mean of the mean of the time-domain signal from angular velocity in the X dimension.      
22. ``meantBodyGyromeanY``: Numeric variable which is the mean of the mean of the time-domain signal from angular velocity in the Y dimension.       
23. ``meantBodyGyromeanZ``: Numeric variable which is the mean of the mean of the time-domain signal from angular velocity in the Z dimension.       
24. ``meantBodyGyrostdX``: Numeric variable which is the mean of the standard deviation of the time-domain signal from angular velocity in the X dimension.       
25. ``meantBodyGyrostdY``: Numeric variable which is the mean of the standard deviation of the time-domain signal from angular velocity in the Y dimension.        
26. ``meantBodyGyrostdZ``: Numeric variable which is the mean of the standard deviation of the time-domain signal from angular velocity in the Z dimension.        
27. ``meantBodyGyroJerkmeanX``: Numeric variable which is the mean of the mean of the time-domain signal from angular acceleration in the X dimension<sup>2</sup>.  
28. ``meantBodyGyroJerkmeanY``: Numeric variable which is the mean of the mean of the time-domain signal from angular acceleration in the Y dimension.   
29. ``meantBodyGyroJerkmeanZ``: Numeric variable which is the mean of the mean of the time-domain signal from angular acceleration in the Z dimension.   
30. ``meantBodyGyroJerkstdX``: Numeric variable which is the mean of the standard deviation of the time-domain signal from angular acceleration in the X dimension.   
31. ``meantBodyGyroJerkstdY``: Numeric variable which is the mean of the standard deviation of the time-domain signal from angular acceleration in the Y dimension.    
32. ``meantBodyGyroJerkstdZ``: Numeric variable which is the mean of the standard deviation of the time-domain signal from angular acceleration in the Z dimension.    
33. ``meantBodyAccMagmean``: Numeric variable which is the mean of the mean of the magnitude (Euclidean norm) of the time-domain signal from body acceleration.    
34. ``meantBodyAccMagstd``: Numeric variable which is the mean of the standard deviation of the magnitude (Euclidean norm) of the time-domain signal from body acceleration.        
35. ``meantGravityAccMagmean``: Numeric variable which is the mean of the mean of the magnitude (Euclidean norm) of the time-domain signal from gravitational acceleration.   
36. ``meantGravityAccMagstd``: Numeric variable which is the mean of the standard deviation of the magnitude (Euclidean norm) of the time-domain signal from gravitational acceleration.   
37. ``meantBodyAccJerkMagmean``: Numeric variable which is the mean of the mean of the magnitude (Euclidean norm) of the time-domain signal from body jerk.  
38. ``meantBodyAccJerkMagstd``: Numeric variable which is the mean of the standard deviation of the magnitude (Euclidean norm) of the time-domain signal from body jerk.   
39. ``meantBodyGyroMagmean``: Numeric variable which is the mean of the mean of the magnitude (Euclidean norm) of the time-domain signal from body angular velocity.   
40. ``meantBodyGyroMagstd``: Numeric variable which is the mean of the standard deviation of the magnitude (Euclidean norm) of the time-domain signal from body acceleration.     
41. ``meantBodyGyroJerkMagmean``: Numeric variable which is the mean of the mean of the magnitude (Euclidean norm) of the time-domain signal from angular acceleration.
42. ``meantBodyGyroJerkMagstd``: Numeric variable which is the mean of the standard deviation of the magnitude (Euclidean norm) of the time-domain signal from angular acceleration. 
43. ``meanfBodyAccmeanX``: Numeric variable which is the mean of the mean of the frequency-domain signal from body acceleration in the X dimension.  
44. ``meanfBodyAccmeanY``: Numeric variable which is the mean of the mean of the frequency-domain signal from body acceleration in the Y dimension.
45. ``meanfBodyAccmeanZ``: Numeric variable which is the mean of the mean of the frequency-domain signal from body acceleration in the Z dimension.      
46. ``meanfBodyAccstdX``: Numeric variable which is the mean of the standard deviation of the frequency-domain signal from body acceleration in the X dimension.         
47. ``meanfBodyAccstdY``: Numeric variable which is the mean of the standard deviation of the frequency-domain signal from body acceleration in the Y dimension.
48. ``meanfBodyAccstdZ``: Numeric variable which is the mean of the standard deviation of the frequency-domain signal from body acceleration in the Z dimension.        
49. ``meanfBodyAccJerkmeanX``: Numeric variable which is the mean of the mean of the frequency-domain signal from body jerk in the X dimension.
50. ``meanfBodyAccJerkmeanY``: Numeric variable which is the mean of the mean of the frequency-domain signal from body jerk in the Y dimension.
51. ``meanfBodyAccJerkmeanZ``: Numeric variable which is the mean of the mean of the frequency-domain signal from body jerk in the Z dimension.   
52. ``meanfBodyAccJerkstdX``: Numeric variable which is the mean of the standard deviation of the frequency-domain signal from body jerk in the X dimension.      
53. ``meanfBodyAccJerkstdY``: Numeric variable which is the mean of the standard deviation of the frequency-domain signal from body jerk in the Y dimension.
54. ``meanfBodyAccJerkstdZ``: Numeric variable which is the mean of the standard deviation of the frequency-domain signal from body jerk in the Z dimension.    
55. ``meanfBodyGyromeanX``: Numeric variable which is the mean of the mean of the frequency-domain signal from angular velocity in the X dimension.
56. ``meanfBodyGyromeanY``: Numeric variable which is the mean of the mean of the frequency-domain signal from angular velocity in the Y dimension.
57. ``meanfBodyGyromeanZ``: Numeric variable which is the mean of the mean of the frequency-domain signal from angular velocity in the Z dimension.      
58. ``meanfBodyGyrostdX``: Numeric variable which is the mean of the standard deviation of the frequency-domain signal from angular velocity in the X dimension.
59. ``meanfBodyGyrostdY``: Numeric variable which is the mean of the standard deviation of the frequency-domain signal from angular velocity in the Y dimension.
60. ``meanfBodyGyrostdZ``: Numeric variable which is the mean of the standard deviation of the frequency-domain signal from angular velocity in the Z dimension.       
61. ``meanfBodyAccMagmean``: Numeric variable which is the mean of the mean of the magnitude (Euclidean norm) of the frequency-domain signal from body acceleration.
62. ``meanfBodyAccMagstd``: Numeric variable which is the mean of the standard deviation of the magnitude (Euclidean norm) of the frequency-domain signal from body acceleration.
63. ``meanfBodyAccJerkMagmean``: Numeric variable which is the mean of the mean of the magnitude (Euclidean norm) of the frequency-domain signal from body jerk.  
64. ``meanfBodyAccJerkMagstd``: Numeric variable which is the mean of the standard deviation of the magnitude (Euclidean norm) of the frequency-domain signal from body jerk.
65. ``meanfBodyGyroMagmean``: Numeric variable which is the mean of the mean of the magnitude (Euclidean norm) of the frequency-domain signal from body angular velocity. 
66. ``meanfBodyGyroMagstd``: Numeric variable which is the mean of the standard deviation of the magnitude (Euclidean norm) of the frequency-domain signal from body angular velocity.
67. ``meanfBodyGyroJerkMagmean``: Numeric variable which is the mean of the mean of the magnitude (Euclidean norm) of the frequency-domain signal from angular acceleration.
68. ``meanfBodyGyroJerkMagstd``: Numeric variable which is the mean of the standard deviation of the magnitude (Euclidean norm) of the frequency-domain signal from angular acceleration.

<sup>2</sup> Why angular acceleration? ``features_info.txt`` tells us that 'body linear acceleration' and 'body angular velocity' were derived in time to obtain the Jerk variables, however, the first derivative of angular velocity w.r.t. time is angular acceleration. 
