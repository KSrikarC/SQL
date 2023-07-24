#!/bin/bash
cd '/home/srikar/Desktop/wiley/HackerRank_Shell/python_files'

read -p 'Enter first value : ' a
read -p 'Enter first value : ' b
echo "\n-----TRIGGERING ALL PYTHON SCRIPTS-----"
echo "-----PERFORMING ARTHMETICS OPERATIONS-----"
for file in *.py
do
if [ -f "$file" ]; then
  if [ -f "$file" ] && [ "$file" != "$0" ]; then
    	echo "Running $file..."
    	python3 "$file" "$a" "$b"
      
      echo "Finished running $file"
      echo
  fi

else
	echo "Files not found"
fi 
done
    
