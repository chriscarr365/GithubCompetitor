#Made By
#Christopher Carr 170025705
#Christian Hegarty 170010924
#Tony Wright 170016265
#
#
#
#
#
#

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
	echo "$newUser" >> ListOfUsers

}

makeRepository()
{ 

    y=0 
    success=false
     

    while [ $y = 0 ] 

    do 

        clear 

        while [ "$success" = false ]; do

            echo "Enter the repository name:"  

  

            read repoName 

  
        
            mkdir Projects/"$repoName" 
                if [ "$?" = "0" ]; then
                    success=true
                 else 
                    clear
                     echo "Folder Creation Error, please check and try again"
                    success=false
                fi
        done
        success=false
          mkdir Projects/"$repoName"/Backups 

  

          cd Projects/"$repoName"/ 

  

          touch .checkouts 

  

          cd ../.. 
        SelectedRepo=$repoName

        while [ "$success" = false ]; do
        echo "please enter the path and name of the file you want to use as the initial file for the repositry"  
                read fileRef
                if [ ! -f "$fileRef" ]; then
                    clear
                    echo "File copy error, please check and try again"
                    success=false
                else 
                    success=true
                    cp $fileRef Projects/"$repoName"/"$fileRef"  
                fi
                done
 

        y=1  

  

     done 

     dateTime=$(date '+%d/%m/%Y %H:%M:%S');

     echo "$user saved new version of $SelectedRepo on $dateTime " >> log

     echo "$repoName" >> ListOfRepos

} 

retrieveFile()
{ 

  

    y=0 

  

    while [ $y = 0 ] 

    do   

  

        clear  

  

        echo "Please enter the name of the file to retreive from the following: "
        ls "Projects/$SelectedRepo"

        read fToRetrieve 
        if grep -Fxq "$fToRetrieve" Projects/"$SelectedRepo"/.checkouts
        then
            echo "WARN: This file has already been checked out by you or another user"
            echo "You may continue, but this may cause conflicts later on"
            echo "Do you want to continue? y/n"
            read continueYN
        fi
        
        case "$continueYN" in
            "y") 
                echo "Continuing..."
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
                #echo "$fToRetrieve" >> "Projects/$SelectedRepo/.checkouts"
                file1=Projects/"$SelectedRepo"/.checkouts
                echo "$fToRetrieve" >> $file1 
                sleep 2 
            ;; 

  

            "n") 

                echo "Please input the path to the directory you would like to save to" 

                echo "The path will start at your home directory" 

                echo "e.g. Documents/myFolder" 

      

                read path 

      

                cp ./Projects/TestProject/"$fToRetrieve" ~/"$path"/"$fToRetrieve" 
                #echo "$fToRetrieve" << "Projects/$SelectedRepo/.checkouts"
                file1=Projects/"$SelectedRepo"/.checkouts
                echo "$fToRetrieve" >> $file1 
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

        dt=$(date '+%d.%m.%Y %H.%M.%S');

        
     

        echo "please enter the path and name of the file you want to add to the repository" 

        echo "e.g. $SelectedRepo/fileName.txt" 

         

        read fileRef 

        
        cp Projects/"$SelectedRepo"/"$fileRef" Projects/"$SelectedRepo"/Backups/"$fileRef $dt"

        cp $fileRef Projects/"$SelectedRepo"/"$fileRef"

        

        y=1 

     done

     dateTime=$(date '+%d/%m/%Y %H:%M:%S');

     echo "$user saved new version of $SelectedRepo on $dateTime " >> log

     echo "Would you like to add any additional comments?" 

     echo "y/n" 

  

     read answer 

  

     case "$answer" in 

  

     "y") 

        echo "Enter comments:" 

  

        read comments 

  

        echo "$user : $comments" >> log 

     ;; 

  

     "n") 

     ;; 

  

     esac 

} 

rollBackFile()
{
    echo "Select Which file to roll back to: "
    ls Projects/"$SelectedRepo"/Backups/
    read rollBackChoice

    cp Projects/"$SelectedRepo"/Backups/"$rollBackChoice" Projects/"$SelectedRepo"/Project
}

viewFiles() 

{ 
    clear 

    echo "Here is a list of all files currently in the repository:" 
    ls Projects/"$SelectedRepo"/
    ls Projects/"$SelectedRepo"/Backups

    echo "Enter any key to go back to the menu" 

    read exit 
} 

viewLogs()
{
    echo "All logs to date"
    less Log
}

currentRepo=0

initLoop=0

userLoop=0

while [ $userLoop = 0 ]
do
	echo "Select user"
	cat ListOfUsers
    echo
	read user

    if grep -Fxq "$user" ListOfUsers  
        then
            userLoop=1
        else
            echo "User not found, try again"
    fi	
done

while [ $initLoop = 0 ] 
	do
	#SETS UP WHICH REPOSITORY TO USE AT PROGRAM STARTUP
	echo "Select or create repository (S/C)"
	read selectOrCreate

    case $selectOrCreate in

        "S" | "s")

            selectRepoLoop=0

            while [ $selectRepoLoop = 0 ] 
            do
                echo "Select repository"
                ls Projects
                read SelectedRepo



                if grep -Fxq "$SelectedRepo" ListOfRepos 
                    then
                        selectRepoLoop=1
                    else
                        echo "Repository not found, try again"
                fi
            done

            


            initLoop=1
            ;;

        "C" | "c")
            makeRepository
            initLoop=1
            ;;
            
        *)
            echo "Invalid choice, try again"
            ;;
    esac	
done




clear 


mainCase=0

while [ "$mainCase" = 0 ]
do
    #statements
    echo "----------MENU----------"
    echo " "
    echo "Current User: $user"
    echo "Current Repository: $SelectedRepo"
    echo " "
    echo "Select an option by inputting the corresponding number:" 
    echo " "
    echo "1) Repositories"
    echo "2) Options"
    echo "3) Quit"

    read answer 
    

    case "$answer" in 
     
        "1") 
    
        repoCase=0

        while [ "$repoCase" = 0 ]
        do

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
                viewLogs 
                ;; 

            
                "6") 
                #do something 
                rollBackFile
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

        while [ "$optionCase" = 0 ]
        do
            #statements
            #New nested case for options menu
            echo "1) Select repository"
            echo "2) Create new user"
            echo "3) Select user"
            echo "4) Return to main menu"

            read optionsAnswer 
        
            case "$optionsAnswer" in 
     
                "1") 
                #do something
                selectRepoLoop=0

                while [ $selectRepoLoop = 0 ] 
                do
                    echo "Select repository"
                    ls Projects
                    read SelectedRepo



                    if grep -Fxq "$SelectedRepo" ListOfRepos 
                        then
                            selectRepoLoop=1
                        else
                            echo "Repository not found, try again"
                    fi
                done 
                
                ;; 

                "2") 
                #do something 
                #echo "All current files:" 
                addUser
                ;;

                "3") 
                #exits while loop goes to main menu                
                userLoop=0

                while [ $userLoop = 0 ]
                do
                    echo "Select user"
                    cat ListOfUsers
                    read user

                    if grep -Fxq "$user" ListOfUsers  
                    then
                        userLoop=1
                    else
                        echo "User not found, try again"
                    fi
    
                done
                ;;

                "4")    
                optionCase=1
                ;;

                #below checks for any other unexpected inputs 
                *) 
                clear 
                echo "That is not an option" 
                sleep 2 
                ;; 

            esac
        done
        ;; 
        

        "3") 
        #Quits program
        mainCase=1
        ;; 

        *)
        echo "Invalid option"
        ;;

    esac
done

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
	echo "$newUser" >> ListOfUsers

}

makeRepository()
{ 

    y=0 
    success=false
     

    while [ $y = 0 ] 

    do 

        clear 

        while [ "$success" = false ]; do

            echo "Enter the repository name:"  

  

            read repoName 

  
        
            mkdir Projects/"$repoName" 
                if [ "$?" = "0" ]; then
                    success=true
                 else 
                    clear
                     echo "Folder Creation Error, please check and try again"
                    success=false
                fi
        done
        success=false
          mkdir Projects/"$repoName"/Backups 

  

          cd Projects/"$repoName"/ 

  

          touch .checkouts 

  

          cd ../.. 
        SelectedRepo=$repoName

        while [ "$success" = false ]; do
        echo "please enter the path and name of the file you want to use as the initial file for the repositry"  
                read fileRef
                if [ ! -f "$fileRef" ]; then
                    clear
                    echo "File copy error, please check and try again"
                    success=false
                else 
                    success=true
                    cp $fileRef Projects/"$repoName"/"$fileRef"  
                fi
                done
 

        y=1  

  

     done 

     dateTime=$(date '+%d/%m/%Y %H:%M:%S');

     echo "$user saved new version of $SelectedRepo on $dateTime " >> log

     echo "$repoName" >> ListOfRepos

} 

retrieveFile()
{ 

  

    y=0 

  

    while [ $y = 0 ] 

    do   

  

        clear  

  

        echo "Please enter the name of the file to retreive from the following: "
        ls "Projects/$SelectedRepo"

        read fToRetrieve 
        if grep -Fxq "$fToRetrieve" Projects/"$SelectedRepo"/.checkouts
        then
            echo "WARN: This file has already been checked out by you or another user"
            echo "You may continue, but this may cause conflicts later on"
            echo "Do you want to continue? y/n"
            read continueYN
        fi
        
        case "$continueYN" in
            "y") 
                echo "Continuing..."
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
                #echo "$fToRetrieve" >> "Projects/$SelectedRepo/.checkouts"
                file1=Projects/"$SelectedRepo"/.checkouts
                echo "$fToRetrieve" >> $file1 
                sleep 2 
            ;; 

  

            "n") 

                echo "Please input the path to the directory you would like to save to" 

                echo "The path will start at your home directory" 

                echo "e.g. Documents/myFolder" 

      

                read path 

      

                cp ./Projects/TestProject/"$fToRetrieve" ~/"$path"/"$fToRetrieve" 
                #echo "$fToRetrieve" << "Projects/$SelectedRepo/.checkouts"
                file1=Projects/"$SelectedRepo"/.checkouts
                echo "$fToRetrieve" >> $file1 
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

        dt=$(date '+%d.%m.%Y %H.%M.%S');

        
     

        echo "please enter the path and name of the file you want to add to the repository" 

        echo "e.g. $SelectedRepo/fileName.txt" 

         

        read fileRef 

        
        cp Projects/"$SelectedRepo"/"$fileRef" Projects/"$SelectedRepo"/Backups/"$fileRef $dt"

        cp $fileRef Projects/"$SelectedRepo"/"$fileRef"

        

        y=1 

     done

     dateTime=$(date '+%d/%m/%Y %H:%M:%S');

     echo "$user saved new version of $SelectedRepo on $dateTime " >> log

     echo "Would you like to add any additional comments?" 

     echo "y/n" 

  

     read answer 

  

     case "$answer" in 

  

     "y") 

        echo "Enter comments:" 

  

        read comments 

  

        echo "$user : $comments" >> log 

     ;; 

  

     "n") 

     ;; 

  

     esac 

} 

rollBackFile()
{
    echo "Select Which file to roll back to: "
    ls Projects/"$SelectedRepo"/Backups/
    read rollBackChoice

    cp Projects/"$SelectedRepo"/Backups/"$rollBackChoice" Projects/"$SelectedRepo"/Project
}

viewFiles() 

{ 
    clear 

    echo "Here is a list of all files currently in the repository:" 
    ls Projects/"$SelectedRepo"/
    ls Projects/"$SelectedRepo"/Backups

    echo "Enter any key to go back to the menu" 

    read exit 
} 

viewLogs()
{
    echo "All logs to date"
    less Log
}

currentRepo=0

initLoop=0

userLoop=0

while [ $userLoop = 0 ]
do
	echo "Select user"
	cat ListOfUsers
    echo
	read user

    if grep -Fxq "$user" ListOfUsers  
        then
            userLoop=1
        else
            echo "User not found, try again"
    fi	
done

while [ $initLoop = 0 ] 
	do
	#SETS UP WHICH REPOSITORY TO USE AT PROGRAM STARTUP
	echo "Select or create repository (S/C)"
	read selectOrCreate

    case $selectOrCreate in

        "S" | "s")

            selectRepoLoop=0

            while [ $selectRepoLoop = 0 ] 
            do
                echo "Select repository"
                ls Projects
                read SelectedRepo



                if grep -Fxq "$SelectedRepo" ListOfRepos 
                    then
                        selectRepoLoop=1
                    else
                        echo "Repository not found, try again"
                fi
            done

            


            initLoop=1
            ;;

        "C" | "c")
            makeRepository
            initLoop=1
            ;;
            
        *)
            echo "Invalid choice, try again"
            ;;
    esac	
done




clear 


mainCase=0

while [ "$mainCase" = 0 ]
do
    #statements
    echo "----------MENU----------"
    echo " "
    echo "Current User: $user"
    echo "Current Repository: $SelectedRepo"
    echo " "
    echo "Select an option by inputting the corresponding number:" 
    echo " "
    echo "1) Repositories"
    echo "2) Options"
    echo "3) Quit"

    read answer 
    

    case "$answer" in 
     
        "1") 
    
        repoCase=0

        while [ "$repoCase" = 0 ]
        do

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
                viewLogs 
                ;; 

            
                "6") 
                #do something 
                rollBackFile
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

        while [ "$optionCase" = 0 ]
        do
            #statements
            #New nested case for options menu
            echo "1) Select repository"
            echo "2) Create new user"
            echo "3) Select user"
            echo "4) Return to main menu"

            read optionsAnswer 
        
            case "$optionsAnswer" in 
     
                "1") 
                #do something
                selectRepoLoop=0

                while [ $selectRepoLoop = 0 ] 
                do
                    echo "Select repository"
                    ls Projects
                    read SelectedRepo



                    if grep -Fxq "$SelectedRepo" ListOfRepos 
                        then
                            selectRepoLoop=1
                        else
                            echo "Repository not found, try again"
                    fi
                done 
                
                ;; 

                "2") 
                #do something 
                #echo "All current files:" 
                addUser
                ;;

                "3") 
                #exits while loop goes to main menu                
                userLoop=0

                while [ $userLoop = 0 ]
                do
                    echo "Select user"
                    cat ListOfUsers
                    read user

                    if grep -Fxq "$user" ListOfUsers  
                    then
                        userLoop=1
                    else
                        echo "User not found, try again"
                    fi
    
                done
                ;;

                "4")    
                optionCase=1
                ;;

                #below checks for any other unexpected inputs 
                *) 
                clear 
                echo "That is not an option" 
                sleep 2 
                ;; 

            esac
        done
        ;; 
        

        "3") 
        #Quits program
        mainCase=1
        ;; 

        *)
        echo "Invalid option"
        ;;

    esac
done
