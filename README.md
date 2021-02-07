## For server
1. First of all you need to install Golang, in this project we use Go v1.15.6 for development
2. Run `go mod download` inside `server` folder
3. Rename `.env.example` into `.env`, fill the variable
4. There is no database implementation yet, this is for simplify the app, without confusing setup database or stuff like that, just using slice at the go backend, which mean there is no persistance data store, because of that, we highly not recommend you using this app, or you must implementation the database first
5. We create dummy data for testing purpose, use which you like, or create your own, you can find implementation file at *`repository/impl/user.go`*
```json
 {
			ID:       "1",
			Name:     "Argana Phangquestian",
			Username: "arga",
			Email:    "arganaphangquestian@gmail.com",
			Password: "pass123",
		}, {
			ID:       "2",
			Name:     "Rahmat Deni",
			Username: "deni",
			Email:    "rahmatdeni@gmail.com",
			Password: "pass123",
		}, {
			ID:       "3",
			Name:     "Devina Vantissha",
			Username: "devina",
			Email:    "devinavantissha@gmail.com",
			Password: "pass123",
		}
```
6. If you like to limitted allow origin, feel free to change it in `main.go` file

## For mobile
1. Setup Flutter first, we use Flutter v1.25.0-4.0.pre(channel dev) for Development, well we develop using linux desktop for saving the resource **(ofcourse)**
2. Run `flutter pub get` inside `mobile` folder
3. Rename `.env.example` into `.env`, and fill the variable

### Todos
- [ ] Refresh Token Interceptor
- [ ] Retry Interceptor

### For web
1. Setup NodeJS, we use NodeJS v15.6 for development
2. Run `yarn` or `npm i` inside `web` folder
3. And open http://127.0.0.1:3000/