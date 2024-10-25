# Ideas worth spreading
This repository is dedicated to methodological errors that we commonly encounter in scientific publications in the field of bioinformatics and computational biology. 

## pdf_reports 
In the **pdf_reports** folder you can find .pdf files that integrate code and results of methodogolical errors. 

### glmnet_data_leakage.pdf: 
glmnet_data_leakage.pdf contains an example of why using the information of the class to perform feature selection before model building can lead to data leakage and overestimation of performance. 
In this example I used only `ElasticNet` to train and test my models, but the same results hold for any other algorithm. 

