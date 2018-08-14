args<-commandArgs(T)
cancer = args[1]

##主要目标，分割样本；

input_data_path = paste0('/work/home/zhangp/mission/09_deep_sumamry/data_used/CNV/',cancer,'.txt')
input_data <- read.delim(input_data_path,header=F)
sample_id = names(table(input_data[,1]))

for (one_sample_id in sample_id){
	#print(one_sample_id)
	one_data_table <- input_data[which(input_data[,1]==one_sample_id),]
	print(dim(one_data_table))
	print(head(one_data_table))
	write_table_path <- paste0('/work/home/zhangp/mission/12_CNV_deep_sumamry/split_data/all_data_test/',cancer,'/',one_sample_id,'.txt')
	#print(write_table_path)
	write.table(one_data_table,write_table_path,sep='\t',quote=F,row.names=F,col.names=F)
}






