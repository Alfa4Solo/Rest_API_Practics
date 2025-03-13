package main

import (
	"github.com/dgrijalva/jwt-go"
	"github.com/gin-gonic/gin"
	"net/http"
	"time"
)

type PC struct {
	ID        string `json:"id"`
	CPU       string `json:"CPU"`
	SysBoard  string `json:"SysBoard"`
	VideoCard string `json:"VideoCard"`
	SSD       string `json:"SSD"`
}

var comps = []PC{
	{ID: "1", CPU: "Intel Core i9-14900KF", SysBoard: "Intel Z790-A", VideoCard: "GeForce RTX 4090 Ti Super", SSD: "MSI Spatium M480 Pro 4ТБ"},
	{ID: "2", CPU: "Intel Core i7-14700KF", SysBoard: "Intel Z790", VideoCard: "GeForce RTX 4070 Ti Super", SSD: "Kingston Fury Renegade SFYRD"},
	{ID: "3", CPU: "Intel Core i7-10700F", SysBoard: "GIGABYTE Z490M", VideoCard: "GeForce RTX 1070 Super", SSD: "Patriot Viper 4 Blackout PVB48G320C6K DDR4 "},
}

var jwtKey = []byte("my_secret_key")

type Credentials struct {
	Username string `json:"username"`
	Password string `json:"password"`
}

var CredentialsList = []Credentials{
	{"John_Doe", "123456"},
	{"admin", "secret"},
	{"LimeOnfresh", "CherryBerry101"},
}

type Claims struct {
	Username string `json:"username"`
	Type     string `json:"type"`
	jwt.StandardClaims
}

func generateAccessToken(username string) (string, error) {
	expirationTime := time.Now().Add(5 * time.Minute)
	claims := &Claims{
		Username: username,
		Type:     "access",
		StandardClaims: jwt.StandardClaims{
			ExpiresAt: expirationTime.Unix(),
		},
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	return token.SignedString(jwtKey)
}

func generateRefreshToken(username string) (string, error) {
	expirationTime := time.Now().Add(7 * 24 * time.Hour)
	claims := &Claims{
		Username: username,
		Type:     "refresh",
		StandardClaims: jwt.StandardClaims{
			ExpiresAt: expirationTime.Unix(),
		},
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	return token.SignedString(jwtKey)
}

func register(c *gin.Context) {
	var creds Credentials
	if err := c.BindJSON(&creds); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"message": "invalid request"})
		return
	}
	CredentialsList = append(CredentialsList, creds)
	c.JSON(http.StatusOK, gin.H{"message": "success registration"})
}
func login(c *gin.Context) {
	var creds Credentials
	if err := c.BindJSON(&creds); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"message": "invalid request"})
		return
	}

	for _, cred := range CredentialsList {
		if creds.Username == cred.Username && creds.Password == cred.Password {
			accessToken, err := generateAccessToken(creds.Username)
			if err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"message": "could not create access token"})
				return
			}
			refreshToken, err := generateRefreshToken(creds.Username)
			if err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"message": "could not create refresh token"})
				return
			}
			c.JSON(http.StatusOK, gin.H{
				"access_token":  accessToken,
				"refresh_token": refreshToken,
			})
			return
		}
	}
	c.JSON(http.StatusUnauthorized, gin.H{"message": "unauthorized"})
}

func refresh(c *gin.Context) {
	var req struct {
		RefreshToken string `json:"refresh_token"`
	}
	if err := c.BindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"message": "invalid request"})
		return
	}

	claims := &Claims{}
	token, err := jwt.ParseWithClaims(req.RefreshToken, claims, func(token *jwt.Token) (interface{}, error) {
		return jwtKey, nil
	})

	if err != nil || !token.Valid || claims.Type != "refresh" {
		c.JSON(http.StatusUnauthorized, gin.H{"message": "invalid refresh token"})
		return
	}

	if time.Now().Unix() > claims.ExpiresAt {
		c.JSON(http.StatusUnauthorized, gin.H{"message": "refresh token expired"})
		return
	}

	newAccessToken, err := generateAccessToken(claims.Username)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "failed to generate access token"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"access_token": newAccessToken})
}

func authMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		tokenString := c.GetHeader("Authorization")
		if tokenString == "" {
			c.JSON(http.StatusUnauthorized, gin.H{"message": "unauthorized"})
			c.Abort()
			return
		}

		claims := &Claims{}
		token, err := jwt.ParseWithClaims(tokenString, claims, func(token *jwt.Token) (interface{}, error) {
			return jwtKey, nil
		})

		if err != nil || !token.Valid || claims.Type != "access" {
			c.JSON(http.StatusUnauthorized, gin.H{"message": "invalid token"})
			c.Abort()
			return
		}

		c.Next()
	}
}
func main() {
	router := gin.Default()
	router.POST("/register", register)
	router.POST("/login", login)
	router.POST("/refresh", refresh) // Добавленный маршрут

	protected := router.Group("/")
	protected.Use(authMiddleware())
	{
		protected.GET("/PC", getPC)
		protected.POST("/PC", createPC)
		// другие защищенные маршруты
	}

	router.Run(":8080")
}
func getPC(c *gin.Context) {
	c.JSON(http.StatusOK, comps)
}

func getPCbyID(c *gin.Context) {
	id := c.Param("id")
	for _, pc := range comps {
		if pc.ID == id {
			c.JSON(http.StatusOK, pc)
			return
		}
	}

	c.JSON(http.StatusNotFound, gin.H{"message": "Computer not found"})
}
func createPC(c *gin.Context) {
	var NewPC PC
	if err := c.BindJSON(&NewPC); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
	}
	comps = append(comps, NewPC)
	c.JSON(http.StatusCreated, NewPC)
}

func updatePC(c *gin.Context) {
	id := c.Param("id")
	var updatedPC PC
	err := c.BindJSON(&updatedPC)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"message": "Invalid request"})
		return
	}
	for _, pc := range comps {
		if pc.ID == id {
			c.JSON(http.StatusOK, updatedPC)
			return
		}
	}
	c.JSON(http.StatusNotFound, gin.H{"message": "Computer not found"})
}

func deletePC(c *gin.Context) {
	id := c.Param("id")
	for i, pc := range comps {
		if pc.ID == id {
			comps = append(comps[:i], comps[i+1:]...)
			c.JSON(http.StatusOK, gin.H{"message": "Computer deleted"})
			return
		}
	}
	c.JSON(http.StatusNotFound, gin.H{"message": "Computer not found"})
}
