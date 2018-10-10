library(hypervolume) #load the hypervolume library
caete_3000pls<-read.csv("/home/bia/Desktop/paper_mestrado/caete_results_server/resultado_versao_CAETEv1.0/results_first_version_caete/nClimate_constant/out3000_mean_runs_boreal.csv", header = TRUE) #calls the file
names(caete_3000pls)
caete_3000pls_traits_column<-caete_3000pls[,22:27] #select the traits columns
names(caete_3000pls_traits_column)
pca_3000pls <- prcomp(caete_3000pls_traits_column, scale=TRUE) #performs a PCA for the traits
biplot(pca_3000pls)
summary(pca_3000pls)
pca_3000pls_axes<-pca_3000pls$x #creates a matrix with the pca results
pca_3000pls_axes_traits<-pca_3000pls_axes[,1:3]
hv_pca<-hypervolume(pca_3000pls_axes_traits, method= 'svm')
plot(hv_pca)
summary(hv_pca)
