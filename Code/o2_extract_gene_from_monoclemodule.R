setwd("/Users/jiahuiji/Dropbox/project/t-cell/results/monocle_module_go/genelist")
load("/Users/jiahuiji/Dropbox/project/t-cell/results/T-cell/monocle_deg_module.rds")
module=sort(unique(gene_module_df$module))
for (i in 1:length(module))
{
	gene=gene_module_df$id[which(gene_module_df$module == module[i])]

	write.table(gene,file=paste0("TC_module",module[i],".txt"),sep="\t",quote=F,row.names=FALSE,col.names=FALSE)
}