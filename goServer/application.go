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
	symptom1          string
	symptom2          string
	symptom3          string
	diseaseDiagnosed  string
	medicinePrescribd string
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
	if usr1.symptom1 != "?" && usr1.symptom1 != "" && usr1.symptom1 != usr2.symptom1 {
		matched = false
	}
	if usr1.symptom2 != "?" && usr1.symptom2 != "" && usr1.symptom2 != usr2.symptom2 {
		matched = false
	}
	if usr1.symptom3 != "?" && usr1.symptom3 != "" && usr1.symptom3 != usr2.symptom3 {
		matched = false
	}
	if usr1.diseaseDiagnosed != "?" && usr1.diseaseDiagnosed != "" && usr1.diseaseDiagnosed != usr2.diseaseDiagnosed {
		matched = false
	}
	if usr1.medicinePrescribd != "?" && usr1.medicinePrescribd != "" && usr1.medicinePrescribd != usr2.medicinePrescribd {
		matched = false
	}
	return matched
}

func structToString(usr user) string {
	output := ""
	if usr.symptom1 != "" {
		output += "Symptom 1: "
		output += usr.symptom1
		output += "\n"
	}
	if usr.symptom2 != "" {
		output += "Symptom 2: "
		output += usr.symptom2
		output += "\n"
	}
	if usr.symptom3 != "" {
		output += "Symptom 3: "
		output += usr.symptom3
		output += "\n"
	}
	if usr.diseaseDiagnosed != "" {
		output += "Disease diagnosed: "
		output += usr.diseaseDiagnosed
		output += "\n"
	}
	if usr.medicinePrescribd != "" {
		output += "Medicine prescribed: "
		output += usr.medicinePrescribd
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
			return ("Duplicate Prescription")
		} else {
			storedData = append(storedData, usr)
			return ("Prescription has been saved")
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
		if strings.ToLower(val[0]) == "symptom 1" {
			u.symptom1 = val[1]
		} else if strings.ToLower(val[0]) == "symptom 2" {
			u.symptom2 = val[1]
		} else if strings.ToLower(val[0]) == "symptom 3" {
			u.symptom3 = val[1]
		} else if strings.ToLower(val[0]) == "disease diagnosed" {
			u.diseaseDiagnosed = val[1]
		} else if strings.ToLower(val[0]) == "medicine prescribed" {
			u.medicinePrescribd = val[1]
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
