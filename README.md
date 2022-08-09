# YourNextCharacter

[My GitHub Repo](https://github.com/iamcrjones/YourNextCharacter)

[Link to my deployed app](https://yournextcharacter.herokuapp.com/)

[My Trello Board](https://trello.com/b/1nXtEW6n/cameronjonesmarketplaceapp)

### Identification of the problem this app tries to solve and why this problem needs solving.

People who have played Dungeons & Dragons before know that creating your character is such a huge aspect of the game as that is who you will play as for that adventure campaign. Whilst character creation is extremely fun and is integral to the game, it can become very time consuming going through all of the steps for character creation. For new players, this is amplified and can become rather intimidating and overwhelming for them.

This is where YourNextCharacter comes in to save the day! This website allows creative people and seasoned D&D veterans alike to share their characters with the world by uploading their character sheet pdf files and allowing other users to download them, giving new players an easier way to get into the game, and letting other people express their creativity with their characters for others to see.

### Description of your marketplace app (website), including:
- Purpose
- Functionality / features
- Sitemap
- Screenshots
- Target audience
- Tech stack (e.g. html, css, deployment platform, etc)

##### Purpose:
The purpose of this website is to help people find characters they would like to use in the game Dungeons & Dragons. This website can help save people a lot of time creating characters, it can help ease new players into the game, and it allows people who are good at creating characters to have a platform to share their work.

##### Functionality & Features:
Here are the main features of the website:
###### Authentication:
One of the first features that users will encounter in this website is the authentication via the use of devise to setup the user model. If a user is not signed in, they will not be able to view the links to the pdf files or write reviews.

When a User is signed up and logged in, they then have access to being able to do those things, as well as gaining the ability to upload their own character sheets and also add characters to their favourites for easy access later on.

This is a crucial feature as the use of devise and user authentication branches out for users to be able to access the other features of this website.

###### Races and classes:
Users have the ability to view descriptions of the races and classes currently available on the website wether they are logged in or not. The races and classes have descriptions, and desired stats(class) or traits(race) depending on what is being viewed.

###### Character sheet uploading & downloading:
Signed in users have the ability to upload their own character sheets that they have created, or view and download pdf files of other user's character sheets.

When a user is uploading their character sheet, they must fill out every element of the form which includes a name, level, race, class, description, and pdf file.

When filling out the form, races and classes are provided as options through collections which displays the names of those attributes but provides the ID to be used as the foreign key on the character sheet.

The file upload will only accept pdf documents which helps prevent malicious files from being uploaded.

###### Favourites
As well as being able to download the pdf files of characters uploaded to the website, signed in users also have the ability to add or remove characters from their favourites list. Adding characters to favourites helps the user easily access characters if they need to download the pdf file again for one reason or another.

##### Sitemap
insert sitemap here

##### Wireframes
insert here

##### Screenshots

insert here

##### Target Audience
The target audience for YourNextCharacter is essentially anyone who plays or wants to play Dungeons & Dragons. It offers the ability for new and experienced players to access character sheets on the fly and jump straight into the game, or to help gain inspiration for their own character they are making.

This website also targets people who love to create characters for the fun of it but don't have anywhere to share them. YourNextCharacter is the perfect platform for this!

##### Tech Stack
- HTML 5
- SCSS & Bootstrap for styling
- Rails version 6.1.5
- Ruby version 3.0.2
- Node version 16.13.2
- PostgreSQL for Database
- Git for version control

###### Ruby Gems
- AWS SDK & AWS SDK S3 for Active Storage file uploading
- Devise for Users model and authentication
- Simple form for the forms used in the website and to help sanitize inputs

###### Third Party Services
AWS S3 - S3 is an object storage service that offers scalability, data availability, security, and performance. It allows Your Next Character to have the ability to upload and store the PDF files for characters in a secure and efficient manner.

Heroku for deployment - Heroku is a container-based cloud Platform as a Service. Heroku is used to deploy, manage, and scale modern apps. This app makes use of the free model for Heroku which is perfect for small projects. The deployment process is streamlined as the app can be deployed using git commands straight from the terminal allowing easy updates.

GitHub - GitHub is a website and cloud-based service that helps developers store and manage code, as well as track and control changes made to the code.

### High Level Components(abstractions) in the app
This application was built using the Rails MVC architecture. The controllers for the app interact with either the models, the views, or both at the same time depending on the action that is taking place.

The model then interacts with the database using ActiveRecord. The model handles all query logic, which then passes information back to the controller, which then sends the information to the view so the user is able to see a rendering of the data they have passed through the application.

The components for this application are as follows:

###### User:
I used the Devise gem to create the User model. At this point in time, the only crud operation a user can currently do is to create their account.

The user is able to view all Races, Classes, and Characters before signing up. However the user must be logged in to be able to upload their own characters, view the pdf files of the characters, write reviews, and add characters to their favourites list.

This was achieved by using different if/else statements in the views and controllers, and also for specific actions I specified that the controller must authenticate the user before proceeding with the action.

Users are connected to the other components through models with has_many relationships.

###### Races & Classes:
I am discussing races and classes in the same section here as they both behave in the same way.

I created the models for both of them with the intent for races and classes to be used as foreign keys for the character sheets. Users are able to view the individual races and classes wether they are signed in or not, but any CRUD operations are reserved purely for signed in users who's account is flagged with the admin boolean set to true.

This is achieved by using a method defined in the application controller to check if a user is an admin or not, if a non-admin user attempts to access this page via the url, they are redirected to the root path and given the message that they do not have permission to access that page.

###### Characters
I created the CharacterSheet model with the belongs_to: relationship for the user, races, and classes.

A user must be signed in to perform any CRUD operations to a Character Sheet and in order to perform any update or destroy methods, they must either be the user who created the character sheet or an admin user.

Creating a character sheet requires the signed in user to complete every element of the form presented in the view, including uploading a pdf file. The application will only accept pdf files which helps prevent malicious files being uploaded.

###### Reviews
The reviews model was created with the belongs_to: relationship for both users and character sheets.

Only a signed in user can create and delete a review from a character sheet.

In the character sheet model I also added the method to determine the average rating of the character sheets.

###### Favourites
The favourites model was created in a simple manner as it only needs the current user's id and the current character sheet being viewed to then use the create method to add a character sheet to a favourites list.

The signed in user can add and delete characters from the favourites as many times as they want and are also able to view all their favourites on a single page which can then go to the individual character sheets.

### Describe your projects models in terms of the relationships (active record associations) they have with each other

Active Record Associations connect models through declarations in the class definitions of the models. This means that all of the models can then work together as a complete app, instead of separate entities.

Below is an example of the hierarchy of the relationships between the models.

A user is created and data is then stored in the table with the relevant information. Races and Classes can only be created by a User who is an Admin, but races and classes do not belong to users.

A character sheet can only be created if a user is present. The character sheet is stored in it's own table which references the user's ID, the race ID selected, and the class ID selected.

The character has one attached file which is the pdf and must be uploaded in order to complete the character creation.

From there a user must be present in order to create a review for a character sheet, or to add/remove that character from their favourites list.

##### Here are the models and their relationships between each other:

###### User model
- has_many :reviews
- has_many :character_sheets
- has_many :favourites
- has_many :favourite_character_sheets, through: :favourites, source: :favourited, source_type: 'CharacterSheet'

###### Races and Classes model:
- has_many :character_sheets, dependent: :destroy

###### Character Sheet model:
- belongs_to :user
- belongs_to :character_class
- belongs_to :character_race
- has_many :reviews, dependent: :destroy
- has_one_attached :sheetupload

###### Favourites model:
- belongs_to :favourited, polymorphic: true
- belongs_to :user

###### Reviews model:
- belongs_to :user
- belongs_to :character_sheet

The has_one_attached in character sheet refers to active storage. It allows the character sheet to only have one attached pdf file. These are linked through AWS S3 storage, so there is no model declared for it.

### Discuss the database relations to be implemented in your application

The database relations are shown in the Entity Relationship Diagram (ERD) which represents how each entity is connected to each other. In addition to explaining the models, my app also features pdf file uploading and downloading which are stored using AWS S3.

<details>
<summary> User Table </summary>
The users table was created using the Devise Gem. This table holds the account set up data, such as:
<ul>
<li>User ID</li>
<li>Email Address</li>
<li>Password</li>
<li>Username</li>
<li>Is Admin (boolean)</li>
<li>Is Verified (boolean)</li>
</ul>
<p>The Admin attrtibute is a boolean that determines if a user account is an admin or not. At this current stage this attribute can only be enabled by doing so in the console for the application.</p>

<p>The verified boolean is not used in the current state of the app. It is intended for when payment is implemented in the future, that a verified user will be able to charge money for their character sheets as they are deemed premium content creators.</p>
</details>
<br>
<details>
<summary> Races Table </summary>
The Race table holds all the information about the different selectable races currently in the website. Its attributes include:
<ul>
<li>Race ID</li>
<li>Race Name</li>
<li>Description</li>
<li>Traits and features</li>
</ul>
<p>The Race table is rather simple as it all of the attributes consist of just strings for the name, description, and the traits and features of that race. CRUD operations can only be performed by a user who is flagged as an admin and races are not dependent on any entity as this was done by design since they should not be easily manipulated.</p>
</details>
<br>
<details>
<summary> Classes Table </summary>
The Classes table holds all the information about the different selectable classes currently in the website. Its attributes include:
<ul>
<li>Class ID</li>
<li>Class Name</li>
<li>Description</li>
<li>Desired Stats</li>
</ul>
<p>The Class table is rather simple as it all of the attributes consist of just strings for the name, description, and the desired stats of that class. CRUD operations can only be performed by a user who is flagged as an admin and classes are not dependent on any entity as this was done by design since they should not be easily manipulated.</p>
</details>
<br>
<details>
<summary> Character Sheet Table </summary>
The Character Sheet table is where all the data is stored when a user creates and uploads their character sheet. The attributes for this table includes:
<ul>
<li>CharacterSheet ID</li>
<li>Class ID(Foreign key from class table)</li>
<li>Race ID(Foreign key from race table)</li>
<li>User ID(Foreign key from user table)</li>
<li>Character Name</li>
<li>Description</li>
<li>Level</li>
<li>PDF file attached(foreign key from active storage blobs table as these are stored in AWS S3)</li>
</ul>
<p>The Character Sheet table is the most complex out of all tables currently present in the database. It can only be created by a signed in user and all attrtibutes must be filled out in the creation as it references the foreign keys for the user ID, Race ID, Class ID, and the active storage blobs foreign key.</p>
</details>
<br>
<details>
<summary> Favourites Table </summary>
The Favourites table is where the data is stored when a user adds a character to their favourites list. The attributes are as follows:
<ul>
<li>User ID(foreign key which is taken from the current user's ID that matches the ID present in the user table)</li>
<li>CharacterSheet ID(Foreign key from the character sheets table)</li>
</ul>
<p>The Favourites table uses the character sheet ID and currently signed in user's ID as foreign keys</p>
</details>
<br>
<details>
<summary>Active Storage Attachments and Blobs</summary>
The Active Storage Attachments are pdf files that are uploaded by Users when creating a character sheet on the website. Each character sheet has only one pdf file attached to it. The Active Storage Attachments table stores information such as:
<ul>
<li>name</li>
<li>Record Type</li>
<li>A record ID</li>
<li>A blob ID (a foreign key from the Active Storage Blob table)</li>
</ul>

The Active Storage Blobs Table connects with the Active Storage Attachments table, and sends the data of the attachment to AWS S3, which stores the actual attachment file. The information stored in the Active Storage Blobs Table is as follows:
<ul>
<li>Key</li>
<li>Filename</li>
<li>Content type</li>
<li>Metadata</li>
<li>Byte size</li>
</ul>
</details>

### Schema Design
Below is the schema file that has all of the above tables represented in it:

```
ActiveRecord::Schema.define(version: 2022_03_17_014223) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "character_classes", force: :cascade do |t|
    t.string "charclass_name", null: false
    t.string "description", null: false
    t.string "bis_stats", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "character_races", force: :cascade do |t|
    t.string "race_name", null: false
    t.string "description", null: false
    t.string "traits", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "character_sheets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "character_class_id"
    t.bigint "character_race_id"
    t.string "name"
    t.integer "level"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["character_class_id"], name: "index_character_sheets_on_character_class_id"
    t.index ["character_race_id"], name: "index_character_sheets_on_character_race_id"
    t.index ["user_id"], name: "index_character_sheets_on_user_id"
  end

  create_table "favourites", force: :cascade do |t|
    t.string "favourited_type"
    t.bigint "favourited_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["favourited_type", "favourited_id"], name: "index_favourites_on_favourited"
    t.index ["user_id"], name: "index_favourites_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.text "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "character_sheet_id"
    t.index ["character_sheet_id"], name: "index_reviews_on_character_sheet_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "username", null: false
    t.boolean "admin", default: false
    t.boolean "verified", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "character_sheets", "character_classes"
  add_foreign_key "character_sheets", "character_races"
  add_foreign_key "character_sheets", "users"
  add_foreign_key "reviews", "character_sheets"
  add_foreign_key "reviews", "users"
end
```
### Project Planning and management
Tracking the progress and management of this assessment was initially done with old fashioned pen and paper for writing down the basic ideas for my app and how it would work. I also drew by hand the initial design for my erd as it was quicker and easier for me to do it that way.

After getting approval for my idea, I had to make my erd more complex and then made that using LucidChart.

For actually tracking my app's progress I used a Trello board which the link can be found at the top of this readme file. I created the basic structure of things i needed to get done in the Trello board and then expanded upon that by adding checklists of all the little things belonging to that card and adding deadlines to help make sure I was on track.

After making the initial parts of my app I feel i fell a bit behind with keeping on top of my Trello board, unfortunately sometimes life gets in the way with a lot of things and my time to work on the project and manage it's progress became even more limited.

Creating apps in the future I will definitely follow the lessons learned in this assessment for how important planning and tracking progress is, even the amount I did this assessment helped save so much time for myself as I didn't need to think about what needs doing, I would simply look at my board.

### Final thoughts
Although facing the challenges of life and also the many challenges along the way of learning to piece together a rails application, I thoroughly enjoyed this assessment.

Even though I felt pretty stressed at times when things wouldn't work, it was an absolutely amazing experience finally getting things working after debugging my code!

I have enjoyed making this app so much so that in the future I plan to keep developing this further as a side project and maybe one day potentially turning it into a fully functioning platform that branches out further!
