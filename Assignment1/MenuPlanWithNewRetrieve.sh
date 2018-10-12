newProject()
{
	echo "Project name: "
	read -p 

	echo "Name: $projectName" > /Projects
	makdir "/$projectName"
}

deleteProject()
{

	echo "Project name: "
	read -p projectName
	rm -rf "/$projectName"
}

addUser()
{
	echo "Name of new user: "
	read newUser
	echo "$newUser"
	printf "%s" "$newUser"
	printf "%s" "$newUser" >> ListOfUsers

}

currentRepo=0




initLoop=0

userLoop=0

while [ $userLoop = 0 ]
	 do
	echo "Select user"
	echo "Save Changed"
	cat ListOfUsers
	read user
	userLoop=1
done

while [ $initLoop = 0 ] 
	do
	#SETS UP WHICH REPOSITORY TO USE AT PROGRAM STARTUP
	echo "Select or create repository (S/C)"
	read selectOrCreate
	if [ "$selectOrCreate" == "S" ] 
		then
			echo "Select repository"
			ls Projects
			read SelectedRepo
			initLoop=1
	fi

	if [ "$selectOrCreate" == "C" ] 
		then
			makeRepository
			initLoop=1
	fi
	
done










makeRepository()
{ 

  echo "method test"

  sleep 2

    y=0 

     

    while [ $y = 0 ] 

    do 

        clear 

      	echo "please enter the repositry name" 

      	read repoName

		mkdir Projects/"$repoName"
      	
      	mkdir Projects/"$repoName"/Backups

      	cd Projects/"$repoName"/

      	touch .checkouts

      	cd ../..

        echo "please enter the path and name of the file you want to use as the initial file for the repositry" 

       # echo "e.g. Project/fileName.txt" 

        read fileRef 

       # dt=$(date '+%d.%m.%Y %H.%M.%S');

        cp $fileRef Projects/"$repoName"/"$fileRef" 

         

        y=1 

     done

     dateTime=$(date '+%d/%m/%Y %H:%M:%S');

     echo "User saved new version of project on $dateTime " >> log

} 

retrieveFile(){    
    y=0    

    while [ $y = 0 ]    
   do    

     clear   


        echo "Please enter the name of the file to retreive from the following: "    

        SelectedRepo=Test #FOR TESTING 

        ls "Projects/$SelectedRepo" 

  

        read fToRetrieve  

        if grep -Fxq "fToRetrieve" Projects/"$SelectedRepo"/.checkouts 

        then 

            echo "WARN: This file has already been checked out by you or another user" 

            echo "You may continue, but this may cause conflicts later on" 

            echo "Do you want to continue? y/n" 

            read continueYN 

        fi 

         

        case "$continueYN" in 

        "y")  

            echo "continuing" 

        ;; 

  

        "n") 

            return 

        ;; 

        esac 

         

        echo "Do you want this file to be saved to your Downloads?"  

  

        echo "y/n"  


        read answer  

        case "$answer" in  

  
        "y")  

  

            cp ./Projects/"$SelectedRepo"/"$fToRetrieve" ~/Downloads/"$fToRetrieve"  

            echo "File copied to Downloads" 

            echo "$fToRetrieve" >> "Projects/$SelectedRepo/.checkouts" 

            sleep 2 

        ;;  

        "n")  

  

            echo "Please input the path to the directory you would like to save to"  

  

            echo "The path will start at your home directory"  

  

            echo "e.g. Documents/myFolder"  

 
            read path  

            cp ./Projects/TestProject/"$fToRetrieve" ~/"$path"/"$fToRetrieve"  

            echo "$fToRetrieve" << "Projects/$SelectedRepo/.checkouts" 

        ;;  

        esac  

 
        y=1  

      done  
}   


updateRetrievedFile()
{ 

  

    y=0 

     

    while [ $y = 0 ] 

    do 

        clear 


        #mv  
     

        echo "please enter the path and name of the file you want to add to the repository" 

        echo "e.g. $SelectedRepo/fileName.txt" 

         

        read fileRef 

        dt=$(date '+%d.%m.%Y %H.%M.%S');

        cp $fileRef Projects/"$SelectedRepo"/Project 

         

        y=1 

     done

     dateTime=$(date '+%d/%m/%Y %H:%M:%S');

     echo "$user saved new version of $SelectedRepo on $dateTime " >> log

} 

viewFiles() 

{ 

 #   y=0 

     

 #   while [ $y = 0 ] 

  #  do 

     

    clear 

     

    echo "Here is a list of all files currently in the repository:" 

    

    ls Projects/"$SelectedRepo"/

     

    echo "Enter any key to go back to the menu" 

     

    read exit 

     

   # case "$exit" in 
#
 #    "q") 
#
 #    y=1 
#
 #    ;; 

    #done 

} 


clear 



mainCase=0

while [[ "$mainCase" = 0 ]]; do
    #statements
    echo "----------MENU----------"     
    echo "$user"
    echo "select an option by inputting the corresponding number:" 

 #   if[ "$selectedRepo" == "NULL" ];
 #       then       
 #           echo "No repository currently selected"
 #       else
 #           echo "Currently using $SelectedRepo"
 #   fi

    echo "1) Repositories"
    echo "2) Options"
    echo "3) Quit"

    read answer 
    

    case "$answer" in 
     
        "1") 
    
        repoCase=0

        while [[ "$repoCase" = 0 ]]; do

            #New nested case for repository menu
            echo "1) Create new repository"
            echo "2) View all files in the repository"
            echo "3) Retrieve file"
            echo "4) Update retrieved file"
            echo "5) View log file"
            echo "6) Roll back a repository"
            echo "7) Return to main menu"


            read repositoryAnswer 
        
            case "$repositoryAnswer" in 
     
                "1") 
                #do something
                makeRepository 
                echo "you uploaded new file" 
                ;; 

                "2") 
                #do something 
                #echo "All current files:" 
                viewFiles
                ;; 
        

                "3") 
                #do something 
                #echo "Input the file name you want to retrieve:" 
                retrieveFile
                ;; 

         
                "4") 
                #do something 
                #echo "Select the file you want to update:" 
                updateRetrievedFile
                ;; 
         

                "5") 
                #do something 
                echo "All logs to date:" 
                ;; 

            
                "6") 
                #do something 
                echo "Roll back option not yet implemented:" 
                ;; 


                "7") 
                #do something 
                repoCase=1 
                ;;

                *) 
                clear 
                echo "That is not an option" 
                sleep 3 
                ;; 

            esac
        done

        ;; 

         
        "2") 

        optionCase=0

        while [[ "$optionCase" = 0 ]]; do
            #statements
            #New nested case for options menu
            echo "1) Select repository"
            echo "2) Select user"
            echo "3) Return to main menu"

            read optionsAnswer 
        
            case "$optionsAnswer" in 
     
                "1") 
                #do something
                echo "Select repository"
				ls Projects
				read SelectedRepo 
                
                ;; 

                "2") 
                #do something 
                #echo "All current files:" 
                viewFiles
                ;;

                "3") 
                #do something 
                #echo "All current files:" 
                optionCase=1
                ;;

                #below checks for any other unexpected inputs 
                *) 
                clear 
                echo "That is not an option" 
                sleep 3 
                ;; 

            esac
        done

        ;; 
        

        "3") 
        #Quits program
        mainCase=1
        ;; 

    esac
done