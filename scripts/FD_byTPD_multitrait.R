library(TPD)
caete_500pls<-read.csv("/home/bia/Desktop/paper_mestrado/caete_results_server/resultado_versao_CAETEv1.0/results_first_version_caete/nClimate_constant/out500_mean_runs_tropical.csv", header = TRUE) #calls the file
caete_500pls_traits_column<-caete_500pls[,21:26] #select the traits columns
names(caete_500pls_traits_column)
pca_500pls <- prcomp(caete_500pls_traits_column, scale=TRUE) #performs a PCA for the traits
biplot(pca_500pls)
summary(pca_500pls)
pca_500pls_axes<-pca_500pls$x
pca_500pls_df<-as.data.frame(pca_500pls_axes)
pls_col<-rep('500PLS',dim(pca_500pls_df)[1])
pca_500pls_df<-cbind(pca_500pls_df[,1:3],pls_col)
caete_500pls_traits_pca<-pca_500pls_df[1:2]
caete_500pls <- pca_500pls_df[,4]
TPDs_caete<- TPDs(species = caete_500pls, caete_500pls_traits_pca, alpha=0.95)
FDindices_caete <- REND(TPDs = TPDs_caete)
FDindices_caete



