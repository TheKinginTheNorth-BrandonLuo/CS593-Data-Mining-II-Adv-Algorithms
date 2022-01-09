*-------------------------------------------------------------------------;
* Project        :  Multiple regression                        ;
* Developer(s)   : Khasha Dehand                                          ;
* Comments       : Multiple regression                                    ;
*                  Template                            ;
* Dependencies   : libnames.sas                                           ;
*-------------------------------------------------------------------------;

/*
COOKD= Cook�s  influence statistic
* Cook�s  statistic lies above the horizontal reference line at value 4/n *;
COVRATIO=standard influence of observation on covariance of betas
DFFITS=standard influence of observation on predicted value
H=leverage, 
LCL=lower bound of a % confidence interval for an individual prediction. This includes the variance of the error, as well as the variance of the parameter estimates.
LCLM=lower bound of a % confidence interval for the expected value (mean) of the dependent variable
PREDICTED | P= predicted values
RESIDUAL | R= residuals, calculated as ACTUAL minus PREDICTED
RSTUDENT=a studentized residual with the current observation deleted
STDI=standard error of the individual predicted value
STDP= standard error of the mean predicted value
STDR=standard error of the residual
STUDENT=studentized residuals, which are the residuals divided by their standard errors
UCL= upper bound of a % confidence interval for an individual prediction
UCLM= upper bound of a % confidence interval for the expected value (mean) of the dependent variable 
* DFFITS� statistic is greater in magnitude than 2sqrt(n/p);
* Durbin watson around 2 *;
* VIF over 10 multicolinear **;


*/

proc copy in=sasuser  out=work ;
   select breast_cancer_data;
run;

/* Standalize the dataset */
proc standard data = breast_cancer_data MEAN = 0 STD =1
   OUT = breast_cancer_data_std;
   VAR radius_mean	texture_mean	perimeter_mean	area_mean	smoothness_mean	compactness_mean
concavity_mean	concave_points_mean symmetry_mean	fractal_dimension_mean;
run;

/* PCA */
proc princomp data = breast_cancer_data_std OUT = breast_cancer_data_pca;
VAR radius_mean	texture_mean	perimeter_mean	area_mean	smoothness_mean	compactness_mean
concavity_mean	concave_points_mean symmetry_mean	fractal_dimension_mean;
run;

/* calculate the corr of principal components */
proc corr data = breast_cancer_data_pca cov;
var prin1-prin10;
run;
