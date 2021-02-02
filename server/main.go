package main

import (
	"fmt"
	"log"
	"os"

	"github.com/arganaphangquestian/flutter-jwt/server/repository"
	repoImpl "github.com/arganaphangquestian/flutter-jwt/server/repository/impl"
	"github.com/arganaphangquestian/flutter-jwt/server/route"
	"github.com/arganaphangquestian/flutter-jwt/server/service"
	serviceImpl "github.com/arganaphangquestian/flutter-jwt/server/service/impl"
	"github.com/gofiber/fiber/v2"
	"github.com/joho/godotenv"
)

var (
	port           string
	userRepository repository.UserRepository
	userService    service.UserService
)

func init() {
	// Load ENV
	err := godotenv.Load("./.env")
	if err != nil {
		log.Println("Error load .env")
	}
	// Get PORT
	port = os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	// Set UserRePository
	userRepository = repoImpl.New()
	// Set UserService
	userService = serviceImpl.New(userRepository)
}

func main() {
	app := fiber.New()
	route.UserRoute(app, userService)
	log.Fatal(app.Listen(fmt.Sprintf(":%s", port)))
}
