wd="/Users/jiahuiji/Library/CloudStorage/Dropbox/project/t-cell/plot"
setwd(wd)

library(Seurat)
library(biomaRt)
library(ggplot2)

bc=readRDS(file="/Users/jiahuiji/Library/CloudStorage/Dropbox/project/t-cell/data/bc_subset_seurat.rds")
plot_obj=select_obj[,colnames(bc)]



marker_genes=c("COL5A3", "COL15A1", "COL6A3", "COL5A2", "COL4A1", "COL4A2", "COL1A2", "COL1A1", "COL8A1", "COL3A1", "COL5A1")
mart=useMart(biomart="ensembl", dataset="hsapiens_gene_ensembl")
result=getBM(attributes=c("hgnc_symbol", "ensembl_gene_id"),
	         filters="hgnc_symbol", 
	         values=marker_genes,
	         mart=mart)
marker_ensembl=result$ensembl_gene_id

#generate plots 
g=DotPlot(plot_obj, features=marker_ensembl, group.by="disease") + 
RotatedAxis() +
coord_flip()
ggsave(g, file="bc_disease_group_dot.pdf", width=4.5, height=4.5)


#generate plots 
g=DotPlot(plot_obj, features=marker_ensembl, group.by="patient_group") + 
RotatedAxis() +
coord_flip()
ggsave(g, file="bc_patient_group_dot.pdf", width=4.7, height=4.1)