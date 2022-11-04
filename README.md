# Clonebook API 

## Comment obtenir son bearer token 

![title](/public/bearer.png)

## Liste des routes

- Utiliser le bearer token dans les authorisations de Postman ou Insomnia
- Utiliser `http://localhost:3000/` ou `https://clonebook-api.herokuapp.com/`

La liste des commandes est commune aux URL de développement et de production, on peut récupérer la liste des utilisateurs avec par exemple `https://clonebook-api.herokuapp.com/api/v1/users` ou `http://localhost:3000/api/v1/users`, néamoins la majorité des fonctionnalités requièrent un bearer token ( càd d'être indentifié ).

### Authentification

1. Register `http://localhost:3000/users` POST
- `{
"user": {
    "username": "megatest",
    "email":"megatest@yopmail.com",
    "password":"123123"
}
}`
2. Login `http://localhost:3000/users/sign_in`POST
- `{
"user": {
    "email":"megatest@yopmail.com",
    "password":"123123"
}
}`
3. Logout `http://localhost:3000/users/sign_out`DELETE
4. Get confirmation token `http://localhost:3000/users/confirmation?confirmation_token=<YOUR TOKEN>` GET
5. Reset password `http://localhost:3000/users/sign_out` POST
- `{
    "user":
    {
        "email":"megatest@yopmail.com"
    }
}`
6. Reset password `http://localhost:3000/users/password` PATCH
- `{
 "user": {
      "reset_password_token": "Zws-da-He5JTdTnJkkkp",
      "password": "newpassword",
      "password_confirmation": "newpassword"
  }
}`
7. Get user by email ` http://localhost:3000/api/v1/getUserByEmail/megatest@yopmail.com`

### Posts

1. Create post `http://localhost:3000/api/v1/posts` POST
- `{
"post": {
    "content":"post-content",
    "image_link": "something"
}
}`
2. Get all posts `http://localhost:3000/api/v1/posts` GET
3. Get a single post `http://localhost:3000/api/v1/posts/51` GET
4. Delete a post `http://localhost:3000/api/v1/posts/26` GET
5. Update a post `http://localhost:3000/api/v1/posts/51` PUT
- `{
"post": {
    "content":"this a new post content"
}
}`
6. Delete last post `http://localhost:3000/api/v1/removePostDisplay` GET
7. Get post per user `http://localhost:3000/api/v1/posts/getOnlySelectedUserPosts/page/0/<Username>` GET
8. Get indexed posts `http://localhost:3000/api/v1/posts/page/0` GET
9. Get all posts from one user `http://localhost:3000/api/v1/users/2/getAllPostImagesFromUser` GET

#### Comments

1. Create comment `http://localhost:3000/api/v1/posts/1/comments` POST
- `{
"comment": {
    "content":"comment-content",
    "user_id": 3
}
}`
2. Delete comment `http://localhost:3000/api/v1/posts/40/comments/51` DELETE
3. Update comment `http://localhost:3000/api/v1/posts/2/comments/1` PUT
- `{
"comment": {
    "content":"this is a new comment content"

}
}`
4. Get all comments from one post `http://localhost:3000/api/v1/posts/2` GET

#### Likes

1. Create like `http://localhost:3000/api/v1/posts/53/likes` POST
2. Delete like `http://localhost:3000/api/v1/posts/53/likes/26` DELETE
3. Get all likes from one post `http://localhost:3000/api/v1/posts/51/likes` GET

### Others requests

1. Get all usernames `http://localhost:3000/api/v1/getAllUsernames` GET
2. Get specific user `http://localhost:3000/api/v1/users/1` GET
3. Update user avatar `http://localhost:3000/api/v1/createAvatar` POST ( form-data )
4. Update user hero `http://localhost:3000/api/v1/createThumbnail` POST  ( form-data )
5. Create friendship `http://localhost:3000/api/v1/users/3/friendships` POST
- `{
"friendship": {
    "user_id":1,
    "friend_id": 2
}
}`
6. Delete friendship `http://localhost:3000/api/v1/users/1/friendships/73` DELETE
7. Get current user invitation list `http://localhost:3000/api/v1/invitations` GET
8. Get user by username `http://localhost:3000/api/v1/profiles/<Username>` GET
9. Update user last_seen `http://localhost:3000/api/v1/updateLastSeen/113333` GET
10. Get all usernames ` http://localhost:3000/api/v1/getAllUsernames` GET
11. Get current_user friends including common_friendships ` http://localhost:3000/api/v1/users/1/common_friendships` GET
12. Get selected user suggestions list ` http://localhost:3000/api/v1/users/59/suggestions` GET
13. Get selected user friends including common_friendships ` http://localhost:3000/api/v1/selectedUserCM/Merlin` GET
