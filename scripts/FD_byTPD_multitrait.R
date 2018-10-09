library(TPD)
caete_1000pls<-read.csv("/home/bia/Desktop/paper_mestrado/caete_results_server/resultado_versao_CAETEv1.0/results_first_version_caete/nClimate_constant/out1000_mean_runs_temperate.csv", header = TRUE) #calls the file
caete_1000pls_traits_column<-caete_1000pls[,22:27] #select the traits columns
pca_1000pls <- prcomp(caete_1000pls_traits_column, scale=TRUE) #performs a PCA for the traits
biplot(pca_1000pls)
summary(pca_1000pls)
pca_1000pls_axes<-pca_1000pls$x
pca_1000pls_df<-as.data.frame(pca_1000pls_axes)
pls_col<-rep('1000PLS',dim(pca_1000pls_df)[1])
pca_1000pls_df<-cbind(pca_1000pls_df[,1:3],pls_col)
caete_1000pls_traits_pca<-pca_1000pls_df[1:3]
caete_1000pls <- pca_1000pls_df[,4]
TPDs_caete<- TPDs(species = caete_1000pls, caete_1000pls_traits_pca, alpha=0.95)
FDindices_caete <- REND(TPDs = TPDs_caete)
FDindices_caete



