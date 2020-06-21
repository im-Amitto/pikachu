package main

import (
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"regexp"
	"strings"

	"github.com/otiai10/gosseract"
)

type user struct {
	Login    string
	Pass     string
	Age      string
	bGroup   string
	Location string
}

var storedData []user

func ocrImage(w http.ResponseWriter, r *http.Request) {
	fmt.Println("Endpoint Hit: ocrImage")
	r.ParseMultipartForm(32 << 20)
	file, handler, err := r.FormFile("image")
	if err != nil {
		fmt.Println(err)
		return
	}
	defer file.Close()
	f, err := os.OpenFile("./test/"+handler.Filename, os.O_WRONLY|os.O_CREATE, 0666)
	if err != nil {
		fmt.Println(err)
		return
	}
	defer f.Close()
	io.Copy(f, file)
	client := gosseract.NewClient()
	defer client.Close()
	client.SetImage("./test/" + handler.Filename)
	text, _ := client.Text()
	err = os.Remove("./test/" + handler.Filename)
	if err != nil {
		fmt.Println(err)
	}
	w.Write([]byte(text))

}

func loginCard(w http.ResponseWriter, r *http.Request) {
	fmt.Println("Endpoint Hit: loginCard")
	r.ParseMultipartForm(32 << 20)
	file, handler, err := r.FormFile("image")
	if err != nil {
		fmt.Println(err)
		return
	}
	defer file.Close()
	f, err := os.OpenFile("./test/"+handler.Filename, os.O_WRONLY|os.O_CREATE, 0666)
	if err != nil {
		fmt.Println(err)
		return
	}
	defer f.Close()
	io.Copy(f, file)
	client := gosseract.NewClient()
	defer client.Close()
	client.SetImage("./test/" + handler.Filename)
	text, _ := client.Text()
	err = os.Remove("./test/" + handler.Filename)
	if err != nil {
		fmt.Println(err)
	}
	text = removeBlankLines(text)
	usr, error := stringToUser(text)
	if error != "" {
		text = error
	} else {
		text = handleInput(usr, missingData(text))
	}
	w.Write([]byte(text))

}

func matchUser(usr1 user, usr2 user) bool {
	matched := true
	if usr1.Login != "?" && usr1.Login != "" && usr1.Login != usr2.Login {
		matched = false
	}
	if usr1.Pass != "?" && usr1.Pass != "" && usr1.Pass != usr2.Pass {
		matched = false
	}
	if usr1.Age != "?" && usr1.Age != "" && usr1.Age != usr2.Age {
		matched = false
	}
	if usr1.bGroup != "?" && usr1.bGroup != "" && usr1.bGroup != usr2.bGroup {
		matched = false
	}
	if usr1.Location != "?" && usr1.Location != "" && usr1.Location != usr2.Location {
		matched = false
	}
	return matched
}

func structToString(usr user) string {
	output := ""
	if usr.Login != "" {
		output += "Login: "
		output += usr.Login
		output += "\n"
	}
	if usr.Pass != "" {
		output += "Pass: "
		output += usr.Pass
		output += "\n"
	}
	if usr.Age != "" {
		output += "Age: "
		output += usr.Age
		output += "\n"
	}
	if usr.bGroup != "" {
		output += "Blood Group: "
		output += usr.bGroup
		output += "\n"
	}
	if usr.Location != "" {
		output += "Location: "
		output += usr.Location
		output += "\n"
	}
	return output
}

func handleInput(usr user, findUser bool) string {
	if findUser {
		userFound := false
		tempUsr := user{}
		for _, l := range storedData {
			if matchUser(usr, l) {
				userFound = true
				tempUsr = l
				break
			}
		}
		if userFound {
			return structToString(tempUsr)
		} else {
			return ("No user found")
		}
	} else {
		duplicate := false
		for _, l := range storedData {
			if l == usr {
				duplicate = true
			}
		}
		if duplicate {
			return ("Duplicate User")
		} else {
			storedData = append(storedData, usr)
			return ("User has been saved")
		}
	}
}

func stringToUser(str string) (user, string) {
	u := user{}
	s := strings.Split(str, "\n")
	for _, l := range s {
		if l == "" {
			continue
		}
		val := strings.Split(l, ": ")
		if len(val) != 2 {
			return u, "Invalid Input"
		}
		if val[0] == "Login" {
			u.Login = val[1]
		} else if val[0] == "Pass" {
			u.Pass = val[1]
		} else if val[0] == "Age" {
			u.Age = val[1]
		} else if val[0] == "Blood Group" {
			u.bGroup = val[1]
		} else if val[0] == "Location" {
			u.Location = val[1]
		} else {
			return u, "Invalid Input"
		}
	}
	return u, ""
}

func removeBlankLines(str string) string {
	regex, err := regexp.Compile("\n\n")
	if err != nil {
		return "regex error"
	}
	return regex.ReplaceAllString(str, "\n")
}

func missingData(str string) bool {
	s := strings.Split(str, "\n")

	for _, l := range s {
		if l == "" {
			continue
		}
		val := strings.Split(l, ": ")
		if strings.Contains(val[1], "?") {
			return true
		}
	}
	return false
}

func handleRequests() {
	http.HandleFunc("/ocrImage", ocrImage)
	http.HandleFunc("/loginCard", loginCard)
	log.Fatal(http.ListenAndServe(":5000", nil))
}

func main() {
	handleRequests()
}
