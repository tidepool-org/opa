package clinic

default clinic_read_allow = false
default patient_read_allow = false

clinicService := "clinic"
clinicServicePort := "8080"

# User access clinic

clinic_read_allow {
    trace("here\n")
    input.method = "POST"
    url := sprintf("http://%s:%s/clinics/access?clinicId=%s", [clinicService, clinicServicePort, input.clinic_id])
    response := http.send({
        "headers": {"X-TIDEPOOL-USERID": input.user_id},
        "method" : "GET",
        "url": url
    })
    #trace(sprintf("Response: %v", [response]))
    #trace(sprintf("status code: %d", [response.status_code]))
    response.status_code == 200
}

# User access another patient

patient_read_allow {
    trace("here\n")
    input.method = "POST"
    url := sprintf("http://%s:%s/clinics/access?patientId=%s", [clinicService, clinicServicePort, input.patient_id])
    response := http.send({
        "headers": {"X-TIDEPOOL-USERID": input.user_id},
        "method" : "GET",
        "url": url
    })
    #trace(sprintf("Response: %v", [response]))
    #trace(sprintf("status code: %d", [response.status_code]))
    response.status_code == 200
}
