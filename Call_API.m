(Page as text) =>
let
  url = "http://rest.oobj-dfe.com.br/session",

  body = "
  [
    {
    }
  ]
",

  getToken = 
    Web.Contents(
      url,
        [
          Headers = [
            #"Content-Type"="application/json", 
            #"Authorization"="Basic NjFjNmM5Y2FhYTJhZDgzYWFlMWExMjQ5YzY3YzEwYjY6MDUwMWFiNTIzYddds2VlMzgyODNmOTE1YmQ4MjliNTg1MTM=" // Fictício
              ], 
            Content = Text.ToBinary(body)
        ]
  ),

Token = getToken[jwt],   
// Dados Fictícios
Body = "{
  ""cnpj"": ""052070552076000297"", 
  ""comXml"": false,
  ""dataFinal"": """&Text.From(20220101)&""",
  ""dataInicial"": """&Text.From(20220131)&""",
  ""modelo"": 55,
  ""pagina"": """&Page&""",
  ""tipoAmbiente"": ""prod""
}", 

  Dados = Json.Document(
    Web.Contents(
      "http://rest.oobj-dfe.com.br/api/relatorios/recebidos/",
      [
      Headers =[#"Content-Type"="application/json", #"x-auth-token" = "eyJhbGciOiJIUzUxMiJ9.edsdsyJzdWfsIiOiI2MWM2YzljYWFhMmFkODNhYWUxYTEyNDljNjdjMTBiNiIsImF1ZCI6IndlYiIsImV4cCI6MTY2ODc5ODU2MCwiaWF0IjoxNjY4NzEyMTYwfQ.a7W1tGOMzqvrKTPJ-GU_f4tP1rkD24dHL-6aO2xYCMaXhL7CXHrBdpHEaxmDXAPtBDFghHkKOix4_mrCbc57Ag"], // Fictício
      Content = Text.ToBinary(Body)
      ] 
    )
  )
in 
Dados