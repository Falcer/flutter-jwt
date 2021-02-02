package impl

import (
	"fmt"
	"os"
	"time"

	"github.com/arganaphangquestian/flutter-jwt/server/model"
	"github.com/arganaphangquestian/flutter-jwt/server/repository"
	"github.com/arganaphangquestian/flutter-jwt/server/service"
	"github.com/dgrijalva/jwt-go"
	"golang.org/x/crypto/bcrypt"
)

type (
	repo struct {
		repo repository.UserRepository
	}
)

// New UserRepository
func New(userRepo repository.UserRepository) service.UserService {
	return &repo{userRepo}
}

func (r *repo) Login(login model.Login) (*model.UserToken, error) {
	userRes, err := r.repo.GetUserByUsername(login.Username)
	if err != nil {
		return nil, err
	}

	passwordMatch := comparePassword(userRes.Password, login.Password)

	if !passwordMatch {
		return nil, fmt.Errorf("Incorrect Username or Password")
	}

	user := model.User{
		ID:       userRes.ID,
		Name:     userRes.Name,
		Username: userRes.Username,
		Email:    userRes.Email,
	}

	userToken, err := createToken(user.ID)
	if err != nil {
		return nil, err
	}

	return userToken, nil
}

func (r *repo) Register(register model.Register) (*model.User, error) {
	hashPassword, err := passwordHash(register.Password)
	if err != nil {
		return nil, err
	}
	register.Password = hashPassword
	return r.repo.Register(register)
}

func (r *repo) GetAllUser() (*[]model.User, error) {
	return r.repo.GetAllUser()
}

func (r *repo) RefreshToken(refeshToken string) (*model.UserToken, error) {
	claims := jwt.MapClaims{}
	token, err := jwt.ParseWithClaims(refeshToken, claims, func(token *jwt.Token) (interface{}, error) {
		if jwt.GetSigningMethod("HS256") != token.Method {
			return nil, fmt.Errorf("Unexpected signing method: %v", token.Header["alg"])
		}
		return []byte(os.Getenv("SECRET_KEY")), nil
	})

	if err != nil {
		return nil, fmt.Errorf("Error : %s", err)
	}
	if !token.Valid {
		return nil, fmt.Errorf("Token not valid")
	}
	newToken, err := createToken(claims["user"].(string))
	return newToken, err
}

func passwordHash(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), 14)
	return string(bytes), err
}

func comparePassword(hash, password string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password))
	return err == nil
}

func createToken(userID string) (*model.UserToken, error) {
	// Refresh Token
	refreshToken := jwt.MapClaims{}
	refreshToken["authorize"] = true
	refreshToken["id"] = userID
	refreshToken["exp"] = time.Now().Add(time.Minute * 5).Unix() // 5 Minutes
	rt := jwt.NewWithClaims(jwt.SigningMethodHS256, refreshToken)
	rToken, err := rt.SignedString([]byte(os.Getenv("SECRET_KEY")))
	if err != nil {
		return nil, err
	}

	// Access Token
	accessToken := jwt.MapClaims{}
	accessToken["authorize"] = true
	accessToken["id"] = userID
	accessToken["exp"] = time.Now().Add(time.Hour * 24 * 30 * 12 * 5).Unix() // 5 years
	at := jwt.NewWithClaims(jwt.SigningMethodHS256, accessToken)
	aToken, err := at.SignedString([]byte(os.Getenv("SECRET_KEY")))
	if err != nil {
		return nil, err
	}

	return &model.UserToken{
		RefreshToken: rToken,
		AccessToken:  aToken,
	}, nil
}
