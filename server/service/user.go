package service

import (
	"github.com/arganaphangquestian/flutter-jwt/server/model"
)

type (
	// UserService interface
	UserService interface {
		Login(login model.Login) (*model.UserToken, error)
		Register(register model.Register) (*model.User, error)
		GetAllUser() (*[]model.User, error)
		RefreshToken(refeshToken string) (*model.UserToken, error)
	}
)
