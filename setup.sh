#!/bin/bash
#By Jorge Cardona

# This file is to set up the required directories and files
# to allow emacs to act as an IDE

_EMACS=$HOME/.emacs
_EMACS_DIR=$HOME/.emacs.d
_EFILE=pkg
_ELINUX=pkgLinux
BACKUP_DIR=$HOME/.originalEmacsFiles.d
USER_OS=`uname`
STATUS=$(dpkg -s emacs | grep status)
INSTALLED="Status: install ok installed"


# For Red Hat Enterprise Linux
RHEL=/etc/redhat-release


# Check if we have $HOME/.emacs file
if [ -e "$_EMACS" ]
then
    echo ".emacs File Exists..."
    sleep 2

    echo "Creating: $BACKUP_DIR"
    sleep 2
    mkdir $BACKUP_DIR

    echo "Backing up files to: $BACKUP_DIR"
    sleep 2
    cp $_EMACS $BACKUP_DIR/

    echo "Making Changes Needed..."
    sleep 2

    case "$USER_OS" in
	"Linux" )
	   cat $_ELINUX > $_EMACS  # Now lets overide the file
	    echo -e "Linux OS Detected"
	    sleep 2

	    if [ "$STATUS" = "$INSTALLED" ]; then
	    	echo -e "Done..."
	    else
		if [ -f "$RHEL" ]; then
			cat $RHEL
			sudo subscription-manager attach --auto
			sudo yum remove emacs -y
			sudo yum install emacs-nox -y
		else
			echo -e "Installing emacs25-nox..."
			sudo apt install emacs25-nox
		fi
	    fi

	    sleep 2
	    ;;
	"Darwin" )
	    cat $_EFILE > $_EMACS  # Now lets overide the file
	    echo -e "OS X Detexted"
	    sleep 2
	    echo -e "Done..."
	    sleep 2
	    ;;

	* )
       	    echo "THIS PROGRAM DOES NOT SUPPORT YOUR OS"
	    exit
	    ;;

    esac

else

    echo "File Does Not Exists..."
    sleep 2

    echo "Creating .emacs File..."
    sleep 2

    touch $_EMACS

    echo "Making Changes Needed..."

    case "$USER_OS" in
	    "Linux" )
		cat $_ELINUX > $_EMACS  # Now lets overide the file
		echo -e "Linux OS Detected"
		sleep 2

                if [ "$STATUS" = "$INSTALLED" ]; then
                   echo -e "Done..."
                else
               		if [ -f "$RHEL" ]; then
                        	cat $RHEL
				sudo subscription-manager attach --auto
                        	sudo yum remove emacs -y
                        	sudo yum install emacs-nox -y
                	else
                    		echo -e "Installing emacs25-nox..."
                        	sudo apt install emacs25-nox
                	fi
		fi

		sleep 2
		;;
	    "Darwin" )
		cat $_EFILE > $_EMACS  # Now lets overide the file
		echo -e "OS X Detexted"
		sleep 2
		echo -e "Done..."
		sleep 2
		;;

	    * )
       		echo "THIS PROGRAM DOES NOT SUPPORT YOUR OS"
		exit
		;;
    esac
fi

if [ -d "$_EMACS_DIR" ]
then
    echo "Directory .emacs.d Exist..."
    sleep 2

    echo "Backing up files to: $BACKUP_DIR"
    sleep 2
    cp -R $_EMACS_DIR/* $BACKUP_DIR/

    
    echo "Making Changes Needed..."
    sleep 2
    cp -R snippets  $_EMACS_DIR/
    
    echo "Done..."
    sleep 2

else
    echo "Directory .emacs.d  Does Not Exist..."
    sleep 2

    echo "Creating: $_EMACS_DIR"
    sleep 2
    mkdir -p $_EMACS_DIR

    echo "Making Changes Needed..."
    sleep 2
    cp -R snippets $_EMACS_DIR
    
    echo "Done..."
    sleep 2
fi


echo -e "\nSAVE ALL YOUR EMACS BUFFERS..."
echo -e "\nEmacs will be loaded to install its plugins...\n"
sleep 7
echo -e "Setup Completed!\n"


# find and save emacs pid
#emacs_pid=$(pgrep emacs)
#kill -9 $emacs_pid


# kill emacs processes
pkill emacs

# re open emacs to load all packages 
emacs

exit
