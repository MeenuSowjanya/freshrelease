# &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**```ZUPP - Ticket App```**

***

###### Heroku Link : https://zupp-ticket-app-test.herokuapp.com/
###### Sonarcloud Link : https://sonarcloud.io/project/overview?id=MeenuSowjanya_freshrelease
###### Git Link : https://github.com/MeenuSowjanya/freshrelease

***
***

## Hello🖐 ! Welcome to [ZUPP](https://zupp-ticket-app-test.herokuapp.com/)
<img width="960" alt="image" src="https://user-images.githubusercontent.com/93571047/185191429-e28ae864-6110-489a-a004-95ac6cb4c884.png">

##### I am Meenu Sowjanya and this is my project , ZUPP, An Internal Service Management Software from Freshworks to provide a delightful employee experience.
##### This app is built on Rails which supports 2 user persona and roles: **admin** and **agent**.

##### Here different users get different views of the application, depending upon the roles assigned to them : [ "admin" , "agent"].

***

## Libraries used
###### 
      * Action Mailer
      * Active Storage
      * Active Support
   
***
## Gems used
###### 
      * gem 'pagy'
      * gem 'image_processing'
      * gem 'email_validator'
      * gem 'rubocop'
      * gem 'fontawesome-sass'
      * gem 'jquery-rails'
      * gem 'dotenv'
      * gem 'bcrypt'
      * gem 'mail_form'
      * gem 'tailwind-css' 

***
## Technical Challenges faced and Resolution
### 1. Cloning a ticket
    Problem statement :
    Cloning content was easy , but cloning the images or the files attached to the parent ticket was tough. 
    The input field's datatype of new ticket should be in blob, but the return type from the parent ticket was in binary. 
    
    Solution :
    I referred Active Storage module, and found the ".blobs" extension.  It returned the blob version of the attachments.
    
### 2. Replicating 'public_activity' gem
    Problem statement :
    'public_activity' gem is used to track the Activity log of models. I wished to do the activity log manually. 
     The involvement of many models for tracking the CRUD activities was little complicated to handle.
    
    Solution :
    I referred the Schema of the 'public_activity' gem and designed an EER Diagram for Create, Delete and Update Activities.
    Later, I managed to handle many models.
    
    Extra implementation :
    I could also get the log of a Model before updation and after updation and could display the from status and to status.
    
    
***
## EER Diagram
![eer_model_zupp](https://user-images.githubusercontent.com/93571047/185210485-fabae1cf-e999-444e-8ecf-02e52b822212.png)

***
### To get complete ZOOPER experience of this platform visit [ZUPP](https://zupp-ticket-app-test.herokuapp.com/) and login via *admin* role

######
| First Name | Last Name | Email | Password | Role |
|---- |-----|-------|----|-----|
| Admin | Admin | admin@gmail.com | Admin@1234 | admin |
| Agent | Org | agent1@gmail.com | Agent1@1234 | agent |
######

***
## Features covered

###### Highlight features
      * Mail the link to **Reset Password**
      * Filter the tickets 
      * Sort tickets 
      * Search tickets
      * Clone a ticket
      * Add canned responses as a note
      * Activity log of a ticket and notes
      * Bot Implementation
      
### 1. Sign up
       * All fields are required
       * No fields can be nil
       * First name and Last name must contain atleast 3 characters (Validated with Name Regex Pattern)
       * Email id must be unique
       * Email id must be of the format 'example@gmail.com' (Validated with a gem - 'email_validator')
       * Password must contain atleast 6 characters which must be a combination of atleast one lowercase character,
         one uppercase character,one symbol and one digit
       * Password and Confirm Password must be same 
       * Password encrypted with a gem - 'bcrypt'
<img width="957" alt="image" src="https://user-images.githubusercontent.com/93571047/185213784-b06b3124-77db-4e96-8392-c935c91a3cf4.png">

<br>

### 2. Sign in
        * All fields are required
        * Email id and password should be authenticated - ('bcrypt' gem)
<img width="960" alt="image" src="https://user-images.githubusercontent.com/93571047/185215157-e5a027c1-9fad-4f0f-a8e8-2e969f4ad26c.png">

### 3. Forgot password
###### If an user forgets his/her password 
         * All field are required
         * Email id entered must be a registered user
         * Link to reset password will be sent to the mail id of the user
<img width="960" alt="image" src="https://user-images.githubusercontent.com/93571047/185215815-69becb43-a98a-45f6-9ea1-8579b78ec700.png">

### 4. Reset password
<img width="719" alt="image" src="https://user-images.githubusercontent.com/93571047/185216903-32ce8940-c111-4201-991d-d612f548bc05.png">

##### After receiving this email

          * All fields are required
          * Password must contain atleast 6 characters which must be a combination of atleast one lowercase character,
            one uppercase character,one symbol and one digit
          * Password and Confirm Password must be same 
          * Password encrypted with a gem - 'bcrypt'
<img width="884" alt="image" src="https://user-images.githubusercontent.com/93571047/185612024-7701b220-8a1b-4672-b68d-e2e57b6b46c2.png">


### 5. List tickets
          * Admin can view all the tickets created
          * Agent can only view the tickets assigned to them
###### Highlights
          * List tickets - Pagination
###### 'pagy' gem
<img width="960" alt="image" src="https://user-images.githubusercontent.com/93571047/185220278-d9ff6ee5-ed6c-445f-9b8b-41f5f23da008.png">
          * Filter tickets
<img width="179" alt="image" src="https://user-images.githubusercontent.com/93571047/185219461-2454f257-1683-4ec8-acd1-d4bef1ded2b0.png">
          * Search tickets
<img width="960" alt="image" src="https://user-images.githubusercontent.com/93571047/185220081-6522c3c2-29fd-4cf1-b8cc-e911180d248f.png">
          * Sort by and Group edit features
<img width="752" alt="image" src="https://user-images.githubusercontent.com/93571047/185222072-f1aefe82-6ef0-4538-b1e5-b23722ead737.png">

### 6. Edit ticket properties
         * Admin can only edit the ticket properties
         * Enabled only if the ticket's status is not "closed"

### 7. Create a ticket
         * All fields are required
         * Values cannot be nil
         * Minimum length of text fields must be 2
         * Attaching multiple files is possible
<img width="960" alt="image" src="https://user-images.githubusercontent.com/93571047/185222388-94f6c318-3cfa-45a5-b808-d4a955a74212.png">

### 8. Add note
         * All fileds are required
         * Values cannot be nil
         * Attaching multiple files is possible
         * Enabled only when the ticket's status is not "closed"
<img width="440" alt="image" src="https://user-images.githubusercontent.com/93571047/185222902-d3795efb-6004-47e8-846f-a451079c2453.png">

### 9. List notes
         * The date and time calculation were did manually in the application helper and called multiple times
<img width="956" alt="image" src="https://user-images.githubusercontent.com/93571047/185223206-32e8eb4c-9e58-4ab3-a5f1-c2d3efc3bcb3.png">

### 10. Edit notes
         * Allowation of editing the subject of a note is only given.
         * Tracked in Activity Log
         * Enabled only when the ticket's status is not "closed"
<img width="471" alt="image" src="https://user-images.githubusercontent.com/93571047/185299391-ddb60024-b96f-4aae-8cf7-d512a68f4898.png">

### 11. Delete notes
         * Tracked in activity log
         * Did a temporary destroy using trash method and restored the content without ticket id for activity log

### 12. View Activity log
         * Replication of 'public_activity' gem in manual
<img width="958" alt="image" src="https://user-images.githubusercontent.com/93571047/185300663-412c1391-63f4-4e65-8ad0-ba2bb53d32cf.png">

### 13. BOT features

         * Close a ticket (Enabled only if the ticket's status is not "closed")
<img width="238" alt="image" src="https://user-images.githubusercontent.com/93571047/185301331-0f26bb8e-f789-4d23-a015-a1a3c2d3a7bc.png">

         * Delete a ticket (Enabled only for admin)
<img width="240" alt="image" src="https://user-images.githubusercontent.com/93571047/185301526-a604fb5d-e4e1-4fc5-bf2c-ac4db45c3224.png">

         * Clone a ticket
<img width="238" alt="image" src="https://user-images.githubusercontent.com/93571047/185301607-8143e16c-9852-4256-b9e5-98bb54f973ce.png">

         * Add a Canned Response (Belongs to user) (Create own canned responses feature is ON PROGRESS)
<img width="242" alt="image" src="https://user-images.githubusercontent.com/93571047/185301776-2dd43e69-b5e6-412c-8182-df022623f78d.png">

         * Reopen a ticket (Enabled only if the ticket's status is closed)
<img width="237" alt="image" src="https://user-images.githubusercontent.com/93571047/185302059-c2437f81-ef04-448f-94c2-0ae5bc21aa1f.png">

***

## More Insights into Different Persona
#### 1. ADMIN
###### Can: 
      * View all tickets
      * Create new ticket
      * Edit ticket properties
      * Delete a ticket
      * Clone a ticket
      * Pickup a ticket
      * Assign a ticket to other agent
      * Pickup a group of tickets
      * Assign a group of tickets to other agents
      * Add notes for a specific ticket
      * View activity logs of a ticket
      * Access bot for Deleting a ticket, Closing a ticket, Cloning a ticket, Add Canned Responses, View Activity Log
        and Reopening a Ticket.


<hr>

#### 2. AGENT
###### Can:
      * View tickets assigned
      * Create a new ticket
      * Clone a ticket
      * Close a ticket
      * View notes
      * Add notes 
      * Edit notes
      * Delete notes
      * View activity log of tickets
      * Access bot for Closing a Ticket, Reopening a ticket, Cloning a ticket, Add Canned Responses, View Activity Log.

*** 
## Future plans

#### Features
##  
    * Include User Management
    * Create canned responses
    * Build an archive or trash and restore tickets or notes
    * Implement Action Cable for Live notes addition
    * Implement Lazy Loading
    
#### UI
##
    * Toggle to detailed view of next ticket


    
   

   

















   







