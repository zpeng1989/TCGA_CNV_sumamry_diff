a_list = c('ACC','BRCA','CHOL','COADREAD','ESCA','GBM','HNSC','KIPAN','KIRP','LGG','LUAD','MESO','PAAD','PRAD','SARC','STAD','TGCT','THYM','UCS','BLCA','CESC','COAD','DLBC','FPPP','GBMLGG','KICH','KIRC','LAML','LIHC','LUSC','OV','PCPG','READ','SKCM','STES','THCA','UCEC','UVM')

for(i in a_list){
	panel_input_data_path <- paste0('/work/home/zhangp/mission/12_CNV_deep_sumamry/split_data/panel_data/',i,'/')
	wes_input_data_path <- paste0('/work/home/zhangp/mission/12_CNV_deep_sumamry/split_data/all_data/',i,'/')
	all_panel_list <- list.files(panel_input_data_path)
	all_wes_list <- list.files(wes_input_data_path)
	k = 1
	for(one_panel in all_panel_list){
		#print(one_panel)
		one_panel_data_path <- paste0(panel_input_data_path, '/', one_panel)
		one_panel_data_table <- read.delim(one_panel_data_path, header=F)
		one_vector<-as.numeric(one_panel_data_table[,2])
		panel_CNV_output <- sum(one_vector)
		sample_id <- strsplit(one_panel, "[.]")[[1]][1]
		one_floor <- c(sample_id, panel_CNV_output)
		#print(one_floor)
		if(k == 1){
			all_floor<-one_floor
			k = 2
		}else{
			all_floor <- rbind(all_floor, one_floor)
		}
	}
	colnames(all_floor)<-c('sample','CNV_TMB')
	output_panel_path <- paste0('/work/home/zhangp/mission/12_CNV_deep_sumamry/summary_data/panel_data/',i, '.txt')
	write.table(all_floor, output_panel_path, sep='\t', quote=F, row.names=F, col.names=T)

	k = 1
	for(one_wes in all_wes_list){
                one_wes_data_path <- paste0(wes_input_data_path, '/', one_wes)
                one_wes_data_table <- read.delim(one_wes_data_path, header=F)
                one_vector<-as.numeric(one_wes_data_table[,2])
                wes_CNV_output <- sum(one_vector)
                sample_id <- strsplit(one_wes, "[.]")[[1]][1]
                one_floor <- c(sample_id, wes_CNV_output)
		print(one_floor)
                if(k == 1){
                        all_floor<-one_floor
			k = 2
                }else{
                        all_floor <- rbind(all_floor, one_floor)
                }
        }
        colnames(all_floor)<-c('sample','CNV_TMB')
        output_panel_path <- paste0('/work/home/zhangp/mission/12_CNV_deep_sumamry/summary_data/wes_data/',i, '.txt')
        write.table(all_floor, output_panel_path, sep='\t', quote=F, row.names=F, col.names=T)
}

