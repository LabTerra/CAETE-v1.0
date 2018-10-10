library(TPD)
caete_3000pls<-read.csv("/home/bia/Desktop/paper_mestrado/caete_results_server/resultado_versao_CAETEv1.0/results_first_version_caete/nClimate_constant/out3000_mean_runs_tropical.csv", header = TRUE) #calls the file
names(caete_3000pls)#choose the trait of interest
caete_3000pls_trait<-caete_3000pls[,21] #select the trait of interest

caete_npls <- caete_3000pls[,1] #select the column of number of pls
TPDs_caete<- TPDs(species = caete_npls, caete_3000pls_trait, alpha=0.95)
plotTPD(TPDs_caete)
FDindices_caete <- REND(TPDs = TPDs_caete)
FDindices_caete



