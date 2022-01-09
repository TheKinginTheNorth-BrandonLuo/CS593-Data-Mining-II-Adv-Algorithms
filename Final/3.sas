*-------------------------------------------------------------------------;
* Project        :  Multiple regression                        ;
* Developer(s)   : Khasha Dehand                                          ;
* Comments       : Multiple regression                                    ;
*                  Template                            ;
* Dependencies   : libnames.sas                                           ;
*-------------------------------------------------------------------------;

/*
COOKD= Cook’s  influence statistic
* Cook’s  statistic lies above the horizontal reference line at value 4/n *;
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
* DFFITS’ statistic is greater in magnitude than 2sqrt(n/p);
* Durbin watson around 2 *;
* VIF over 10 multicolinear **;


*/

proc copy in= sasuser out=work ;
   select lung;
run;

title " lung ";
proc reg data=lung ;
     model     Height_oldest_child =  Age_oldest_child Weight_oldest_child 
Height_mother Weight_mother Height_father Weight_father /  selection = forward  ;
    run;

proc reg data=lung ;
     model     Height_oldest_child =  Age_oldest_child Weight_oldest_child 
Height_mother Weight_mother Height_father Weight_father /  selection = backward  ;
    run;

	proc reg data=lung ;
     model     Height_oldest_child =  Age_oldest_child Weight_oldest_child 
Height_mother Weight_mother Height_father Weight_father /  selection = stepwise  ;
    run;

	proc reg data=lung ;
     model     Height_oldest_child =  Age_oldest_child Weight_oldest_child 
Height_mother Weight_mother Height_father Weight_father /  selection = MAXR  ;
    run;
