import-module ActiveDirectory
#do
#{
    $userFName = read-host "Enter first name or Q TO QUIT" 
    $userLName = read-host "Enter last name or Q TO QUIT"
    $userName = $userFNAme + " " + $userLName
    $user = Get-ADUser -filter {name -eq $userName}
    
    if (!$user)
        {
            write-host "No user found with name" $userName
        }
        else
        {
            write-host "-----------------------------------"
            write-host "Current Profile"
            write-host "-----------------------------------"
            Get-ADUser $user -Properties * | select-object Name,Title,Department,Company,Office,Description,employeeOfficer
            $userTitle = (Get-ADUser $user -Properties *).Title
            $userTitleNew = read-host ("New Title[" + $userTitle + "]")
            $userDept = (Get-ADUser $user -Properties *).Department
            $userDeptNew = read-host ("New Department[" + $userDept + "]")
            $useremployeeOfficer = (Get-ADUser $user -Properties *).employeeOfficer
            if($userTitleNew -ne "")
            {
              $userTitle = $userTitleNew
            }
            if($userDeptNew -ne "")
            {
              $userDept = $userDeptNew
            }
            $userDesc = ($userTitle + " - " + $userDept)
#            write-host $userTitle
#            write-host $userDept
#            write-host $userDesc
             write-host "-----------------------------------"
             write-host "updated profile"
             write-host "-----------------------------------"
            set-aduser $user -Title $userTitle -Department $userDept -Description $userDesc -employeeOfficer $useremployeeOfficer
            Get-ADUser $user -Properties * | select-object Name,Title,Department,Company,Office,Description,employeeOfficer
         }
         
#}while (($userFName -ne "Q") -or ($userLName -ne "Q"))

