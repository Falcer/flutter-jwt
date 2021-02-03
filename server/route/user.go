package route

import (
	"strings"

	"github.com/arganaphangquestian/flutter-jwt/server/model"
	"github.com/arganaphangquestian/flutter-jwt/server/service"
	"github.com/gofiber/fiber/v2"
)

type userRoute struct {
	service service.UserService
}

func (u *userRoute) getAllUser(ctx *fiber.Ctx) error {
	var token string
	header := strings.Split(ctx.Get("Authorization"), " ")

	if header[0] != "Bearer" {
		return ctx.Status(401).JSON(&fiber.Map{
			"success": false,
			"message": "Authorization Header prefix must be 'Bearer'",
			"data":    nil,
		})
	}

	if len(header) != 2 {
		return ctx.Status(401).JSON(&fiber.Map{
			"success": false,
			"message": "Authorization Header incorrect",
			"data":    nil,
		})
	}

	token = header[1]

	if err := u.service.Verify(token); err != nil {
		return ctx.Status(401).JSON(&fiber.Map{
			"success": false,
			"message": "Authorization incorrect",
			"data":    nil,
		})
	}

	users, err := u.service.GetAllUser()
	if err != nil {
		return ctx.Status(500).JSON(&fiber.Map{
			"success": false,
			"message": err.Error(),
			"data":    nil,
		})
	}
	return ctx.Status(200).JSON(&fiber.Map{
		"success": true,
		"message": "Get all users",
		"data":    users,
	})
}

func (u *userRoute) register(ctx *fiber.Ctx) error {
	r := new(model.Register)
	if err := ctx.BodyParser(r); err != nil {
		return ctx.Status(500).JSON(&fiber.Map{
			"success": false,
			"message": "Register Failed",
			"data":    nil,
		})
	}
	user, err := u.service.Register(*r)
	if err != nil {
		return ctx.Status(500).JSON(&fiber.Map{
			"success": false,
			"message": err.Error(),
			"data":    nil,
		})
	}
	return ctx.Status(201).JSON(&fiber.Map{
		"success": true,
		"message": "Register successfully",
		"data":    &user,
	})
}

func (u *userRoute) login(ctx *fiber.Ctx) error {

	l := new(model.Login)
	if err := ctx.BodyParser(l); err != nil {
		return ctx.Status(500).JSON(&fiber.Map{
			"success": false,
			"message": "Login Failed",
		})
	}
	token, err := u.service.Login(*l)
	if err != nil {
		return ctx.Status(401).JSON(&fiber.Map{
			"success": false,
			"message": err.Error(),
			"data":    nil,
		})
	}
	return ctx.Status(200).JSON(&fiber.Map{
		"success": true,
		"message": "Login success",
		"data":    &token,
	})
}

func (u *userRoute) refresh(ctx *fiber.Ctx) error {
	var token string
	header := strings.Split(ctx.Get("Authorization"), " ")

	if header[0] != "Bearer" {
		return ctx.Status(401).JSON(&fiber.Map{
			"success": false,
			"message": "Authorization Header prefix must be 'Bearer'",
			"data":    nil,
		})
	}

	if len(header) != 2 {
		return ctx.Status(401).JSON(&fiber.Map{
			"success": false,
			"message": "Authorization Header incorrect",
			"data":    nil,
		})
	}

	token = header[1]

	newToken, err := u.service.RefreshToken(token)

	if err != nil {
		return ctx.Status(401).JSON(&fiber.Map{
			"success": false,
			"message": err.Error(),
			"data":    nil,
		})
	}
	return ctx.Status(200).JSON(&fiber.Map{
		"success": true,
		"message": "Login success",
		"data":    &newToken,
	})
}

// UserRoute New()
func UserRoute(app *fiber.App, userService service.UserService) {
	route := &userRoute{userService}
	app.Get("/users", route.getAllUser)
	app.Post("/login", route.login)
	app.Post("/register", route.register)
	app.Post("/refresh", route.refresh)
}
