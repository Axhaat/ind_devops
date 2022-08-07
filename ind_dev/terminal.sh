#! /usr/bin/bash


# making of the structure
mkdir Domain
cd Domain


#adding the domains like domain1, domain2, ......
for n in {1..8}; 
do
    mkdir Domain${n}
done

#creating the sub-directories under each domain
for n in {1..8}; 
do
    cd Domain${n}
    touch inductees.txt
    mkdir announcements
    mkdir grades
    mkdir tasks
    cd tasks
    mkdir submissions
    touch welcome.txt
    touch task1-grades.txt
    touch task1-ps.txt
    
    cd ..
    cd ..
done




#adding user 
sudo useradd user
sudo passwd user

#addiing the root user
sudo useradd root
sudo passwd root


#making root the owner of each domain
for n in {1..8}; 
do
    sudo chown root Domain${n}
done

#creating a group of mentees and mentor for all the domains
for i in {1..8};
do
for n in {1..10}; 
do
sudo usermod -a -G  ment_domain${i} mentee${n}
done
sudo usermod -a -G  ment_domain${i}  mentor${i}
done

#creating a separate group of mentors 
for i in {1..8};
do
sudo usermod -a -G  mentors  mentor${i}
done

#creating a separate groups of meentees
for i in {1..80};
do
sudo usermod -a -G  meentees  Meentee${i}
done


#setting the permission for different users 


#changing the permissions for other users
for i in {1..8};
do
sudo  chmod o+r domain${i}
sudo  chmod o-x domain${i}
done



#giving the permission of the admin, group and others users according to the task
for i in {1..8};
do
cd domain${i}
sudo chown root task
sudo chown root submission
sudo chown root announcement
sudo chown root grades
sudo chown root inductees.txt
sudo chgrp ment_domain${i} task
sudo chgrp meentees submission
sudo chgrp ment_domain${i} announcement
sudo chgrp mentors grades
sudo chmod u+rwx task
sudo chmod g-wx task
sudo chmod u+rwx submission
sudo chmod g+rw submission
sudo chmod o+r submission
sudo chmod u+rwx announcement
sudo chmod u+r grades
sudo chmod g-x grades
sudo chmod o+r grades
sudo chmod o-wx inductees.txt
cd ..
done



#file filtering commands
# Akshat 89 100 ----assuming the grades.txt stores the data this way
echo "Enter the address of the directory whose grades needs to be worked upon "
read dir
cd dir
awk '{ if($2 >= 0.6*$3) echo $1 >> filtered_list.txt;}' grades.txt
cd ..



