package main

import (
	"github.com/gin-gonic/gin"
	"net/http"
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

func main() {

	router := gin.Default()

	router.GET("/ping", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"message": "pong"})
	})
	router.GET("/PC", getPC)
	router.GET("/PC/:id", getPCbyID)
	router.POST("/PC", createPC)
	router.PUT("/PC/:id", updatePC)
	router.DELETE("/PC/:id", deletePC)
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
