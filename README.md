# Clonebook API

## Comment obtenir son bearer token 

![title](./src/assets/images/example.png)

## Liste des routes

*Utiliser le bearer token dans les authorisations de Postman ou Insomnia*
*Utiliser `http://localhost:3000/` ou `https://clonebook-api.herokuapp.com/`

### Authentification

1. Register `http://localhost:3000/users` POST
`{
"user": {
    "username": "megatest22222",
    "email":"megatest22222@yopmail.com",
    "password":"azeaze"
}
}`
2. Login `http://localhost:3000/users/sign_in`POST
3. Logout `http://localhost:3000/users/sign_out`DELETE
4. Get confirmation token `http://localhost:3000/users/confirmation?confirmation_token=<YOUR TOKEN>` GET
5. Reset password `http://localhost:3000/users/sign_out` POST
6. Reset password `http://localhost:3000/users/password` PATCH


