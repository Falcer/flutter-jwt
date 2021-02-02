package repository

import (
	"github.com/arganaphangquestian/flutter-jwt/server/model"
)

type (
	// UserRepository interface
	UserRepository interface {
		GetUserByUsername(username string) (*model.UserWithPassword, error)
		Register(register model.Register) (*model.User, error)
		GetAllUser() (*[]model.User, error)
	}
)
