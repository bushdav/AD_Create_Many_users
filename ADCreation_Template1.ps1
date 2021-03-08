$ADUsers = Import-csv <redacted path of the booklet>
foreach ($User in $ADUsers)
{

       $Username    = $User.username
       $Password    = $User.password
       $Firstname   = $User.Firstname
       $Lastname    = $User.Lastname
       $Principal   = $User.Userprincipal_name
       $Path	    = $User.path

       #Check if the user account already exists in AD
       if (Get-ADUser -F {SamAccountName -eq $Username})
       {
               #If user does exist, output a warning message
               Write-Warning "A user account $Username has already exist in Active Directory."
       }
       else
       {
              #If a user does not exist then create a new user account
              #options are limitless, you can add any at your convenience
              New-ADUser `
            -SamAccountName $Username `
            -UserPrincipalName $Principal `
            -Name "$Firstname $Lastname" `
            -GivenName $Firstname `
            -Surname $Lastname `
            -Enabled $True `
            -ChangePasswordAtLogon $True `
            -Path $Path `
            -AccountPassword (convertto-securestring $Password -AsPlainText -Force)

       }
}
