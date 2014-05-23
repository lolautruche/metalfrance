<?php /* #?ini charset="utf-8"?

[General]
AllowedTypes[]=LastReviews
AllowedTypes[]=LastInterviewsLiveReports
AllowedTypes[]=LastPhotosHome

[LastReviews]
Name=Dernières chroniques publiées
NumberOfValidItems=10
NumberOfArchivedItems=5
ManualAddingOfItems=disabled
ViewList[]=coverflow
ViewName[coverflow]=Coverflow
FetchClass=eZFlowLatestObjects
FetchFixedParameters[Class]=mf_chronique_cd
FetchFixedParameters[Source]=2
FetchFixedParameters[Limit]=15
AllowedClasses[]=frontpage

[LastInterviewsLiveReports]
Name=Interviews + Live reports (home)
NumberOfValidItems=5
NumberOfArchivedItems=5
ManualAddingOfItems=disabled
ViewList[]=carrousel
ViewName[carrousel]=Carrousel
FetchClass=eZFlowLatestObjects
FetchFixedParameters[Class]=mf_livereport;mf_interview
FetchFixedParameters[Source]=2
FetchFixedParameters[Limit]=10
AllowedClasses[]=frontpage

[LastPhotosHome]
Name=Dernières photos (home)
NumberOfValidItems=6
NumberOfArchivedItems=6
ManualAddingOfItems=disabled
ViewList[]=polaroid
ViewName[polaroid]=Liste polaroids
FetchClass=eZFlowLatestObjects
FetchFixedParameters[Class]=mf_gallerie
FetchFixedParameters[Source]=8854
FetchFixedParameters[Limit]=10
AllowedClasses[]=frontpage

*/ ?>
