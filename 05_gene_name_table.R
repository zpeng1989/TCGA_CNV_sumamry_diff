args<-commandArgs(T)
cancer = args[1]

##主要目标，分割样本；

input_data_path = paste0('/work/home/zhangp/mission/12_CNV_deep_sumamry/split_data/all_data_test/',cancer,'/')
all_input_data = list.files(input_data_path)

summary_data<-function(input_data){
	gene_name = names(table(input_data[,4]))
	kk<-1
	for(one_gene in gene_name){
		#print(head(input_data[which(input_data[,4]==one_gene),2]))
		#print(print(max(input_data[which(input_data[,1]==one_gene),2])))
		cnv_num = mean(abs(input_data[which(input_data[,4]==one_gene),2]))
		one_floor<-c(one_gene,cnv_num)
		if(kk == 1){
			all_floor = one_floor
			kk = 2
		}else{
			all_floor = rbind(all_floor,one_floor)
		}
	}
	return(all_floor)
}

for(one_input_data in all_input_data){
	read_path = paste0(input_data_path,'/',one_input_data)
	read_data_input = read.delim(read_path,header=F)
	data_output_one = summary_data(read_data_input)
	print(head(data_output_one))
	data_new_output<-data.frame(data_output_one[,1],as.numeric(data_output_one[,2]))
	new_data_path = paste0('/work/home/zhangp/mission/12_CNV_deep_sumamry/split_data/all_data/',cancer,'/',one_input_data)
	write.table(data_new_output,new_data_path,sep='\t',quote=F,row.names=F,col.names=F)
	
}

