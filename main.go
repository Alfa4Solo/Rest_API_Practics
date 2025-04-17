package main

import (
	"github.com/gin-gonic/gin"
	"golang.org/x/time/rate"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"log"
	"net/http"
)

type dealer struct {
	id_dealer    uint   `gorm:"primary_key" json:"id_dealer"`
	company      string `json:"company"`
	adress       string `json:"adress"`
	phone_number string `json:"phone_number"`
	seo          string `json:"seo"`
}

var db *gorm.DB

func initDB() {
	dsn := "host=178.250.158.143 user=alterusr password=bespravni_lox dbname=serverdb port=5432 sslmode=disable"
	var err error
	db, err = gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatal("Failed to connect to database:", err)
	}
	db.AutoMigrate(&dealer{})
}

func getDealers(c *gin.Context) {
	var dealers []dealer
	db.Find(&dealers)
	c.JSON(http.StatusOK, dealers)
}

func getDealerByID(c *gin.Context) {
	id := c.Param("id")
	var dealer []dealer
	if err := db.First(&dealer, id).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"message": "Dealer not found"})
		return
	}
	c.JSON(http.StatusOK, dealer)
}

func createDealer(c *gin.Context) {
	var NewDealer dealer
	if err := c.BindJSON(&NewDealer); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
	}
	db.Create(&NewDealer)
	c.JSON(http.StatusCreated, NewDealer)
}

func updateDealer(c *gin.Context) {
	id := c.Param("id")
	var updatedDealer dealer
	err := c.BindJSON(&updatedDealer)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"message": "Invalid request"})
		return
	}
	if err := db.Model(&dealer{}).Where("id_dealer = ?", id).Updates(updatedDealer).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"message": "Dealer not found"})
		return
	}
	c.JSON(http.StatusOK, updatedDealer)
}

func deleteDealer(c *gin.Context) {
	id := c.Param("id")
	if err := db.Delete(&dealer{}, id).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"message": "Dealer not found"})
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Computer deleted"})
}

var limiter = rate.NewLimiter(1, 5)

func rateLimiter(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if !limiter.Allow() {
			http.Error(w, "Too Many Requests", http.StatusTooManyRequests)
			return
		}
		next.ServeHTTP(w, r)
	})
}

func main() {
	initDB()
	router := gin.Default()
	router.Use(func(c *gin.Context) {
		c.Writer.Header().Set("Access-Control-Allow-Origin", "*")
		c.Writer.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE")
		c.Writer.Header().Set("Access-Control-Allow-Headers", "Content-Type")
		if c.Request.Method == "OPTIONS" {
			c.AbortWithStatus(204)
			return
		}
		c.Next()
	})

	router.GET("/dealers", getDealers)
	router.GET("/dealers/:id", getDealerByID)
	router.POST("/dealers", createDealer)
	router.PUT("/dealers/:id", updateDealer)
	router.DELETE("/dealers/:id", deleteDealer)
	router.Run(":8090")
}
