package main

/*import (
	"github.com/dgrijalva/jwt-go"
	"github.com/gin-gonic/gin"
	"net/http"
	"time"
)

var jwtKey = []byte("my_secret_key")

type Credentials struct {
	Username string `json:"username"`
	Password string `json:"password"`
}

type Claims struct {
	Username string `json:"username"`
	jwt.StandardClaims
}

var CredentialsList = []Credentials{
	{"John_Doe", "123456"},
	{"admin", "secret"},
	{"LimeOnfresh", "CherryBerry101"},
}

func generateToken(username string) (string, error) {
	expirationTime := time.Now().Add(5 * time.Minute)
	claims := &Claims{
		Username: username,
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
		if creds.Username == cred.Username || creds.Password == cred.Password {
			token, err := generateToken(creds.Username)
			if err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"message": "could not create token"})
				return
			}
			c.JSON(http.StatusOK, gin.H{"token": token})
			return
		}
	}
	c.JSON(http.StatusUnauthorized, gin.H{"message": "unauthorized"})
}

func authMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		tokenString := c.GetHeader("Authorization")
		if tokenString == "" {
			c.JSON(http.StatusUnauthorized, gin.H{"message": "unauthorized"})
		}
		claims := &Claims{}
		token, err := jwt.ParseWithClaims(tokenString, claims, func(token *jwt.Token) (interface{}, error) {
			return jwtKey, nil
		})

		if err != nil || !token.Valid {
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

	protected := router.Group("/")
	protected.Use(authMiddleware())
	{
		protected.GET("/PC", getPC)
		protected.POST("/PC", createPC)
		// другие защищенные маршруты
	}

	router.Run(":8080")
}
*/
