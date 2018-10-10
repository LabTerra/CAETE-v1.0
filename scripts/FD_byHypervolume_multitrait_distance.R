library(hypervolume) #load the hypervolume library
#1st hypervolume
caete_100pls<-read.csv("/home/bia/Desktop/paper_mestrado/caete_results_server/resultado_versao_CAETEv1.0/results_first_version_caete/nClimate_constant/out100_mean_runs_tropical.csv", header = TRUE) #calls the file
names(caete_100pls)
caete_100pls_traits_column<-caete_100pls[,22:27] #select the traits columns
names(caete_100pls_traits_column)
pca_100pls <- prcomp(caete_100pls_traits_column, scale=TRUE) #performs a PCA for the traits
biplot(pca_100pls)
summary(pca_100pls)
pca_100pls_axes<-pca_100pls$x #creates a matrix with the pca results
pca_100pls_axes_traits<-pca_100pls_axes[,1:3]
hv_pca_100<-hypervolume(pca_100pls_axes_traits, method= 'svm')

#2nd hypervolume
caete_200pls<-read.csv("/home/bia/Desktop/paper_mestrado/caete_results_server/resultado_versao_CAETEv1.0/results_first_version_caete/nClimate_constant/out200_mean_runs_tropical.csv", header = TRUE) #calls the file
names(caete_200pls)
caete_200pls_traits_column<-caete_200pls[,22:27] #select the traits columns
names(caete_200pls_traits_column)
pca_200pls <- prcomp(caete_200pls_traits_column, scale=TRUE) #performs a PCA for the traits
biplot(pca_200pls)
summary(pca_200pls)
pca_200pls_axes<-pca_200pls$x #creates a matrix with the pca results
pca_200pls_axes_traits<-pca_200pls_axes[,1:3]
hv_pca_200<-hypervolume(pca_200pls_axes_traits, method= 'svm')
#calculates the distance
hypervolume_distance(hv_pca_100,hv_pca_200,check.memory = TRUE)



