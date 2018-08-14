a_list = c('ACC','BRCA','CHOL','COADREAD','ESCA','GBM','HNSC','KIPAN','KIRP','LGG','LUAD','MESO','PAAD','PRAD','SARC','STAD','TGCT','THYM','UCS','BLCA','CESC','COAD','DLBC','FPPP','GBMLGG','KICH','KIRC','LAML','LIHC','LUSC','OV','PCPG','READ','SKCM','STES','THCA','UCEC','UVM')

k = 1

for(i in a_list){
	a_input_panel_data = paste0('/work/home/zhangp/mission/12_CNV_deep_sumamry/summary_data/panel_data/',i , '.txt')
	a_input_wes_data = paste0('/work/home/zhangp/mission/12_CNV_deep_sumamry/summary_data/wes_data/',i , '.txt')
	input_panel_table<-read.delim(a_input_panel_data)
	input_wes_table<-read.delim(a_input_wes_data)
	input_panel_table_new<-data.frame(input_panel_table[,1],as.numeric(input_panel_table[,2]))
	colnames(input_panel_table_new)<-c('sample_id', 'panel_value')

	input_wes_table_new<-data.frame(input_wes_table[,1],as.numeric(input_wes_table[,2]))
        colnames(input_wes_table_new)<-c('sample_id', 'wes_value')
	
	merge_table_wes_panel<-merge(input_panel_table_new, input_wes_table_new, x.by = 'sample_id', y.by = 'sample_id')
	
	one_merge_table_wes_panel<-merge_table_wes_panel
	if(k == 1){
		k = 2
		all_merge_table_wes_panel <- one_merge_table_wes_panel
	}else{
		all_merge_table_wes_panel <- rbind(all_merge_table_wes_panel,one_merge_table_wes_panel)
	}
}

message_table <- read.delim('/work/home/zhangp/TCGA/Data/TCGA_other_data/TCGA_all_NAB_stage_TMB.txt')
message_table <- message_table[,c(1,4,5,6,7,8,9,10)]
colnames(message_table) <- c('sample_id','type','immune','days','status','MSI','TMB','NAB')
last_output_data<-merge(all_merge_table_wes_panel, message_table, x.by ='sample_id', y.by ='sample_id')
write.table(last_output_data, '/work/home/zhangp/mission/12_CNV_deep_sumamry/result/big_table_output.txt',sep='\t',quote=F,row.names=F,col.names=T)




