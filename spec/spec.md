# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database
- [x] Include more than one model class (e.g. User, Post, Category)
    --3 model classes: User, Beach, Review
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
    --User has many reviews; User has many beaches, through reviews
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
    --Review belongs to user; Review belongs to beach
- [x] Include user accounts with unique login attribute (username or email)
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
    --Users can create a new review, view reviews, update existing reviews, and destroy existing reviews
- [x] Ensure that users can't modify content created by other users
    --Logic so current user must match review user_id field to edit or delete reviews
- [x] Include user input validations
    --Validations during signup and creating a new review
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
    --Added flash messages to explain why submissions fail
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
