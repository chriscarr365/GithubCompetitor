selectedRepo="NULL"

mainCase=0

while [[ "$mainCase" = 0 ]]; do
    #statements
    echo "----------MENU----------" 

    echo "select an option by inputting the corresponding number:" 

    if [ "$selectedRepo" == "NULL" ]
        then       
            echo "No repository currently selected"
        else
            echo "Currently using $SelectedRepo"
    fi

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
                #echo "All current files:" 
                optionsCase=1
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











   # echo "1) Create new repository" 

    #echo "2) View all files in the repository" 

   # echo "3) Retrieve file" 

   # echo "4) Update retrieved file" 

   # echo "5) View log file" 

   # echo "6) Roll back a repository"

   # echo "7) Select repository"

   # echo "q) Exit" 

     

  #  read answer 

	#echo "$answer"     

   # case "$answer" in 

     

    #    "1") 
     #   #do something
      #  makeRepository 
       # echo "you uploaded new file" 
        #;; 

         
#        "2") 
        #do something 
        #echo "All current files:" 
 #       viewFiles
 #       ;; 
 #       

 #       "3") 
        #do something 
        #echo "Input the file name you want to retrieve:" 
 #       retrieveFile
  #      ;; 
#
         
 #       "4") 
        #do something 
        #echo "Select the file you want to update:" 
 #       updateRetrievedFile
  #      ;; 
         

  #      5) 
        #do something 
 #       echo "All logs to date:" 
#        ;; 

        
        #repeat above for all options 
 #       "7")
#		echo "Select repository"
#		ls Projects
#		read SelectedRepo
#		;;

         
        #Quits program
#        q) 
#        x=1 
#        ;; 

         
        #below checks for any other unexpected inputs 
#        *) 
#        clear 
#        echo "That is not an option" 
#        sleep 3 
#       ;; 