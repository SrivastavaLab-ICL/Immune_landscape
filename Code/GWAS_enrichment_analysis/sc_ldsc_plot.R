#basic settings
wd="/Users/jiahuiji/Dropbox/project/t-cell/manuscript/DEG_TC_BC_vsday0/Bcell/LDSC/results"
setwd(wd)

#load required packages
library(ggplot2)
library(stringr)




#parameter
output_filename="BC_DEG_vsday0.pdf"





file_list=list.files(pattern="*.cell_type_results.txt")
length(file_list)


#-------Step 1: Generate heatmap plots-------
datalist=lapply(file_list, function(x)read.table(x, header=T))
traits=sapply(file_list, function(x){strsplit(x, split = "\\.")[[1]][1]})
traits=unname(traits)
head(datalist[1])


output_list = list()
for (i in 1:length(file_list)) {
    tmp=as.data.frame(datalist[i])
    tmp$trait=as.character(traits[i])
    tmp$FDR=p.adjust(tmp$Coefficient_P_value, method="fdr")
    output_list[[i]]=tmp
}

tmp=do.call("rbind", output_list)
tmp$stars=cut(tmp$FDR, breaks=c(-Inf, 0.001, 0.01, 0.05, Inf), label=c("***", "**", "*", ""))  # Create column of significance labels
head(tmp)








#generate plots
sumstat_file=c(
"2hGlu_2021",        
"FG_2021",          
"FI_2021" ,            
"Glu_UKB", 
"HbA1c_2021", 
"T2D",   

"RTC_UKB", 
"HDLC_UKB", 
"LDLC_UKB",    
                             
"CAD",           
"IHD",            
"CHD_UKB",       
"IHD_UKB",        
"AF_UKB",    
"systolic_bp",
"diastolic",

"BMI_UKB", 
"UKB_460K_body_HEIGHTz",
"UKB_460K_cov_EDU_YEARS",
"UKB_460K_pigment_HAIR",
"UKB_460K_pigment_SKIN"

)



define_rowname=rev(c(
"BcellsD0D1",
"BcellsD0D3",
"BcellsD0D5",
"BcellsD0D7",
"BcellsD0D14",
"BcellsD0D28"
))




tmp=tmp[which(tmp$trait %in% sumstat_file),]
g=ggplot(aes(x=factor(trait, sumstat_file), y=factor(Name, define_rowname), fill=-log10(FDR)), data=tmp) + geom_tile() + 
  ggtitle("cell type specific LDSC \n by all DEGs") + 
  labs(x ="Traits", y = "Cell type") +
  labs(fill = "-log10(FDR)") +
  scale_fill_gradient2(low="#D7191C", mid="white", high="#2C7BB6") + 
  geom_text(aes(label=stars), color="black", size=3) + 
  theme_bw() + theme(axis.text.x=element_text(angle = -45, hjust = 0))

ggsave(g, filename=output_filename, getwd(), height=4.5, width=10.5, device="pdf")












