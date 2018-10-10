caete_50pls_tropical<-read.csv("/home/bia/Desktop/paper_mestrado/caete_results_server/resultado_versao_CAETEv1.0/results_first_version_caete/nClimate_constant/out50_mean_runs_tropical.csv", header = TRUE) #calls the file
names(caete_50pls_tropical)
caete_100pls_tropical<-read.csv("/home/bia/Desktop/paper_mestrado/caete_results_server/resultado_versao_CAETEv1.0/results_first_version_caete/nClimate_constant/out100_mean_runs_tropical.csv", header = TRUE) #calls the file
names(caete_100pls_tropical)
caete_200pls_tropical<-read.csv("/home/bia/Desktop/paper_mestrado/caete_results_server/resultado_versao_CAETEv1.0/results_first_version_caete/nClimate_constant/out200_mean_runs_tropical.csv", header = TRUE) #calls the file
names(caete_200pls_tropical)
caete_500pls_tropical<-read.csv("/home/bia/Desktop/paper_mestrado/caete_results_server/resultado_versao_CAETEv1.0/results_first_version_caete/nClimate_constant/out500_mean_runs_tropical.csv", header = TRUE) #calls the file
names(caete_500pls_tropical)
caete_1000pls_tropical<-read.csv("/home/bia/Desktop/paper_mestrado/caete_results_server/resultado_versao_CAETEv1.0/results_first_version_caete/nClimate_constant/out1000_mean_runs_tropical.csv", header = TRUE) #calls the file
names(caete_1000pls_tropical)
caete_3000pls_tropical<-read.csv("/home/bia/Desktop/paper_mestrado/caete_results_server/resultado_versao_CAETEv1.0/results_first_version_caete/nClimate_constant/out3000_mean_runs_tropical.csv", header = TRUE) #calls the file
names(caete_3000pls_tropical)
caete_cmass_tropical<-rbind(caete_50pls_tropical,caete_100pls_tropical,caete_200pls_tropical,caete_500pls_tropical,caete_1000pls_tropical,caete_3000pls_tropical)
names(caete_cmass_tropical)
cmass_tropical<-caete_cmass_tropical[,15]
npls_tropical<-caete_cmass_tropical[,1]
boxplot(cmass_tropical~npls_tropical,data=caete_cmass_tropical, outline=FALSE)

