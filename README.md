数据来源：

使用TCGA数据库数据
特征，根据基因为单位，每个基因上最大拷贝数(segment mean)作为这个基因的特征数值进行评估
Wes的求和统计结果作为WES的总CNV结果；
Panel(450 gene)的求和统计结果作为panel的总CNV结果；

模型：

主要通过提取不同基因的特征进行求和，并没有过滤特定区域的任何行为；

