library(hypervolume) #load the hypervolume library
caete_50pls<-read.csv("/home/bia/Desktop/paper_mestrado/caete_results_server/resultado_versao_CAETEv1.0/results_first_version_caete/nClimate_constant/out50_mean_runs_tropical.csv", header = TRUE) #calls the file
caete_50pls_traits_column<-caete_50pls[,21:26] #select the traits columns
pca_50pls <- prcomp(caete_50pls_traits_column, scale=TRUE) #performs a PCA for the traits
biplot(pca_50pls)
summary(pca_50pls)
pca_50pls_axes<-pca_50pls$x #creates a matrix with the pca results
pca_50pls_axes_traits<-pca_50pls_axes[1:3] #selects only the 3 first axes
hv_pca<-hypervolume(pca_50pls_axes_traits, method= 'svm')
plot(hv_pca)
summary(hv_pca)
