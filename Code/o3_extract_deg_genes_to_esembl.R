wd="/Users/jiahuiji/Dropbox/project/t-cell/results/tf_analysis/BC_tf_clusters"
setwd(wd)



#load packages
library(stringr)
library(biomaRt)


#load input deg table
file_list=list.files(pattern=".txt")


for (i in 1:length(file_list))
{
	deg_table=read.table(file=file_list[i], sep="\t", header=F)
	sig_gene=deg_table[,1]


	#mouse to human
	convertMouseGeneList=function(x){
	human = useMart("ensembl", dataset = "hsapiens_gene_ensembl", host = "https://dec2021.archive.ensembl.org/")
	mouse = useMart("ensembl", dataset = "mmusculus_gene_ensembl", host = "https://dec2021.archive.ensembl.org/")

	genesV2 = getLDS(attributes = c("mgi_symbol"), filters = "mgi_symbol", values = x , mart = mouse, attributesL = c("hgnc_symbol"), martL = human, uniqueRows=T)
	humanx = unique(genesV2[, 2])

	# Print the first 6 genes found to the screen
	print(head(humanx))
	return(humanx)
	}

	transfer_gene=convertMouseGeneList(sig_gene)
	mart=useMart(biomart="ensembl", dataset="hsapiens_gene_ensembl")
	result=getBM(attributes=c("hgnc_symbol", "ensembl_gene_id"),
		         filters="hgnc_symbol", 
		         values=sig_gene,
		         mart=mart)


	human_ensembl=result$ensembl_gene_id
	write.table(human_ensembl,file=paste0(str_split(file_list[i], ".txt")[[1]][1],"_ensembl.txt"), sep="\t", quote=F, row.names=FALSE, col.names=FALSE)
}






