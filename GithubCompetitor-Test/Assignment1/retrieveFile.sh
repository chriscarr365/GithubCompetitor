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