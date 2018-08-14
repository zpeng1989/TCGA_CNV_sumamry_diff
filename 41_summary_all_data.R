library(ggplot2)

aa<-read.delim('/work/home/zhangp/mission/12_CNV_deep_sumamry/result/big_table_output.txt')
print(dim(aa))
path_used<-c('/work/home/zhangp/mission/12_CNV_deep_sumamry/result/')

type_path_used<-paste0(path_used,'CNV_type_diff.pdf')

pdf(type_path_used, width=10, height=7)
p <- qplot(panel_value, wes_value, data=aa, colour=type)+ geom_point(alpha=0.1)+theme_bw() +theme(
                legend.title = element_blank(),
                legend.text = element_text(size = 20,face='bold',color='black'),
                axis.title.x = element_blank(),
                axis.title.y = element_text(size = 20,face='bold',color='black'),
                axis.text.y = element_text(size = 20,face='bold',color='black'),
                #axis.title.x = element_text(size = 20),
                axis.text.x = element_text(angle = 30, vjust = 1, hjust = 1,size=20,,face='bold',color='black'),
                panel.grid = element_blank(),
                axis.ticks.x = element_blank(),
                panel.border = element_blank(),
                axis.line = element_line(size = 0.5, colour = 'black')
)
print(p)
dev.off()

type_path_used<-paste0(path_used,'CNV_tmb_diff.pdf')


if(sum(is.na(aa$TMB))!=0){
                dd<-aa[-which(is.na(aa$TMB)),]
        }else{
                dd<-aa
        }
        TMB_qalue<-quantile(dd$TMB,  probs = c(0.75))
        print(TMB_qalue)
        TMB_list<-c(1:length(dd[,1]))
        for(i in c(1:length(dd[,1]))){
                if(dd$TMB[i]>TMB_qalue){
                        TMB_list[i]<-'high'
                }else{
                        TMB_list[i]<-'low'
                }
        }


dd$TMB_type<-TMB_list
pdf(type_path_used, width=10, height=7)
p <- qplot(panel_value, wes_value, data=dd, colour=TMB_type)+ geom_point(alpha=0.1)+theme_bw() +theme(
                legend.title = element_blank(),
                legend.text = element_text(size = 20,face='bold',color='black'),
                axis.title.x = element_blank(),
                axis.title.y = element_text(size = 20,face='bold',color='black'),
                axis.text.y = element_text(size = 20,face='bold',color='black'),
                #axis.title.x = element_text(size = 20),
                axis.text.x = element_text(angle = 30, vjust = 1, hjust = 1,size=20,,face='bold',color='black'),
                panel.grid = element_blank(),
                axis.ticks.x = element_blank(),
                panel.border = element_blank(),
                axis.line = element_line(size = 0.5, colour = 'black')
)
print(p)
dev.off()



for(i in names(table(dd$type))){
	dd_type_data<-dd[which(dd$type == i),]
	print(dim(dd_type_data))
	pdf_path <- paste0('/work/home/zhangp/mission/12_CNV_deep_sumamry/plot_data/',i,'_output.pdf')
	pdf(pdf_path)
	p <- qplot(panel_value, wes_value, data=dd_type_data, colour=TMB_type)+ geom_point(alpha=0.1)+theme_bw() +theme(
                legend.title = element_blank(),
                legend.text = element_text(size = 20,face='bold',color='black'),
                axis.title.x = element_blank(),
                axis.title.y = element_text(size = 20,face='bold',color='black'),
                axis.text.y = element_text(size = 20,face='bold',color='black'),
                #axis.title.x = element_text(size = 20),
                axis.text.x = element_text(angle = 30, vjust = 1, hjust = 1,size=20,,face='bold',color='black'),
                panel.grid = element_blank(),
                axis.ticks.x = element_blank(),
                panel.border = element_blank(),
                axis.line = element_line(size = 0.5, colour = 'black')
)
print(p)
	dev.off()
	
}


