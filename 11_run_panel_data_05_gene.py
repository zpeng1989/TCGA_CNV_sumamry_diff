# -*- coding: utf-8 -*-
#!/usr/bin/python
#__author__= "PengZhang"

import os

cancer_list = ['ACC','BLCA','BRCA','CHOL','COADREAD','ESCA','GBM','HNSC','KIPAN','KIRP','LGG','LUAD','MESO','PAAD','PRAD','SARC','STAD','TGCT','THYM','UCS','CESC','COAD','DLBC','FPPP','GBMLGG','KICH','KIRC','LAML','LIHC','LUSC','OV','PCPG','READ','SKCM','STES','THCA','UCEC','UVM']

input_cancer_list = cancer_list

print(input_cancer_list)

for i in input_cancer_list:
	print(i)
	path_all_data_inpout = '/work/home/zhangp/mission/12_CNV_deep_sumamry/split_data/panel_data/' + i + '/'
	if not os.path.exists(path_all_data_inpout):
		os.mkdir(path_all_data_inpout)
	os.system('Rscript 07_panel_gene_name_table.R %s'%i)
