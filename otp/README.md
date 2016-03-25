###Generate password

 1. Execute script generate_passwd.sh:
    ```$ ./generate_passwd.sh```
    
 2. Enter new prefix password (example ***test***).
 
 3. Reenter prefix password.
 
 4. Check file otp/keys.txt
 
 5. Connect to docker via ssh.
    ```ssh sa@docker_host -p 2205```
 
 6. Set password with prefix:
    Example: ```test2321fded```
    ***test*** - prefix
    ***2321fded*** - password from list of OTP
    