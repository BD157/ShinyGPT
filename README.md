

# ShinyGPT

This is a simple R Shiny project to demonstrate how to integrate a Large Language Model (LLM) backend (OpenAI-style API) into a Shiny application using clean, production-style patterns.

---

## What this project demonstrates

- Calling an external LLM API from R using HTTPS (R Package: httr2)
- Clean separation of **UI**, **backend client**, and **configuration**
- Secure secret handling via environment variables
- Button-triggered requests (no reactive overuse)
- A reusable API-client pattern that generalizes to other services

This same pattern applies to:
- Shiny → REST APIs  
- Shiny → FastAPI / Flask services  
- Shiny → Spark jobs  
- Shiny → internal enterprise services  

---

## Architecture

```
User input
   ↓
Shiny UI (app.R)
   ↓
Backend function (R/openai_client.R)
   ↓
LLM API (OpenAI / Azure OpenAI / internal proxy)
   ↓
Text response
```

**the UI never talks to the API directly** — all external calls go through a backend function.

---

## Repository structure

```
shinygpt/
├── app.R
├── R/
│   └── openai_client.R
├── README.md
├── .Renviron.example
├── .gitignore
```

---

## Requirements

- R (>= 4.0)
- Packages:
  - shiny
  - httr2
- An API key for an OpenAI-compatible endpoint

---

## Setup

### 1. Install dependencies

```r
install.packages(c("shiny", "httr2"))
```

### 2. Configure secrets

Copy the example environment file:

```bash
cp .Renviron.example .Renviron
```

Edit `.Renviron` and add your real API key:

```
OPENAI_API_KEY=your_real_key_here
```

Important:
- `.Renviron` is **gitignored**

---

## Run the app locally

From the project root:

```r
shiny::runApp()
```

The app will open in your browser.

---

## Design notes

The file `R/openai_client.R` contains all API logic:
- Builds the HTTP request
- Attaches authentication headers
- Sends JSON payloads
- Parses the response

This design makes it easy to:
- Swap public OpenAI → Azure OpenAI
- Point to an internal enterprise LLM
- Add logging, retries, or caching later

The **architecture stays the same**; only configuration changes.

---

## Public vs enterprise OpenAI

By default, this project targets:

```
https://api.openai.com/v1/responses
```

In a company environment, you would instead change:
- Endpoint URL
- Authentication method (AAD, managed identity, internal token)
- Deployment name / API version

The code structure remains unchanged.

---

## Why this project exists

- Understand API boundaries and contracts
- Integrate third-party services safely
- Know how to separate UI, logic, and secrets
- Implement a feature that scales beyond simple prototype


---

## License

MIT
