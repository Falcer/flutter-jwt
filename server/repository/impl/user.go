package impl

import (
	"fmt"

	"github.com/arganaphangquestian/flutter-jwt/server/model"
	"github.com/arganaphangquestian/flutter-jwt/server/repository"
	"github.com/segmentio/ksuid"
	"golang.org/x/crypto/bcrypt"
)

type (
	db struct {
		userDatabase []model.UserWithPassword
	}
)

// New UserRepository
func New() repository.UserRepository {
	bytes, _ := bcrypt.GenerateFromPassword([]byte("pass123"), 14)
	var users []model.UserWithPassword = []model.UserWithPassword{
		{
			ID:       "1",
			Name:     "Argana Phangquestian",
			Username: "arga",
			Email:    "arganaphangquestian@gmail.com",
			Password: string(bytes),
		}, {
			ID:       "2",
			Name:     "Rahmat Deni",
			Username: "deni",
			Email:    "rahmatdeni@gmail.com",
			Password: string(bytes),
		}, {
			ID:       "3",
			Name:     "Devina Vantissha",
			Username: "devina",
			Email:    "devinavantissha@gmail.com",
			Password: string(bytes),
		},
	}
	return &db{users}
}

func (d *db) GetUserByUsername(username string) (*model.UserWithPassword, error) {
	var user model.UserWithPassword
	for _, v := range d.userDatabase {
		if v.Username == username {
			user = model.UserWithPassword{
				ID:       v.ID,
				Name:     v.Name,
				Username: v.Name,
				Email:    v.Email,
				Password: v.Password,
			}
			break
		}
	}
	if user == (model.UserWithPassword{}) {
		return nil, fmt.Errorf("User not found")
	}
	return &user, nil
}

func (d *db) Register(register model.Register) (*model.User, error) {
	for _, v := range d.userDatabase {
		if v.Username == register.Username {
			return nil, fmt.Errorf("User already exist")
		}
	}
	userSave := model.UserWithPassword{
		ID:       ksuid.New().String(),
		Name:     register.Name,
		Username: register.Username,
		Email:    register.Email,
		Password: register.Password,
	}

	d.userDatabase = append(d.userDatabase, userSave)

	user := model.User{
		ID:       userSave.ID,
		Name:     userSave.Name,
		Username: userSave.Username,
		Email:    userSave.Email,
	}

	return &user, nil
}

func (d *db) GetAllUser() (*[]model.User, error) {

	var users []model.User
	for _, v := range d.userDatabase {
		user := model.User{
			ID:       v.ID,
			Name:     v.Name,
			Username: v.Name,
			Email:    v.Email,
		}
		users = append(users, user)
	}
	return &users, nil
}
