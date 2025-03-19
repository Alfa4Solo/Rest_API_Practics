package main

import (
	"github.com/gin-gonic/gin"
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
	dsn := "host=localhost user=postgres password=123456 dbname=postgres port=5432 sslmode=disable"
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

func getDealerbyID(c *gin.Context) {
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
	if err := db.Model(&dealer{}).Where("id = ?", id).Updates(updatedDealer).Error; err != nil {
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
func main() {
	initDB()
	println("Starting server...")
	router := gin.Default()

	router.GET("/Dealers", getDealers)
	router.GET("/Dealers/:id", getDealerbyID)
	router.POST("/Dealers", createDealer)
	router.PUT("/Dealers/:id", updateDealer)
	router.DELETE("/Dealers/:id", deleteDealer)

	router.Run(":8080")
}
