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

/******************************************************************  
 * Developer: Khasha Dehnad 
 *  
 **********************************************************************/ 
     data Arcs; 
 infile datalines; 
 input Node $ A B C D E F G; 
 datalines; 
 A 0 1 0 0 0 0 0 
 B 1 0 0 1 0 0 1 
 C 1 0 0 0 1 0 0 
 D 0 1 1 0 0 0 0 
 E 0 0 0 1 0 1 0 
 F 1 0 1 0 0 0 0 
 G 0 1 0 0 0 0 0 
 ; 
 run; 
   /*get the transition matrix*/ 
 proc sql; 
 create table matrix_1 as 
 select a/sum(a) as x1 
 ,b/sum(b) as x2 
 ,c/sum(c) as x3 
 ,d/sum(d) as x4 
 ,e/sum(e) as x5 
 ,f/sum(f) as x6 
 ,g/sum(g) as x7  
 from Arcs 
 ; 
 quit; 
   /*Since there are 7 nodes, the initial vector v0 has 7 components, each 1/7*/ 
 data rank_p; 
 x1=1/7;  
 x2=1/7; 
 x3=1/7; 
 x4=1/7; 
 x5=1/7; 
 x6=1/7; 
 x7=1/7; 
 output; 
 run; 
     proc iml; 
 use matrix_1; 
 read all var { x1 x2 x3 x4 x5 x6 x7 } into M; 
 print M; 
   use rank_p; 
 read all var { x1 x2 x3 x4 x5 x6 x7 } into rank_p1; 
 rank_p = t(rank_p1); 
 print rank_p ;  
   rank_p50=(M**50)*rank_p; 
 print rank_p50 ; 
   quit; 
